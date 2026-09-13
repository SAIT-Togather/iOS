//
//  FindIDResultViewController.swift
//  SAIT
//
//  Created by 이머영 on 9/13/26.
//

import UIKit

class FindIDResultViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        
        foundIdLabel.text = foundId
    }
    
    // ====================
    // MARK: User Interface
    // ====================
    private func configureUI() {
        mainStackView.setCustomSpacing(
            32,
            after: idResultContainerView
        )
        
        configureIdResultContainer()
        configureFoundIdLabel()
        configureCopyButton()
        
        configureFindPasswordButton()
        configureGoToLoginButton()
    }
    
    // =====================
    // MARK: ID Result Field
    // =====================
    var foundId: String?
    
    @IBOutlet weak var mainStackView: UIStackView!
    @IBOutlet weak var idResultContainerView: UIView!
    @IBOutlet weak var foundIdLabel: UILabel!
    @IBOutlet weak var copyButton: UIButton!
    
    @IBAction func didTapCopyButton(_ sender: UIButton) {
        guard let id = foundIdLabel.text, !id.isEmpty else { return
        }
        
        UIPasteboard.general.string = id
        
        let config = UIImage.SymbolConfiguration(
            pointSize: 17,
            weight: .regular
        )
        
        let checkImage = UIImage(
            systemName: "checkmark",
            withConfiguration: config
        )
        
        sender.setImage(checkImage, for: .normal)
        sender.tintColor = .systemGreen
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in
            self?.configureCopyButton()
        }
    }
    
    private func configureIdResultContainer() {
        idResultContainerView.layer.cornerRadius = 10
        idResultContainerView.layer.borderWidth = 1
        idResultContainerView.layer .borderColor = UIColor(
            red: 220 / 255,
            green: 226 / 255,
            blue: 235 / 255,
            alpha: 1
        ).cgColor
    }
    
    private func configureFoundIdLabel() {
        foundIdLabel.font = .systemFont(
            ofSize: 21,
            weight: .semibold
        )
        
        foundIdLabel.textColor = .label
        
        foundIdLabel.numberOfLines = 1
        foundIdLabel.adjustsFontSizeToFitWidth = true
        foundIdLabel.minimumScaleFactor = 0.75
    }
    
    private func configureCopyButton() {
        copyButton.configuration = nil

        let config = UIImage.SymbolConfiguration(
            pointSize: 17,
            weight: .regular
        )

        let image = UIImage(
            systemName: "doc.on.doc",
            withConfiguration: config
        )

        copyButton.setImage(image, for: .normal)

        copyButton.tintColor = UIColor(
            red: 55 / 255,
            green: 125 / 255,
            blue: 245 / 255,
            alpha: 1
        )

        copyButton.setTitle(nil, for: .normal)
    }
    
    // ================================
    // MARK: Find Password Button Field
    // ================================
    @IBOutlet weak var findPasswordButton: UIButton!
    
    @IBAction func didTapFindPasswordButton(_ sender: Any) {
        performSegue(
            withIdentifier: "showFindPassword",
            sender: nil
        )
    }
    
    private func configureFindPasswordButton() {
        findPasswordButton.configuration = nil
        findPasswordButton.layer.cornerRadius = 10
        findPasswordButton.layer.borderWidth = 1
        findPasswordButton.layer.borderColor = UIColor(
            red: 55 / 255,
            green: 125 / 255,
            blue: 245 / 255,
            alpha: 1
        ).cgColor
        
        findPasswordButton.backgroundColor = .white
        
        findPasswordButton.setTitle(
            "비밀번호 찾기",
            for: .normal
        )
        
        findPasswordButton.setTitleColor(
            UIColor(
                red: 55 / 255,
                green: 125 / 255,
                blue: 245 / 255,
                alpha: 1
            ),
            for: .normal
        )
        
        findPasswordButton.titleLabel?.font = .systemFont(
            ofSize: 17,
            weight: .semibold
        )
    }
    
    // =============================
    // MARK: Go To Login Page Button
    // =============================
    @IBOutlet weak var goToLoginButton: UIButton!
    
    @IBAction func didTapGoToLoginButton(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    private func configureGoToLoginButton() {
        goToLoginButton.configuration = nil

        goToLoginButton.layer.cornerRadius = 10
        goToLoginButton.clipsToBounds = true

        goToLoginButton.backgroundColor = UIColor(
            red: 55 / 255,
            green: 125 / 255,
            blue: 245 / 255,
            alpha: 1
        )

        goToLoginButton.setTitle(
            "로그인하러 가기",
            for: .normal
        )

        goToLoginButton.setTitleColor(
            .white,
            for: .normal
        )

        goToLoginButton.titleLabel?.font = .systemFont(
            ofSize: 17,
            weight: .semibold
        )
    }
    
}
