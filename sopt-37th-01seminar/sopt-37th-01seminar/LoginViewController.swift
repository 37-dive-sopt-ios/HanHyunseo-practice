//
//  LoginViewController.swift
//  sopt-37th-01Seminar
//
//  Created by 이명진 on 9/16/25.
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARK: - UI Components
    
    lazy var titleLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: (self.view.bounds.width - 250) / 2, y: 163, width: 250, height: 80))
        label.text = "동네라서 가능한 모든 것\n 당근에서 가까운 이웃과 함께해요."
        label.textAlignment = .center // 가운데 정렬
        label.numberOfLines = 2 // 두 줄에 걸쳐서 출력
        label.font =  UIFont(name: "Pretendard-Bold", size: 18.0) // 폰트 설정
        return label
    }()
    
    
    lazy var idTextField: UITextField = {
        let textField = UITextField(frame: CGRect(x: (self.view.bounds.width - 335) / 2, y: 276, width: 335, height: 52))
        textField.placeholder = "아이디"
        textField.borderStyle = .none // 기본 borderStyle 제거
        textField.backgroundColor = .grey200 // asset에 저장해놓은 grey200 불러 옴
        textField.layer.cornerRadius = 3 // 꼭짓점 둥글게
        // 텍스트 필드 좌우 패딩 추가
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 23, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.rightViewMode = .always
        // 폰트
        textField.font = UIFont(name: "Pretendard-SemiBold", size: 14.0)
        return textField
    }()
    
    lazy var passwordTextField: UITextField = {
        let textField = UITextField(frame: CGRect(x: (self.view.bounds.width - 335) / 2, y: 335, width: 335, height: 52))
        textField.placeholder = "비밀번호"
        textField.borderStyle = .none
        textField.isSecureTextEntry = true // 복붙 막아놓음
        textField.backgroundColor = .grey200
        textField.layer.cornerRadius = 3
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 23, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.rightViewMode = .always
        textField.font = UIFont(name: "Pretendard-SemiBold", size: 14.0)
        return textField
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton(frame: CGRect(x: (self.view.bounds.width - 335) / 2, y: 422, width: 335, height: 52))
        button.setTitle("로그인하기", for: .normal)
        button.backgroundColor = .primaryOrange
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 6
        button.addTarget(self, action: #selector(loginButtonDidTap), for: .touchUpInside)
        button.titleLabel?.font = UIFont(name: "Pretendard-Bold", size: 18.0)
        return button
    }()
    
    // 새로운 컴포넌트: UISwitch - 자동 로그인 토글
    lazy var autoLoginSwitch: UISwitch = {
        let toggle = UISwitch(frame: CGRect(x: (self.view.bounds.width - 335) / 2 + 335 - 51, y: 490, width: 51, height: 31))
        toggle.isOn = false // 초기 상태 꺼짐
        toggle.onTintColor = .primaryOrange // 켜졌을 때 색상
        toggle.thumbTintColor = .white // 토글 손잡이 색상
        toggle.addTarget(self, action: #selector(autoLoginSwitchChanged), for: .valueChanged)
        return toggle
    }()
    
    lazy var autoLoginLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: (self.view.bounds.width - 335) / 2, y: 495, width: 100, height: 20))
        label.text = "자동 로그인"
        label.font = UIFont(name: "Pretendard-Medium", size: 14.0)
        label.textColor = .gray
        return label
    }()
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI() // 함수
        setHierarchy()
    }
    
    // MARK: - UI & Layout
    
    private func setUI() {
        view.backgroundColor = .white
    }
    
    private func setHierarchy() {
        let components = [
            titleLabel,
            idTextField,
            passwordTextField,
            loginButton,
            autoLoginSwitch,
            autoLoginLabel
        ]
        
        components.forEach { view.addSubview($0) }
    }
    
    private func presentToWelcomeVC(){
        let vc = WelcomeViewController()
        //        vc.modalPresentationStyle = .fullScreen
        //        vc.modalPresentationStyle = .overFullScreen
        //        vc.modalTransitionStyle = .crossDissolve
        vc.name = idTextField.text
        self.present(vc, animated: true)
    }
    
    private func pushToWelcomeVC() {
        let welcomeViewController = WelcomeViewController()
        welcomeViewController.name = idTextField.text
        self.navigationController?.pushViewController(welcomeViewController, animated: true)
    }
    
    @objc // iOS개발은 원래 objectC로 하고있었음. 내부 프레임워크에서 아직 남아있기 때문에 그 코드를 스위프트 코드에서 사용할 수 있게 만들 수 있는 역할
    private func loginButtonDidTap() {
        //        presentToWelcomeVC() // 모달
        pushToWelcomeVC() // 페이지 이동
    }
    
    @objc
    private func autoLoginSwitchChanged(_ sender: UISwitch) {
        // (_ sender: UISwitch): 이벤트를 보낸 객체(UISwitch 인스턴스)를 파라미터로 받음
        if sender.isOn {
            showToast(message: "자동 로그인이 활성화되었습니다")
        } else {
            showToast(message: "자동 로그인이 비활성화되었습니다")
        }
    }

    private func showToast(message: String) { // message: 토스트에 보여줄 문자열
        let toastLabel = UILabel(frame: CGRect(
            x: (self.view.frame.width - 250) / 2, // 수평 중앙 정렬
            y: self.view.frame.height - 150, // 화면 하단에 뜨게 함
            width: 250,
            height: 40
        ))
        
        toastLabel.backgroundColor = .grey400
        toastLabel.textColor = .white
        toastLabel.font = UIFont(name: "Pretendard-Medium", size: 14.0)
        toastLabel.textAlignment = .center
        toastLabel.text = message // 표시할 텍스트 지정(호출부에서 전달된 메시지)
        toastLabel.alpha = 0.0 // 처음엔 완전 투명
        toastLabel.layer.cornerRadius = 10
        toastLabel.clipsToBounds = true
        
        self.view.addSubview(toastLabel) // 생성한 라벨을 뷰 계층에 추가 -> 화면에 보이게 됨
        
        UIView.animate(withDuration: 0.5, animations: {
            toastLabel.alpha = 1.0 // 0.5초동안 투명도 1로 보이게 됨
        }) { _ in
            UIView.animate(withDuration: 0.5, delay: 1.5, options: .curveEaseOut, animations: {
                toastLabel.alpha = 0.0 // 1.5초 뒤에 0.5초동안 투명도 0으로 사라지게 됨, options: .curveEaseOut: 종료 시점에 부드럽게 사라짐
            }) { _ in
                toastLabel.removeFromSuperview() // 뷰 제거
            }
        }
    }
    
}
