//
//  ViewController.swift
//  DragonBallBase
//
//  Created by Pedro Martín on 12/1/23.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    
    var mainView: LoginView {self.view as! LoginView}
    
    var emailTextField: UITextField!
    var passwordTextField: UITextField!
    var loginButton: UIButton!
    var errorMessageView: UILabel?

    
    var login: LoginModel?

    
    override func loadView() {
        let loginView = LoginView()
        

        loginButton = loginView.getLoginButtonView()
        emailTextField = loginView.getEmailView()
        passwordTextField = loginView.getPasswordView()
        errorMessageView = loginView.getErrorView()
        
        view = loginView

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        login = LoginModel()
        loginButton?.addTarget(self, action: #selector(didLoginTapped), for: .touchUpInside)

    }
    
    func loginButtonTapped(sender: UIButton) {
        guard let email = emailTextField.text, !email.isEmpty else {
            print("email is empty")
            return
        }
        
        guard let password = passwordTextField.text, !password.isEmpty else {
            print("password is empty")
            return
        }
    }

    @objc
    func didLoginTapped(sender: UIButton) {
        
        // 1.- Capturar los valores de texto introducidos en para el email y la password
        
        guard let email = emailTextField?.text, let password = passwordTextField?.text else {
            return
        }
        
        // 2.- Prepare the controller to receive data from view mmodel
        
        login?.updateUI = { [weak self] token, error in
            if !token.isEmpty {
                DispatchQueue.main.async {
                    self?.errorMessageView?.text = token
                }
            }
            
            if !error.isEmpty {
                DispatchQueue.main.async {
                    self?.errorMessageView?.text = error
                }
            }
        }
        
        // 3.- Call view model to perform the login call with the apiClient
        
        login?.login(email: email, password: password)
    }
        
}

