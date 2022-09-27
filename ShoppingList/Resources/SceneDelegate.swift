//
//  SceneDelegate.swift
//  ShoppingList
//
//  Created by Giuliano Accorsi on 23/09/22.
//

import UIKit
import Firebase

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.makeKeyAndVisible()
        let navigationController = UINavigationController()
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor:
                                                                        UIColor.title ?? UIColor()]
        if  Auth.auth().currentUser != nil {
            navigationController.viewControllers = [LoggedFactory.make()]
            window?.rootViewController = navigationController
            return

        }
        navigationController.viewControllers = [HomeFactory.make()]
        window?.rootViewController = navigationController

    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {

    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }

}
