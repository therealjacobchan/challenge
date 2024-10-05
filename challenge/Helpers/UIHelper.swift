//
//  UIHelper.swift
//  challenge
//
//  Created by Jacob Chan on 10/3/24.
//

import UIKit
import Foundation

class UIHelper {
    static func appWindow() -> UIWindow? {
        var window: UIWindow?
        if #available(iOS 13.0, *) {
            let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
            window = sceneDelegate?.window
        } else {
            let appDelegate = UIApplication.shared.delegate as? AppDelegate
            window = appDelegate?.window
        }
        return window
    }
    
    static func loadViewController() {
        let viewController = ChallengeViewController()
        let navController = UINavigationController(rootViewController: viewController)
        navController.isNavigationBarHidden = true
        loadRootPage(viewCtrl: navController)
    }
    
    private static func loadRootPage(viewCtrl: UIViewController) {
        let window: UIWindow? = appWindow()
        window?.rootViewController = viewCtrl
        
        if #available(iOS 13.0, *) {
            let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
            sceneDelegate?.window = sceneDelegate?.window
        } else {
            let appDelegate = UIApplication.shared.delegate as? AppDelegate
            appDelegate?.window = appDelegate?.window
        }
    }
}
