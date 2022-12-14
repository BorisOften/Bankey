//
//  AppDelegate.swift
//  Bankey
//
//  Created by Boris Ofon on 10/21/22.
//

import UIKit

let appColor : UIColor = .systemTeal

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    var window: UIWindow?
    let loginViewController = LoginViewController()
    let onBoardingContainerViewController = OnboardingContainerViewController()
    let dummyViewController = DummyViewController()
    let mainViewController = MainViewController()
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        
        loginViewController.delegate = self
        onBoardingContainerViewController.delegate = self
        dummyViewController.delegate = self
        
        //window?.rootViewController = AccountSummaryViewController()
        //window?.rootViewController = mainViewController
        //window?.rootViewController = loginViewController
        //window?.rootViewController = onBoardingContainerViewController
        //window?.rootViewController = dummyViewController
        
        displayLogin()
        registerForNotifications()
        
        
        return true
    }
    
    private func displayLogin(){
        setRootViewController(loginViewController)
    }
    
    private func registerForNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(didLogout), name: .logout, object: nil)
    }
    
    
    private func displayNextScreen() {
            if LocalState.hasOnboarded {
                prepMainView()
                setRootViewController(mainViewController)
            } else {
                setRootViewController(onBoardingContainerViewController)
            }
        }
    
    private func prepMainView() {
            mainViewController.setStatusBar()
            UINavigationBar.appearance().isTranslucent = false
            UINavigationBar.appearance().backgroundColor = appColor
        }
}

extension AppDelegate : LoginViewControllerDelegate {
    func didLogin() {
       displayNextScreen()
    }
}

extension AppDelegate : OnboardingContainerViewControllerDelegate {
    func didFinishOnboarding() {
        LocalState.hasOnboarded = true
        prepMainView()
        setRootViewController(mainViewController)
    }
}

extension AppDelegate : LogoutDelegate {
    @objc func didLogout() {
        setRootViewController(loginViewController)
    }
    
    
}

extension AppDelegate {
    func setRootViewController(_ vc: UIViewController, animated: Bool = true) {
        guard animated, let window = self.window else {
            self.window?.rootViewController = vc
            self.window?.makeKeyAndVisible()
            return
        }

        window.rootViewController = vc
        window.makeKeyAndVisible()
        UIView.transition(with: window,
                          duration: 0.3,
                          options: .transitionCrossDissolve,
                          animations: nil,
                          completion: nil)
    }
}

