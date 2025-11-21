import UIKit

// 프로토콜 선언
// interface 개념
// 역할: "다시 로그인 기능을 구현해야 해!"라는 계약서
protocol WelcomeReloginDelegate: AnyObject {
    func retryLogin(_ viewController: UIViewController, didTapReloginWith message: String)
}

final class WelcomeViewController_Delegate: UIViewController {
    
    var name: String? // named값은 있을 수도 있고 없을수도
    
    weak var delegate: WelcomeReloginDelegate?
    // weak: 순환 참조 방지
    // LoginViewController → WelcomeViewController (strong)
    // WelcomeViewController → LoginViewController (weak)

    // var: 나중에 설정되므로 변경 가능해야 함
    // WelcomeReloginDelegate?: 프로토콜 타입, 옵셔널
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: (UIScreen.main.bounds.width - 150) / 2, y: 87, width: 150, height: 150))
        imageView.image = UIImage(named: "karrot_rabbit")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private func bindID() {
        // name이 nil이면 아무 일도 일어나지 않음
        name.map { self.welcomeLabel.text = "\($0)님 \n반가워요!" }
    }
    
    private let welcomeLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: (UIScreen.main.bounds.width - 95) / 2, y: 295, width: 95, height: 60))
        label.font = UIFont(name: "Pretendard-ExtraBold", size: 25)
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
    private var goHomeButton: UIButton = {
        //        let button = UIButton(frame: CGRect(x: 20, y: 426, width: 335, height: 58))
        let button = UIButton(frame: CGRect(x: (UIScreen.main.bounds.width - 335) / 2, y: 426, width: 335, height: 58))
        button.backgroundColor = .primaryOrange
        button.setTitle("메인으로", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 6
        button.titleLabel?.font = UIFont(name: "Pretendard-Bold", size: 18)
        return button
    }()
    
    private lazy var backToLoginButton: UIButton = {
        let button = UIButton(frame: CGRect(x: (UIScreen.main.bounds.width - 335) / 2, y: 498, width: 335, height: 58))
        button.backgroundColor = .grey200
        button.setTitle("다시 로그인", for: .normal)
        button.setTitleColor(.grey400, for: .normal)
        button.layer.cornerRadius = 6
        button.titleLabel?.font = UIFont(name: "Pretendard-Bold", size: 18)
        button.addTarget(self, action: #selector(backToLoginButtonDidTap), for: .touchUpInside)
        
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        setLayout()
        bindID()
    }
    
    
    private func setLayout() {
        [logoImageView, welcomeLabel, goHomeButton, backToLoginButton].forEach {
            //            $0.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview($0)
        }
    }
    
    @objc
    private func backToLoginButtonDidTap() {
        
        delegate?.retryLogin(self, didTapReloginWith: "다시 로그인 버튼을 눌렀어요!") // 옵셔널 체이닝
        // delegate는 weak이므로 LoginViewController를 안전하게 참조
        // 만약 LoginViewController가 이미 해제되었다면 delegate는 자동으로 nil이 됨
        
        if self.navigationController == nil {
            self.dismiss(animated: true)
        } else {
            self.navigationController?.popViewController(animated: true)
            // Navigation Stack에서 WelcomeViewController 제거
            // welcomeViewController 참조 카운트: 0
            // → ARC가 자동으로 메모리 해제!
        }
    }
}
