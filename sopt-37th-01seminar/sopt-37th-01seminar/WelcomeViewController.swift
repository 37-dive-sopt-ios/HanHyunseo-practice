import UIKit

final class WelcomeViewController: UIViewController {
    
    var name: String? // named값은 있을 수도 있고 없을 수 도 있음
    
    //    private func bindID() {
    //        guard let name = name else { return }
    //        self.welcomeLabel.text = "\(name)님 \n반가워요!"
    //    }
    
    //    private func bindID() {
    //        if let name = name {
    //            self.welcomeLabel.text = "\(name)님 \n반가워요!"
    //        } else {
    //            self.welcomeLabel.text = "환영합니다!"
    //        }
    //    }
    
    
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
        if self.navigationController == nil {
            self.dismiss(animated: true)
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
}

