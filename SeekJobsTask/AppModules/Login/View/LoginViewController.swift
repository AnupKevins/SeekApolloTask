//
//  LoginViewController.swift
//  SeekJobsTask
//
//  Created by Anup kumar sahu on 23/02/24.
//

import UIKit
import Combine

class LoginViewController: UIViewController {
    
    // Create text fields
    private lazy var usernameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = LoginConstants.Login.userNamePlaceholder
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = LoginConstants.Login.passwordPlaceholder
        textField.isSecureTextEntry = true
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    // Create a login button
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle(LoginConstants.Login.loginPlaceholder, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = HexColor.getUIColor(AppConstants.UIColors.hexStringActionButton)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.frame = CGRect(x:0.0,y: 0.0,width: 40.0, height: 40.0)
        indicator.center = CGPoint(x: self.view.frame.size.width / 2, y: self.view.frame.size.height / 2)
        indicator.color = UIColor.gray
        return indicator
    }()

    var loginViewModel: LoginViewModel?
    
    private var cancellables: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        configureUI()
        setupConstraints()
    }
    
    private func configureUI() {
        view.backgroundColor = HexColor.getUIColor(
            AppConstants.UIColors.hexStringBackground
        )
        
        // Add text fields to the view
        view.addSubview(usernameTextField)
        view.addSubview(passwordTextField)
        
        // Add login button to the view
        view.addSubview(loginButton)
        view.addSubview(activityIndicator)
    }
    
    private func setupConstraints() {
       
        NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            usernameTextField.heightAnchor.constraint(equalToConstant: 40)
        ])

        
        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 20),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40)
        ])

       
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.widthAnchor.constraint(equalToConstant: 100),
            loginButton.heightAnchor.constraint(equalToConstant: 40)
        ])

        
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
    
    private func bindViewModel() {
        loginViewModel?.authTokenWillChange.sink { [weak self] in
            guard let self = self else {
                return
            }
            updateUI()
            
        }.store(in: &cancellables)
    }
    
    @objc private func loginButtonTapped() {
        view.endEditing(true)
        
        if let usernameTrimmed = usernameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines).lowercased(),
          let passwordTrimmed = passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) {
           
           let validation = loginViewModel?.validateUserCredentials(
                usernameTrimmed, passwordTrimmed
           )
           
           checkValidation(validation, usernameTrimmed, passwordTrimmed)
       }
    }
    
    private func checkValidation(
        _ validation: LoginValidation?,
        _ username: String,
        _ password: String
    ) {
        if validation == .valid {
            activityIndicator.startAnimating()
            loginViewModel?.getAuthToken(username, password)
        } else {
            loginViewModel?.showAlert()
        }
    }
    
    private func updateUI() {
        self.activityIndicator.stopAnimating()
        if loginViewModel?.postsAuthToken.isEmpty == false {
            self.storeAuthToken(self.loginViewModel?.postsAuthToken)
        }
    }
    
    private func storeAuthToken(_ token: String?) {
        
        if let token = token {
            print("Token:\(token)")
            UserDefaultManager.shared.authToken = token
            UserDefaultManager.shared.isLoggedIn = true
            setupHomeCoordinatorAsRoot()
        }
    }
    
    private func setupHomeCoordinatorAsRoot() {
        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
            sceneDelegate.switchToRootScreen()
        }
    }
}
