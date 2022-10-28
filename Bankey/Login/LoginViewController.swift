//
//  ViewController.swift
//  Bankey
//
//  Created by Boris Ofon on 10/21/22.
//

import UIKit

class LoginViewController: UIViewController {
    
    let loginView = LoginView()
    let SignInButton = UIButton(type: .system)
    let errorMessageLabel = UILabel()
    let titleLabel = UILabel()
    let titleMessageLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        style()
        layout()
    }
    
    var username:String?{
        return loginView.usernameTextField.text
    }
    
    var password:String?{
        return loginView.passwordTextField.text
    }
}

extension LoginViewController{
    
    private func style(){
        loginView.translatesAutoresizingMaskIntoConstraints = false
        
        SignInButton.translatesAutoresizingMaskIntoConstraints = false
        SignInButton.configuration = .filled()
        //SignInButton.configuration?.imagePadding = 8
        SignInButton.setTitle("Sign In", for: .normal)
        SignInButton.addTarget(self, action: #selector(signInTapped), for: .primaryActionTriggered)
        
        errorMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        errorMessageLabel.textAlignment = NSTextAlignment.center
        errorMessageLabel.textColor = .systemRed
        errorMessageLabel.numberOfLines = 0
        errorMessageLabel.text = "This is an error please try again"
        errorMessageLabel.isHidden = true
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        titleLabel.adjustsFontForContentSizeCategory = true
        titleLabel.text = "Bankey"
        
        titleMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        titleMessageLabel.text = "Your premium source for all things banking!"
        titleMessageLabel.numberOfLines = 0
        
        
    }
    
    private func layout(){
        view.addSubview(loginView)
        view.addSubview(SignInButton)
        view.addSubview(errorMessageLabel)
        view.addSubview(titleLabel)
        view.addSubview(titleMessageLabel)
        
        //login view
        NSLayoutConstraint.activate([
                    loginView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                    loginView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
                    view.trailingAnchor.constraint(equalToSystemSpacingAfter: loginView.trailingAnchor, multiplier: 1)
                ])
        
        //button
        NSLayoutConstraint.activate([
            SignInButton.topAnchor.constraint(equalToSystemSpacingBelow: loginView.bottomAnchor, multiplier: 2),
            SignInButton.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            SignInButton.trailingAnchor.constraint(equalTo: loginView.trailingAnchor)
        
        ])
        
        //error message
        NSLayoutConstraint.activate([
            errorMessageLabel.topAnchor.constraint(equalToSystemSpacingBelow: SignInButton.bottomAnchor, multiplier: 2),
            errorMessageLabel.leadingAnchor.constraint(equalTo: SignInButton.leadingAnchor),
            errorMessageLabel.trailingAnchor.constraint(equalTo: SignInButton.trailingAnchor)
        ])
        
        //title
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalToSystemSpacingBelow: view.topAnchor, multiplier: 20)
        ])
        
        //title message
        NSLayoutConstraint.activate([
            titleMessageLabel.topAnchor.constraint(equalToSystemSpacingBelow: titleLabel.bottomAnchor, multiplier: 2),
            titleMessageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
    }
}


// Actions
extension LoginViewController{
    @objc func signInTapped(){
        errorMessageLabel.isHidden = true
        login()
    }
    
    private func login(){
        guard let username = username, let password = password else{
            assertionFailure("Username/ password should never be nil")
            return
        }
        if username.isEmpty || password.isEmpty {
            configureView(withMessage: "Username / password cannot be blank")
            return
        }
        if username == "Kevin" && password == "welcome" {
            SignInButton.configuration?.showsActivityIndicator = true
        } else {
            configureView(withMessage: "Username / password wrong")
        }
    }
        
        private func configureView(withMessage message: String){
            errorMessageLabel.isHidden = false
            errorMessageLabel.text = message
        }
}