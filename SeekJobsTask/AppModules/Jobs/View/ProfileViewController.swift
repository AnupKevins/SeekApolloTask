//
//  ProfileViewController.swift
//  SeekJobsTask
//
//  Created by Anup kumar sahu on 25/02/24.
//

import UIKit

class ProfileViewController: UIViewController {
    
    // MARK: - UI Elements
    
    private lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isSecureTextEntry = true
        textField.textColor = .white
        textField.layer.cornerRadius = 8
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.white.cgColor
        return textField
    }()
    
    private lazy var updateButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(JobsConstants.textConstants.updatePasswordText, for: .normal)
        button.backgroundColor = HexColor.getUIColor(AppConstants.UIColors.hexStringActionButton)
        button.tintColor = .white
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        return button
    }()
    
    private lazy var logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(JobsConstants.textConstants.logoutText, for: .normal)
        button.backgroundColor = HexColor.getUIColor(AppConstants.UIColors.hexStringActionButton)
        button.tintColor = .white
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        return button
    }()
    
    var profileViewModel: ProfileViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavUI()
        setupUI()
        configureUI()
    }
    
    // MARK: - UI Setup
    
    private func setupUI() {
        view.backgroundColor = HexColor.getUIColor(
            AppConstants.UIColors.hexStringBackground
        )
        
        // Add UI elements to the view
        view.addSubview(usernameLabel)
        view.addSubview(passwordTextField)
        view.addSubview(updateButton)
        view.addSubview(logoutButton)
        
        // Setup constraints
        NSLayoutConstraint.activate([
            usernameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            usernameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            passwordTextField.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 20),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40),
            
            updateButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            updateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            logoutButton.topAnchor.constraint(equalTo: updateButton.bottomAnchor, constant: 20),
            logoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        updateButton.addTarget(self, action: #selector(updatePassword), for: .touchUpInside)
        logoutButton.addTarget(self, action: #selector(logout), for: .touchUpInside)
    }
    
    private func configureNavUI() {
        
        if let navigationController = navigationController {
            navigationController.navigationBar.barTintColor = HexColor.getUIColor(
                AppConstants.UIColors.hexStringBackground
            )
            navigationController.navigationBar.tintColor = UIColor.white
            navigationController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            navigationItem.title = JobsConstants.textConstants.userProfileText
        }
    }
    
    @objc private func updatePassword() {
        if let newPassword = passwordTextField.text, !newPassword.isEmpty {
            view.endEditing(true)
            // Update the password (add your logic here)
            print("Password updated to: \(newPassword)")
            passwordTextField.text = nil
        }
    }
    
    @objc private func logout() {
        view.endEditing(true)
        profileViewModel?.onLogout()
        setupLoginCoordinatorAsRoot()
    }
    
    private func configureUI() {
        if let profileViewModel = profileViewModel {
            
            usernameLabel.text = "\(LoginConstants.Login.userNamePlaceholder): \(profileViewModel.getUserName())"
            passwordTextField.text = "\(profileViewModel.getPassword())"
            
        }
    }
    
    private func setupLoginCoordinatorAsRoot() {
        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
            sceneDelegate.switchToRootScreen()
        }
    }
}
