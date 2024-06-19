//
//  SignUpViewController.swift
//  To-DoDemo
//
//  Created by  Даниил Хомяков on 19.06.2024.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController {
    
    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let confirmPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Confirm Password"
        textField.isSecureTextEntry = true
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .green
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(signUp), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(confirmPasswordTextField)
        view.addSubview(signUpButton)
        
        NSLayoutConstraint.activate([
            emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100),
            emailTextField.widthAnchor.constraint(equalToConstant: 200),
            emailTextField.heightAnchor.constraint(equalToConstant: 30),
            
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            passwordTextField.widthAnchor.constraint(equalToConstant: 200),
            passwordTextField.heightAnchor.constraint(equalToConstant: 30),
            
            confirmPasswordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            confirmPasswordTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            confirmPasswordTextField.widthAnchor.constraint(equalToConstant: 200),
            confirmPasswordTextField.heightAnchor.constraint(equalToConstant: 30),
            
            signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signUpButton.topAnchor.constraint(equalTo: confirmPasswordTextField.bottomAnchor, constant: 20),
            signUpButton.widthAnchor.constraint(equalToConstant: 100),
            signUpButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    @objc func signUp() {
        // The passwords should match each other, otherwise we show an error alert
        if passwordTextField.text != confirmPasswordTextField.text {
            let alertController = UIAlertController(title: Constants.Alerts.wrongPasswordTitle, message: Constants.Alerts.wrongPasswordMessage, preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: Constants.Alerts.ok, style: .cancel, handler: nil)
            
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        } else {
            // If the input is correct we try to create a user with provided credentials
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!){ [weak self] (user, error) in
                if error == nil {
                    guard let user = Auth.auth().currentUser else {
                        return
                    }
                    let alertController = UIAlertController(title: Constants.Alerts.success, message: Constants.Alerts.userCreatedMessage, preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: Constants.Alerts.ok, style: .cancel, handler: { _ in
                        self?.navigationController?.popViewController(animated: false)
                    })
                    
                    alertController.addAction(defaultAction)
                    self?.present(alertController, animated: true, completion: nil)
                } else {
                    // If user creation failed we show the error text provided by firebase
                    let alertController = UIAlertController(title: Constants.Alerts.error, message: error?.localizedDescription, preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: Constants.Alerts.ok, style: .cancel, handler: nil)
                    
                    alertController.addAction(defaultAction)
                    self?.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
}
