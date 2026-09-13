//
//  FindIDViewController.swift
//  SAIT
//
//  Created by 이머영 on 7/10/26.
//

import UIKit

class FindIDViewController: UIViewController {
    
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
        configureEmailContainer()
        configureEmailTextField()
        configureEmailCheckButton()
        
        configureVerificationContainer()
        configureVerificationInputView()
        configureVerificationTextField()
        configureVerificationCheckButton()
        
        emailVerificationStackView.isHidden = true
        
        configureFindIdButton()
    }
    
    // ===================
    // MARK: Find ID Field
    // ===================
    private var verificationTimer: Timer?
    private var verificationTimerLeft = 300
    private var isEmailVerified = false
    
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
        
        verificationTextField.isEnabled = true
        verificationCheckButton.isEnabled = true
        
        verificationInputView.backgroundColor = .clear
        verificationTextField.textColor = .label
        verificationCheckButton.alpha = 1
        
        showEmailCodeSent()
        
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
        isEmailVerified = false
        
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
        
        verificationTextField.isEnabled = false
        verificationCheckButton.isEnabled = false
        
        verificationInputView.backgroundColor = UIColor.systemGray6
        verificationTextField.textColor = .secondaryLabel
        verificationCheckButton.alpha = 0.5
        
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
    // MARK: Find ID Button
    // ====================
    @IBOutlet weak var findIdButton: UIButton!
    
    @IBAction func didTapFindIdButton(_ sender: Any) {
        guard isEmailVerified else {
            Util.showAlert(
                on: self,
                message: "이메일 인증을 완료해주세요"
            )
            return
        }
        
        print("아이디 찾기 완료")
    }
    
    private func configureFindIdButton() {
        findIdButton.configuration = nil
        
        findIdButton.layer.cornerRadius = 10
        findIdButton.clipsToBounds = true
        
        findIdButton.backgroundColor = UIColor(
            red: 55 / 255,
            green: 125 / 255,
            blue: 245 / 255,
            alpha: 1
        )
        
        findIdButton.setTitle("아이디 찾기", for: .normal)
        findIdButton.setTitleColor(.white, for: .normal)
        
        findIdButton.titleLabel?.font = .systemFont(
            ofSize: 17,
            weight: .semibold
        )
    }
    
}
