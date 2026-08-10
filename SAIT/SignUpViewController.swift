//
//  SignUpViewController.swift
//  SAIT
//
//  Created by 이머영 on 7/10/26.
//

import UIKit

class SignUpViewController: UIViewController {

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
    }
    
    // ==============
    // MARK: ID Field
    // ==============
    @IBOutlet weak var idContainerView: UIView!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var idCheckButton: UIButton!
    
    private func configureIdContainer() {
        idContainerView.layer.cornerRadius = 12
        idContainerView.layer.borderWidth = 1
        idContainerView.layer.borderColor = UIColor.systemGray5.cgColor
    }
    
    private func configureIdTextField() {
        idTextField.borderStyle = .none
        idTextField.font = .systemFont(ofSize: 16)
        idTextField.textColor = .label
        
        idTextField.autocorrectionType = .no
        idTextField.autocapitalizationType = .none
        
        idTextField.textContentType = .username
        idTextField.returnKeyType = .done
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
    
    @IBAction func didTapIdCheckButton(_ sender: Any) {
        guard let id = idTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
              !id.isEmpty else {
            showAlert(message: "ID를 입력해주세요.")
            return
        }
        
        guard isValidId(id) else {
            showAlert(message: "ID는 4~20자의 영문과 숫자로 입력해주세요.")
            return
        }
        
        print("중복확인 요청 ID:", id)
        
        // TODO: 서버 중복확인 API 연결
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(
            title: nil,
            message: message,
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        
        present(alert, animated: true)
    }
}
