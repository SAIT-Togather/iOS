//
//  ResetPasswordViewController.swift
//  SAIT
//
//  Created by 이머영 on 11/1/26.
//

import UIKit

class ResetPasswordViewController: UIViewController, UITextFieldDelegate {

    private var keyboardManager: KeyboardManager?
    
    
    // MARK: - View LifeCycle Func
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        configureKeyboardManager()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        keyboardManager?.startObserving()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        keyboardManager?.stopObserving()
    }
    
    
    // MARK: - User Interface
    
    private func configureUI() {
        configurePasswordUI()
        configureCompleteResetButton()
        
        updatePasswordToggleButton(
            passwordToggleButton,
            isSecure: true
        )
        
        updatePasswordToggleButton(
            passwordConfirmToggleButton,
            isSecure: true
        )
        
        configureTextFields()
        configureKeyboardDismiss()
    }
    
    
    // MARK: - Password Field
    
    @IBOutlet weak var passwordContainerView: UIView!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordToggleButton: UIButton!
    
    @IBOutlet weak var passwordConfirmContainerView: UIView!
    @IBOutlet weak var passwordConfirmTextField: UITextField!
    @IBOutlet weak var passwordConfirmToggleButton: UIButton!
    
    @IBAction func didTapPasswordToggleButton(_ sender: UIButton) {
        passwordTextField.isSecureTextEntry.toggle()
        updatePasswordToggleButton(
            sender,
            isSecure: passwordTextField.isSecureTextEntry
        )
    }
    
    @IBAction func didTapPasswordConfirmToggleButton(_ sender: UIButton) {
        passwordConfirmTextField.isSecureTextEntry.toggle()
        updatePasswordToggleButton(
            sender,
            isSecure: passwordConfirmTextField.isSecureTextEntry
        )
    }
    
    private func updatePasswordToggleButton(
        _ button: UIButton,
        isSecure: Bool
    ) {
        let symboleName = isSecure ? "eye.slash" : "eye"
        
        let configuration = UIImage.SymbolConfiguration(
            pointSize: 17,
            weight: .light
        )
        
        let image = UIImage(
            systemName: symboleName,
            withConfiguration: configuration
        )
        
        button.setImage(image, for: .normal)
        button.tintColor = .secondaryLabel
    }
    
    private func configurePasswordUI() {
        let containerViews = [
            passwordContainerView,
            passwordConfirmContainerView
        ]
        
        for containerView in containerViews {
            containerView?.layer.cornerRadius = 10
            containerView?.layer.borderWidth = 1
            containerView?.layer.borderColor = UIColor(
                red: 220 / 255,
                green: 226 / 255,
                blue: 235 / 255,
                alpha: 1
            ).cgColor
        }
        
        passwordTextField.isSecureTextEntry = true
        passwordConfirmTextField.isSecureTextEntry = true
    }
    
    
    // MARK: - Reset Button Field
    
    @IBOutlet weak var completeResetButton: UIButton!
    
    @IBAction func didTapCompleteResetButton(_ sender: UIButton) {
        guard validatePassword() else {
            return
        }
        
        showResetCompleteAlert()
    }
    
    private func validatePassword() -> Bool {
        guard let password = passwordTextField.text,
              !password.isEmpty
        else {
            Util.showAlert(
                on: self,
                message: "새 비밀번호를 입력해주세요."
            )
            
            return false
        }
        
        guard let passwordConfirm = passwordConfirmTextField.text,
              !passwordConfirm.isEmpty
        else {
            Util.showAlert(
                on: self,
                message: "새 비밀번호를 다시 입력해주세요."
            )
            
            return false
        }
        
        guard password.count >= 8 else {
            Util.showAlert(
                on: self,
                message: "비밀번호는 8자 이상 입력해주세요."
            )
            
            return false
        }
        
        guard password == passwordConfirm else {
            Util.showAlert(
                on: self,
                message: "비밀번호가 일치하지 않습니다."
            )
            
            return false
        }
        
        return true
    }
    
    private func showResetCompleteAlert() {
        let alert = UIAlertController(
            title: "비밀번호 변경 완료",
            message: "비밀번호가 성공적으로 변경되었습니다.\n새로운 비밀번호로 로그인해주세요.",
            preferredStyle: .alert
        )
        
        let confirmAction = UIAlertAction(
            title: "확인",
            style: .default
        ) { [weak self] _ in
            self?.moveToLogin()
        }
        
        alert.addAction(confirmAction)
        present(alert, animated: true)
    }
    
    private func moveToLogin() {
        guard let navigationController = navigationController else {
            return
        }
        
        if let loginViewController = navigationController.viewControllers
            .first(where: { $0 is LoginViewController }) {
            navigationController.popToViewController(
                loginViewController,
                animated: true
            )
        }
    }
    
    private func configureCompleteResetButton() {
        completeResetButton.configuration = nil
        
        completeResetButton.setTitle("비밀번호 변경 완료", for: .normal)
        completeResetButton.setTitleColor(.white, for: .normal)
        completeResetButton.titleLabel?.font = .systemFont(
            ofSize: 17,
            weight: .semibold
        )
        
        completeResetButton.backgroundColor = UIColor(
            red: 55 / 255,
            green: 125 / 255,
            blue: 245 / 255,
            alpha: 1
        )
        
        completeResetButton.layer.cornerRadius = 10
        completeResetButton.clipsToBounds = true
    }
    
    
    // MARK: - Keyboard Setting
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    private func configureKeyboardManager() {
        keyboardManager = KeyboardManager(scrollView: scrollView)
    }
    
    private func configureTextFields() {
        passwordTextField.delegate = self
        passwordConfirmTextField.delegate = self

        passwordTextField.returnKeyType = .next
        passwordConfirmTextField.returnKeyType = .done
    }

    private func configureKeyboardDismiss() {
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissKeyboard)
        )

        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == passwordTextField {
            passwordConfirmTextField.becomeFirstResponder()
        } else if textField == passwordConfirmTextField {
            textField.resignFirstResponder()
        }

        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        keyboardManager?.setActiveTextField(textField)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        keyboardManager?.clearActiveTextField()
    }
    
}
