//
//  LoginViewController.swift
//  SAIT
//
//  Created by 이머영 on 7/10/26.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var scrollContentView: UIView!
    
    // =========================
    // MARK: View LifeCycle Func
    // =========================
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.alwaysBounceVertical = false
        scrollView.showsVerticalScrollIndicator = false

        configureUI()
    }
    
    /// 2026.08.08
    /// 화면이 남아도 스크롤바가 생기는 문제때문에 테스트 할때 사용
    /// 현재는 아래의 코드가 없어도 스토리보드에서 크기 및 Auto Layout 을 조정했기 때문에 문제없음
    /// 
    /*override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        view.layoutIfNeeded()
        let contentHeight = scrollContentView.bounds.height
        let visibleHeight = scrollView.bounds.height
        
        let needsScroll = contentHeight > visibleHeight + 1
        
        scrollView.isScrollEnabled = needsScroll
        scrollView.alwaysBounceVertical = false
        scrollView.showsVerticalScrollIndicator = needsScroll
        
        print("contentHeight:", contentHeight) // ScrollView 안에 들어있는 실제 컨텐츠 뷰의 높이
        print("visibleHeight:", visibleHeight) // 현재 화면에서 ScrollView 가 실제 보여줄 수 있는 높이
        print("scrollView.contentSize:", scrollView.contentSize) // ScrollView 가 알고 있는 내 컨텐츠의 크기
        print("needsScroll:", needsScroll) // 컨텐츠가 화면보다 크다: true || 컨텐츠가 화면보다 작다: false
    }*/
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    // ====================
    // MARK: User Interface
    // ====================
    private func configureUI() {
        title = ""
        
        loginIdTextField.delegate = self
        passwordTextField.delegate = self
        
        configureSocialButtons()
        configureEmailTextField()
        configurePasswordTextField()
        configureLoginButton()
        configureFindButtons()
        configureSignUpButton()
        
    }
    
    // ==================
    // MARK: Social Login
    // ==================
    @IBOutlet weak var appleLoginButton: UIButton!
    @IBOutlet weak var kakaoLoginButton: UIButton!
    @IBOutlet weak var naverLoginButton: UIButton!
    
    @IBAction func didTapAppleLogin(_ sender: Any) {
        print("Apple Login")
    }
    
    @IBAction func didTapKakaoLogin(_ sender: Any) {
        print("Kakao Login")
    }
    
    @IBAction func didTapNaverLogin(_ sender: Any) {
        print("Naver Login")
    }
    
    private func configureSocialButtons() {
        configureSocialButton(
            button: appleLoginButton,
            title: "Apple로 로그인",
            image: UIImage(systemName: "apple.logo"),
            backgroundColor: .black,
            foregroundColor: .white,
            iconSize: 26
        )
        
        configureSocialButton(
            button: kakaoLoginButton,
            title: "카카오로 로그인",
            image: UIImage(named: "kakaoLogo"),
            backgroundColor: UIColor(
                red: 254 / 255,
                green: 229 / 255,
                blue: 0,
                alpha: 1
            ),
            foregroundColor: UIColor(
                red: 25 / 255,
                green: 25 / 255,
                blue: 25 / 255,
                alpha: 1
            ),
            iconSize: 32
        )
        
        configureSocialButton(
            button: naverLoginButton,
            title: "네이버로 로그인",
            image: UIImage(named: "naverLogo"),
            backgroundColor: UIColor(
                red: 3 / 255,
                green: 199 / 255,
                blue: 90 / 255,
                alpha: 1
            ),
            foregroundColor: .white,
            iconSize: 32
        )
    }
    
    private func configureSocialButton(
        button: UIButton,
        title: String,
        image: UIImage?,
        backgroundColor: UIColor,
        foregroundColor: UIColor,
        iconSize: CGFloat
    ) {
        // 기존 UIButton.Configuration 제거
        button.configuration = nil

        // Storyboard에 설정된 title/image 제거
        button.setTitle(nil, for: .normal)
        button.setImage(nil, for: .normal)

        // 버튼 디자인
        button.backgroundColor = backgroundColor
        button.layer.cornerRadius = 12
        button.clipsToBounds = true

        // 아이콘
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = foregroundColor
        imageView.isUserInteractionEnabled = false

        // 텍스트
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = title
        label.textColor = foregroundColor
        label.font = .systemFont(ofSize: 16, weight: .semibold)
//        label.textAlignment = .left
        label.isUserInteractionEnabled = false

        button.addSubview(imageView)
        button.addSubview(label)

        NSLayoutConstraint.activate([
            // ---------------------------------
            // 아이콘 위치
            // 세 버튼 모두 같은 위치
            // ---------------------------------
            imageView.centerXAnchor.constraint(
                equalTo: button.leadingAnchor,
                constant: 42
            ),
            imageView.centerYAnchor.constraint(
                equalTo: button.centerYAnchor
            ),
            imageView.widthAnchor.constraint(
                equalToConstant: iconSize
            ),
            imageView.heightAnchor.constraint(
                equalToConstant: iconSize
            ),

            // ---------------------------------
            // 텍스트 위치
            // 세 버튼 모두 같은 위치
            // ---------------------------------
            label.centerXAnchor.constraint(
                equalTo: button.centerXAnchor
            ),
            label.centerYAnchor.constraint(
                equalTo: button.centerYAnchor
            )
        ])
    }
    
    // =================
    // MARK: SAIT Login
    // =================
    @IBOutlet weak var loginIdTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    private func showAlert(message: String) {
        let alert = UIAlertController(
            title: "알림",
            message: message,
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        present(alert, animated: true)
    }

    @IBAction func didTapLoginButton(_ sender: Any) {
        view.endEditing(true)
        
        guard let id = loginIdTextField.text, !id.trimmingCharacters(in: .whitespaces).isEmpty else {
            showAlert(message: "아이디를 입력해주세요.")
            return
        }
        
        guard let password = passwordTextField.text, !password.isEmpty else {
            showAlert(message: "비밀번호를 입력해주세요.")
            return
        }
        
        print("로그인 시도")
    }
    
    private func configureEmailTextField() {
        // 기본 설정
        // Placeholder 색상
        let placeholderColor = UIColor(
            red: 165 / 255,
            green: 178 / 255,
            blue: 198 / 255,
            alpha: 1
        )
        
        loginIdTextField.attributedPlaceholder = NSAttributedString(
            string: "이메일 입력",
            attributes: [
                .foregroundColor: placeholderColor
            ]
        )
        
        loginIdTextField.font = .systemFont(ofSize: 16)
        
        // 실제 입력되는 글자 색상
        loginIdTextField.textColor = UIColor(
            red: 30 / 255,
            green: 50 / 255,
            blue: 75 / 255,
            alpha: 1
        )
        
        // 키보드
        loginIdTextField.keyboardType = .emailAddress
        loginIdTextField.autocapitalizationType = .none
        loginIdTextField.autocorrectionType = .no
        
        // 테두리
        loginIdTextField.borderStyle = .none
        loginIdTextField.layer.cornerRadius = 10
        loginIdTextField.layer.borderWidth = 1
        loginIdTextField.layer.borderColor = UIColor(
            red: 220 / 255,
            green: 226 / 255,
            blue: 235 / 255,
            alpha: 1
        ).cgColor
        
        // 왼쪽 이메일 아이콘
        let iconImageView = UIImageView(
            image: UIImage(systemName: "envelope")
        )
        
        iconImageView.tintColor = UIColor(
            red: 165 / 255,
            green: 178 / 255,
            blue: 198 / 255,
            alpha: 1
        )
        
        iconImageView.contentMode = .scaleAspectFit
        
        // 아이콘을 담을 영역
        let iconContainer = UIView(
            frame: CGRect(x: 0, y: 0, width: 50, height: 44)
        )
        
        iconImageView.frame = CGRect(
            x: 16,
            y: 12,
            width: 20,
            height: 20
        )
        
        iconContainer.addSubview(iconImageView)
        
        loginIdTextField.leftView = iconContainer
        loginIdTextField.leftViewMode = .always
    }
    
    private func configurePasswordTextField() {
        // Placeholder 색상
        let placeholderColor = UIColor(
            red: 165 / 255,
            green: 178 / 255,
            blue: 198 / 255,
            alpha: 1
        )
        
        passwordTextField.attributedPlaceholder = NSAttributedString(
            string: "비밀번호 입력",
            attributes: [
                .foregroundColor: placeholderColor
            ]
        )
        
        passwordTextField.font = .systemFont(ofSize: 16)
        
        // 실제 입력되는 글자 색상
        passwordTextField.textColor = UIColor(
            red: 30 / 255,
            green: 50 / 255,
            blue: 75 / 255,
            alpha: 1
        )
        
        // 비밀번호 숨김
        passwordTextField.isSecureTextEntry = true
        
        // 테두리
        passwordTextField.borderStyle = .none
        passwordTextField.layer.cornerRadius = 10
        passwordTextField.layer.borderWidth = 1
        passwordTextField.layer.borderColor = UIColor(
            red: 220 / 255,
            green: 226 / 255,
            blue: 235 / 255,
            alpha: 1
        ).cgColor
        
        // 왼쪽 자물쇠 아이콘
        let lockImageView = UIImageView(
            image: UIImage(systemName: "lock")
        )
        
        lockImageView.tintColor = placeholderColor
        lockImageView.contentMode = .scaleAspectFit
        
        let lockContainer = UIView(
            frame: CGRect(x: 0, y: 0, width: 50, height: 44)
        )
        
        lockImageView.frame = CGRect(
            x: 16,
            y: 12,
            width: 20,
            height: 20
        )
        
        lockContainer.addSubview(lockImageView)
        
        passwordTextField.leftView = lockContainer
        passwordTextField.leftViewMode = .always
        
        // 오른쪽 눈 아이콘
        let eyeButton = UIButton(type: .system)
        
        eyeButton.frame = CGRect(
            x: 0,
            y: 0,
            width: 50,
            height: 44
        )
        
        let eyeImage = UIImage(
            systemName: "eye",
            withConfiguration: UIImage.SymbolConfiguration(
                pointSize: 11,
                weight: .light
            )
        )
        
        eyeButton.setImage(eyeImage, for: .normal)
        
        eyeButton.tintColor = UIColor(
            red: 180 / 255,
            green: 190 / 255,
            blue: 207 / 255,
            alpha: 1
        )
        
        eyeButton.contentEdgeInsets = UIEdgeInsets(
            top: 0,
            left: 0,
            bottom: 0,
            right: 16
        )
        
        eyeButton.addTarget(
            self,
            action: #selector(didTapPasswordEye),
            for: .touchUpInside
        )
        
        passwordTextField.rightView = eyeButton
        passwordTextField.rightViewMode = .always
    }
    
    @objc private func didTapPasswordEye(_ sender: UIButton) {
        passwordTextField.isSecureTextEntry.toggle()
        
        let imageName = passwordTextField.isSecureTextEntry ? "eye" : "eye.slash"
        
        let configuration = UIImage.SymbolConfiguration(pointSize: 11, weight: .light)
        
        sender.setImage(
            UIImage(
                systemName: imageName,
                withConfiguration: configuration
            ),
            for: .normal
        )
    }
    
    private func configureLoginButton() {
        // UIButton.Configuration 제거
        loginButton.configuration = nil
        
        // 제목
        loginButton.setTitle("로그인", for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        
        // 배경
        loginButton.backgroundColor = UIColor(
            red: 55 / 255,
            green: 125 / 255,
            blue: 245 / 255,
            alpha: 1
        )
        
        // 모서리
        loginButton.layer.cornerRadius = 12
        loginButton.clipsToBounds = true
    }
    
    // ==================
    // MARK: Find Account
    // ==================
    @IBOutlet weak var findIdButton: UIButton!
    @IBOutlet weak var separatorLabel: UILabel!
    @IBOutlet weak var findPasswordButton: UIButton!
    
    private func configureFindButtons() {
        let textColor = UIColor(
            red: 100 / 255,
            green: 118 / 255,
            blue: 145 / 255,
            alpha: 1
        )
        
        findIdButton.setTitle("ID 찾기", for: .normal)
        findIdButton.setTitleColor(textColor, for: .normal)
        findIdButton.titleLabel?.font = .systemFont(ofSize: 13, weight: .regular)
        
        separatorLabel.textColor = textColor
        separatorLabel.font = .systemFont(ofSize: 13, weight: .regular)
        
        findPasswordButton.setTitle("PWD 찾기", for: .normal)
        findPasswordButton.setTitleColor(textColor, for: .normal)
        findPasswordButton.titleLabel?.font = .systemFont(ofSize: 13, weight: .regular)
    }
    
    // =============
    // MARK: Sign Up
    // =============
    @IBOutlet weak var signUpButton: UIButton!
    
    private func configureSignUpButton() {
        signUpButton.setTitle("회원가입", for: .normal)
        
        signUpButton.setTitleColor(
            UIColor(
                red: 55 / 255,
                green: 125 / 255,
                blue: 245 / 255,
                alpha: 1
            ),
            for: .normal
        )
        
        signUpButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
    }
    
}
