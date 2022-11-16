//
//  ViewController.swift
//  Bankey
//
//  Created by Boris Ofon on 10/21/22.
//

import UIKit

protocol LogoutDelegate: AnyObject {
    func didLogout()
}
protocol LoginViewControllerDelegate: AnyObject {
    func didLogin()
}

class LoginViewController: UIViewController {
    
    let loginView = LoginView()
    let signInButton = UIButton(type: .system)
    let errorMessageLabel = UILabel()
    let titleLabel = UILabel()
    let titleMessageLabel = UILabel()
    
    weak var delegate : LoginViewControllerDelegate?
    
    //animation
    var leadingEdgeOnScreen: CGFloat = 16
    var leadingEdgeOffScreen: CGFloat = -1000
    
    var titleLeadingAnchor: NSLayoutConstraint?
    var titleMessageAnchor: NSLayoutConstraint?


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        style()
        layout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animate()
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
        
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        signInButton.configuration = .filled()
        //SignInButton.configuration?.imagePadding = 8
        signInButton.setTitle("Sign In", for: .normal)
        signInButton.addTarget(self, action: #selector(signInTapped), for: .primaryActionTriggered)
        
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
        titleLabel.alpha = 0
        
        titleMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        titleMessageLabel.text = "Your premium source for all things banking!"
        titleMessageLabel.numberOfLines = 0
        titleMessageLabel.alpha = 0
        
        
    }
    
    private func layout(){
        view.addSubview(loginView)
        view.addSubview(signInButton)
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
            signInButton.topAnchor.constraint(equalToSystemSpacingBelow: loginView.bottomAnchor, multiplier: 2),
            signInButton.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            signInButton.trailingAnchor.constraint(equalTo: loginView.trailingAnchor)
        
        ])
        
        //error message
        NSLayoutConstraint.activate([
            errorMessageLabel.topAnchor.constraint(equalToSystemSpacingBelow: signInButton.bottomAnchor, multiplier: 2),
            errorMessageLabel.leadingAnchor.constraint(equalTo: signInButton.leadingAnchor),
            errorMessageLabel.trailingAnchor.constraint(equalTo: signInButton.trailingAnchor)
        ])
        
        //title
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalToSystemSpacingBelow: view.topAnchor, multiplier: 20),
            titleLabel.trailingAnchor.constraint(equalTo: loginView.trailingAnchor)

        ])
            
        titleLeadingAnchor = titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leadingEdgeOffScreen)
        titleLeadingAnchor?.isActive = true
        
        //title message
        NSLayoutConstraint.activate([
            titleMessageLabel.topAnchor.constraint(equalToSystemSpacingBelow: titleLabel.bottomAnchor, multiplier: 2)
        ])
        
        titleMessageAnchor = titleMessageLabel.leadingAnchor.constraint(equalTo: loginView.leadingAnchor,constant: leadingEdgeOffScreen)
        
        titleMessageAnchor?.isActive = true
        
        
        
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
        if username == "Kevin _" && password == "welcome _" {
            signInButton.configuration?.showsActivityIndicator = true
            delegate?.didLogin()
        } else {
            configureView(withMessage: "Username / password wrong")
        }
    }
        
        private func configureView(withMessage message: String){
            errorMessageLabel.isHidden = false
            errorMessageLabel.text = message
            shakeButton()
        }
    
    private func shakeButton() {
        let animation = CAKeyframeAnimation()
        animation.keyPath = "position.x"
        animation.values = [0, 10, -10, 10, 0]
        animation.keyTimes = [0, 0.16, 0.5, 0.83, 1]
        animation.duration = 0.4

        animation.isAdditive = true
        signInButton.layer.add(animation, forKey: "shake")
    }
}

// MARK: - Animations
extension LoginViewController {
    
    private func animate() {
        let animator1 = UIViewPropertyAnimator(duration: 1.5, curve: .easeInOut) {
            self.titleLeadingAnchor?.constant = self.leadingEdgeOnScreen
            self.view.layoutIfNeeded()
        }
        animator1.startAnimation()
        
        let animator2 = UIViewPropertyAnimator(duration: 1.5, curve: .easeInOut) {
            self.titleMessageAnchor?.constant = self.leadingEdgeOnScreen
            self.view.layoutIfNeeded()
        }
        animator2.startAnimation(afterDelay: 0.25)
        
        let animator3 = UIViewPropertyAnimator(duration: 6, curve: .easeInOut) {
            self.titleLabel.alpha = 1
            self.titleMessageLabel.alpha = 1
            self.view.layoutIfNeeded()
        }
        animator3.startAnimation()
    }
}
