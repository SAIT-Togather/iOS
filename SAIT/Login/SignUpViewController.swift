//
//  SignUpViewController.swift
//  SAIT
//
//  Created by 이머영 on 7/10/26.
//

import UIKit

class SignUpViewController: UIViewController {
    
    private var isIdChecked = false
    private var verificationTimer: Timer?
    private var verificationTimerLeft = 300
    private var isEmailVerified = false
    
    // =========================
    // MARK: View LifeCycle Func
    // =========================
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }
    
    // ====================
    // MARK: User Interface
    // ====================
    private func configureUI() {
        configureIdContainer()
        configureIdTextField()
        configureIdCheckButton()
        
        configureEmailContainer()
        configureEmailTextField()
        configureEmailCheckButton()
        
        configureVerificationContainer()
        configureVerificationInputView()
        configureVerificationTextField()
        configureVerificationCheckButton()
        
        emailVerificationStackView.isHidden = true
        
        configurePasswordContainer()
        configurePasswordToggleButton()
        configurePasswordConfirmContainer()
        configurePasswordConfirmToggleButton()
    }
    
    // ==============
    // MARK: ID Field
    // ==============
    @IBOutlet weak var idContainerView: UIView!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var idCheckButton: UIButton!
    @IBOutlet weak var idGuideLabel: UILabel!
    
    @IBAction func didTapIdCheckButton(_ sender: Any) {
        guard let id = idTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
              !id.isEmpty else {
            showIdEmptyError()
            return
        }
        
        guard isValidId(id) else {
            showIdFormatError()
            return
        }
        
        print("중복확인 요청 ID:", id)
        
        // TODO: 서버 중복확인 API 연결
        // 테스트 코드
        if id == "jiyoon" {
            isIdChecked = false
            showIdUnavailable()
        } else {
            isIdChecked = true
            showIdAvailable()
        }
    }
    
    private func configureIdContainer() {
        idContainerView.layer.cornerRadius = 10
        idContainerView.layer.borderWidth = 1
        idContainerView.layer.borderColor = UIColor(
            red: 220 / 255,
            green: 226 / 255,
            blue: 235 / 255,
            alpha: 1
        ).cgColor
    }
    
    private func configureIdTextField() {
        idTextField.borderStyle = .none
        idTextField.font = .systemFont(ofSize: 16)
        idTextField.textColor = .label
        
        idTextField.autocorrectionType = .no
        idTextField.autocapitalizationType = .none
        
        idTextField.textContentType = .username
        idTextField.returnKeyType = .done
        
        idTextField.addTarget(
            self,
            action: #selector(idTextFieldDidChange),
            for: .editingChanged)
    }
    
    private func configureIdCheckButton() {
        idCheckButton.layer.cornerRadius = 8
        idCheckButton.layer.borderWidth = 1
        idCheckButton.layer.borderColor = UIColor(
            red: 0.055,
            green: 0.169,
            blue: 0.302,
            alpha: 1
        ).cgColor
        
        idCheckButton.setTitleColor(
            UIColor(
                red: 0.055,
                green: 0.169,
                blue: 0.302,
                alpha: 1
            ),
            for: .normal
        )
        
        idCheckButton.titleLabel?.font = .systemFont(
            ofSize: 14,
            weight: .semibold
        )
    }
    
    private func isValidId(_ id: String) -> Bool {
        let pattern = "^[A-Za-z0-9]{4,20}$"
        
        return id.range(of: pattern, options: .regularExpression) != nil
    }
    
    private func resetIdGuide() {
        idGuideLabel.text = "4~20자의 영문, 숫자 사용 가능"
        idGuideLabel.textColor = .secondaryLabel
    }
    
    private func showIdAvailable() {
        idGuideLabel.text = "사용 가능한 ID입니다."
        idGuideLabel.textColor = .systemGreen
    }
    
    private func showIdUnavailable() {
        idGuideLabel.text = "이미 사용 중인 ID입니다."
        idGuideLabel.textColor = .systemRed
    }
    
    private func showIdFormatError() {
        idGuideLabel.text = "4~20자의 영문과 숫자만 사용할 수 있습니다."
        idGuideLabel.textColor = .systemRed
    }
    
    private func showIdEmptyError() {
        idGuideLabel.text = "ID를 입력해주세요."
        idGuideLabel.textColor = .systemRed
    }
    
    @objc private func idTextFieldDidChange() {
        isIdChecked = false
        resetIdGuide()
    }
    
    // =================
    // MARK: Email Field
    // =================
    @IBOutlet weak var emailContainerView: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailCheckButton: UIButton!
    @IBOutlet weak var emailGuideLabel: UILabel!
    
    @IBAction func didTapEmailCheckButton(_ sender: Any) {
        guard let email = emailTextField.text?
            .trimmingCharacters(in: .whitespacesAndNewlines),
              !email.isEmpty else {
            showEmailFormatError()
            return
        }
        
        guard isValidEmail(email) else {
            showEmailFormatError()
            return
        }
        
        print("이메일 인증 요청:", email)
        
        // TODO: 서버 이메일 인증 API 연결
        // 테스트 코드
        isEmailVerified = false
        emailVerificationStackView.isHidden = false
        
        verificationGuideLabel.text = "인증번호 6자리를 입력해주세요."
        verificationGuideLabel.textColor = .secondaryLabel
        verificationTextField.text = ""
        
        startVerificationTimer()
    }
    
    private func configureEmailContainer() {
        emailContainerView.layer.cornerRadius = 10
        emailContainerView.layer.borderWidth = 1
        emailContainerView.layer.borderColor = UIColor(
            red: 220 / 255,
            green: 226 / 255,
            blue: 235 / 255,
            alpha: 1
        ).cgColor
    }

    private func configureEmailTextField() {
        emailTextField.borderStyle = .none
        emailTextField.font = .systemFont(ofSize: 16)
        emailTextField.textColor = .label

        emailTextField.autocorrectionType = .no
        emailTextField.autocapitalizationType = .none

        emailTextField.keyboardType = .emailAddress
        emailTextField.textContentType = .emailAddress
        emailTextField.returnKeyType = .done
        
        emailTextField.addTarget(
            self,
            action: #selector(emailTextFieldDidChange),
            for: .editingChanged
        )
    }

    private func configureEmailCheckButton() {
        emailCheckButton.layer.cornerRadius = 8
        emailCheckButton.layer.borderWidth = 1
        emailCheckButton.layer.borderColor = UIColor(
            red: 0.055,
            green: 0.169,
            blue: 0.302,
            alpha: 1
        ).cgColor

        emailCheckButton.setTitleColor(
            UIColor(
                red: 0.055,
                green: 0.169,
                blue: 0.302,
                alpha: 1
            ),
            for: .normal
        )

        emailCheckButton.titleLabel?.font = .systemFont(
            ofSize: 14,
            weight: .semibold
        )
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let pattern = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        
        return email.range(
            of: pattern,
            options: .regularExpression
        ) != nil
    }
    
    private func resetEmailGuide() {
        emailGuideLabel.text = "이메일 주소를 입력해주세요"
        emailGuideLabel.textColor = .secondaryLabel
    }

    private func showEmailFormatError() {
        emailGuideLabel.text = "올바른 이메일 주소를 입력해주세요."
        emailGuideLabel.textColor = .systemRed
    }

    private func showEmailCodeSent() {
        emailGuideLabel.text = "인증번호를 전송했습니다."
        emailGuideLabel.textColor = .systemGreen
    }
    
    @objc private func emailTextFieldDidChange() {
        isEmailVerified = false
        resetEmailGuide()
    }
    
    // ==============================
    // MARK: Email Verification Field
    // ==============================
    @IBOutlet weak var emailVerificationStackView: UIStackView!
    @IBOutlet weak var verificationContainerView: UIView!
    @IBOutlet weak var verificationInputView: UIView!
    @IBOutlet weak var verificationTextField: UITextField!
    @IBOutlet weak var verificationTimerLabel: UILabel!
    @IBOutlet weak var verificationCheckButton: UIButton!
    @IBOutlet weak var verificationGuideLabel: UILabel!
    
    @IBAction func didTapVerificationCheckButton(_ sender: Any) {
        guard verificationTimerLeft > 0 else {
            showVerificationExpired()
            return
        }
        
        guard let code = verificationTextField.text,
              !code.isEmpty else {
            showVerificationEmptyError()
            return
        }
        
        guard code.count == 6 else {
            showVerificationFormatError()
            return
        }
        
        print("이메일 인증번호 확인:", code)
        
        // TODO: 서버 인증번호 확인 API 연결
        // 테스트 코드
        if code == "123456" {
            showVerificationSuccess()
        } else {
            showVerificationFailure()
        }
    }
    
    private func configureVerificationContainer() {
        verificationContainerView.layer.cornerRadius = 10
        verificationContainerView.layer.borderWidth = 1
        verificationContainerView.layer.borderColor = UIColor(
            red: 220 / 255,
            green: 226 / 255,
            blue: 235 / 255,
            alpha: 1
        ).cgColor
    }
    
    private func configureVerificationInputView() {
        verificationInputView.layer.cornerRadius = 10
        verificationInputView.layer.borderWidth = 1
        verificationInputView.layer.borderColor = UIColor(
            red: 220 / 255,
            green: 226 / 255,
            blue: 235 / 255,
            alpha: 1
        ).cgColor
    }
    
    private func configureVerificationCheckButton() {
        verificationCheckButton.layer.cornerRadius = 8
        verificationCheckButton.layer.borderWidth = 1
        verificationCheckButton.layer.borderColor = UIColor(
            red: 0.055,
            green: 0.169,
            blue: 0.302,
            alpha: 1
        ).cgColor
        
        verificationCheckButton.setTitleColor(
            UIColor(
                red: 0.055,
                green: 0.169,
                blue: 0.302,
                alpha: 1
            ),
            for: .normal
        )
        
        verificationCheckButton.titleLabel?.font = .systemFont(
            ofSize: 14,
            weight: .semibold
        )
    }
    
    private func updateVerificationTimerLabel() {
        let minutes = verificationTimerLeft / 60
        let seconds = verificationTimerLeft % 60
        
        verificationTimerLabel.text = String(
            format: "%02d:%02d",
            minutes,
            seconds
        )
    }
    
    private func startVerificationTimer() {
        verificationTimer?.invalidate()
        
        verificationTimerLabel.attributedText = nil
        verificationTimerLabel.textColor = .systemRed
        
        verificationTimerLeft = 300
        updateVerificationTimerLabel()
        
        verificationTimer = Timer.scheduledTimer(
            withTimeInterval: 1.0,
            repeats: true
        ) { [weak self] timer in
            guard let self = self else { return }
            
            if self.verificationTimerLeft > 0 {
                self.verificationTimerLeft -= 1
                self.updateVerificationTimerLabel()
            }
            
            if self.verificationTimerLeft == 0 {
                timer.invalidate()
                self.verificationTimer = nil
            }
        }
    }
    
    private func configureVerificationTextField() {
        verificationTextField.borderStyle = .none
        verificationTextField.font = .systemFont(ofSize: 16)
        verificationTextField.textColor = .label
        
        verificationTextField.keyboardType = .numberPad
        verificationTextField.textContentType = .oneTimeCode
        
        verificationTextField.addTarget(
            self,
            action: #selector(verificationTextFieldDidChange),
            for: .editingChanged
        )
    }
    
    @objc private func verificationTextFieldDidChange() {
        guard let text = verificationTextField.text else { return }
        
        let numbersOnly = text.filter { $0.isNumber }
        verificationTextField.text = String(numbersOnly.prefix(6))
    }
    
    private func showVerificationEmptyError() {
        verificationGuideLabel.text = "인증번호를 입력해주세요."
        verificationGuideLabel.textColor = .systemRed
    }

    private func showVerificationFormatError() {
        verificationGuideLabel.text = "인증번호 6자리를 입력해주세요."
        verificationGuideLabel.textColor = .systemRed
    }

    private func showVerificationFailure() {
        verificationGuideLabel.text = "인증번호가 올바르지 않습니다."
        verificationGuideLabel.textColor = .systemRed
    }

    private func showVerificationExpired() {
        verificationGuideLabel.text = "인증 시간이 만료되었습니다."
        verificationGuideLabel.textColor = .systemRed
    }

    private func showVerificationSuccess() {
        verificationTimer?.invalidate()
        verificationTimer = nil
        
        isEmailVerified = true
        
        let config = UIImage.SymbolConfiguration(
            pointSize: 17,
            weight: .regular
        )
        
        let image = UIImage(
            systemName: "checkmark",
            withConfiguration: config
        )?.withTintColor(
            .systemGreen,
            renderingMode: .alwaysOriginal
        )
        
        let attachment = NSTextAttachment()
        attachment.image = image
        
        verificationTimerLabel.attributedText =
            NSAttributedString(attachment: attachment)
        
        verificationTimerLabel.textAlignment = .center
        
        verificationGuideLabel.text = "이메일 인증이 완료되었습니다."
        verificationGuideLabel.textColor = .systemGreen
    }
    
    // ====================
    // MARK: Password Field
    // ====================
    @IBOutlet weak var passwordContainerView: UIView!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordToggleButton: UIButton!
    
    @IBOutlet weak var passwordConfirmContainerView: UIView!
    @IBOutlet weak var passwordConfirmTextField: UITextField!
    @IBOutlet weak var passwordConfirmToggleButton: UIButton!
    
    
    @IBAction func didTapPasswordToggleButton(_ sender: UIButton) {
        passwordTextField.isSecureTextEntry.toggle()
        
        let imageName = passwordTextField.isSecureTextEntry ? "eye" : "eye.slash"
        
        let config = UIImage.SymbolConfiguration(
            pointSize: 15,
            weight: .light
        )
        
        sender.setImage(
            UIImage(systemName: imageName, withConfiguration: config),
            for: .normal
        )
    }
    
    @IBAction func didTapPasswordConfirmToggleButton(_ sender: UIButton) {
        passwordConfirmTextField.isSecureTextEntry.toggle()
        
        let imageName = passwordConfirmTextField.isSecureTextEntry ? "eye" : "eye.slash"
        
        let config = UIImage.SymbolConfiguration(
            pointSize: 15,
            weight: .light
        )
        
        sender.setImage(
            UIImage(systemName: imageName, withConfiguration: config),
            for: .normal
        )
    }
    
    private func configurePasswordContainer() {
        passwordContainerView.layer.cornerRadius = 10
        passwordContainerView.layer.borderWidth = 1
        passwordContainerView.layer.borderColor = UIColor(
            red: 220 / 255,
            green: 226 / 255,
            blue: 235 / 255,
            alpha: 1
        ).cgColor
    }
    
    private func configurePasswordConfirmContainer() {
        passwordConfirmContainerView.layer.cornerRadius = 10
        passwordConfirmContainerView.layer.borderWidth = 1
        passwordConfirmContainerView.layer.borderColor = UIColor(
            red: 220 / 255,
            green: 226 / 255,
            blue: 235 / 255,
            alpha: 1
        ).cgColor
    }
    
    private func configurePasswordToggleButton() {
        let config = UIImage.SymbolConfiguration(
            pointSize: 15,
            weight: .light
        )
        
        let image = UIImage(
            systemName: "eye",
            withConfiguration: config
        )
        
        passwordToggleButton.setImage(image, for: .normal)
        passwordToggleButton.tintColor = UIColor(
            red: 180 / 255,
            green: 190 / 255,
            blue: 207 / 255,
            alpha: 1
        )
    }
    
    private func configurePasswordConfirmToggleButton() {
        let config = UIImage.SymbolConfiguration(
            pointSize: 15,
            weight: .light
        )
        
        let image = UIImage(
            systemName: "eye",
            withConfiguration: config
        )
        
        passwordConfirmToggleButton.setImage(image, for: .normal)
        passwordConfirmToggleButton.tintColor = UIColor(
            red: 180 / 255,
            green: 190 / 255,
            blue: 207 / 255,
            alpha: 1
        )
    }
    
    
}
