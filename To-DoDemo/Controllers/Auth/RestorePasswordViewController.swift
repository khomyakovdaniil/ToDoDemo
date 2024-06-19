//
//  RestorePasswordViewController.swift
//  To-DoDemo
//
//  Created by  Даниил Хомяков on 19.06.2024.
//

import UIKit
import FirebaseAuth

class RestorePasswordViewController: UIViewController {
    
    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let restorePasswordButton: UIButton = {
        let button = UIButton()
        button.setTitle("Restore Password", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(restorePassword), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(emailTextField)
        view.addSubview(restorePasswordButton)
        
        NSLayoutConstraint.activate([
            emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
            emailTextField.widthAnchor.constraint(equalToConstant: 200),
            emailTextField.heightAnchor.constraint(equalToConstant: 30),
            
            restorePasswordButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            restorePasswordButton.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            restorePasswordButton.widthAnchor.constraint(equalToConstant: 150),
            restorePasswordButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    @objc func restorePassword() {
        guard let email = emailTextField.text else { return }
        // We send a password recovery letter to provided e-mail
        Auth.auth().sendPasswordReset(withEmail: email) { [weak self] error in
            if error != nil {
                // If the letter wasn't sent we show the user an error text
                print("error reseting password")
                let alertController = UIAlertController(title: Constants.Alerts.error, message: error?.localizedDescription, preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: Constants.Alerts.ok, style: .cancel, handler: nil)
                
                alertController.addAction(defaultAction)
                self?.present(alertController, animated: true, completion: nil)
            } else {
                // If the letter was sent successfully we tell the user about it
                let alertController = UIAlertController(title: Constants.Alerts.passwordRecoverySent, message: error?.localizedDescription, preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: Constants.Alerts.ok, style: .cancel, handler: { _ in self?.navigationController?.popViewController(animated: false) })
                
                alertController.addAction(defaultAction)
                self?.present(alertController, animated: true, completion: nil)
                print("Sent recovery email")
            }
            
        }
    }
}
