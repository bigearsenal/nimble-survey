//
//  AppDelegate.swift
//  nimble
//
//  Created by Chung Tran on 10/21/20.
//

import UIKit
import RxSwift
@_exported import BEPureLayout

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window : UIWindow?
    let disposeBag = DisposeBag()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UserDefaults.standard.set(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
        
        // Override point for customization after application launch.
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        
        // observe AuthState
        NimbleSurveySDK.shared.authState
            .distinctUntilChanged()
            .subscribe(onNext: { state in
                let rootVC: UIViewController
                switch state {
                case .authorized:
                    rootVC = BENavigationController(rootViewController: HomeVC())
                case .unauthorized:
                    rootVC = BENavigationController(rootViewController: LoginVC())
                }
                window.makeKeyAndVisible()
                UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve) {}

                self.window?.rootViewController = rootVC
            })
            .disposed(by: disposeBag)

        return true
    }

}

