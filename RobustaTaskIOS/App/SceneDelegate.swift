//
//  SceneDelegate.swift
//  RobustaTaskIOS
//
//  Created by Zyad Galal on 26/03/2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window?.windowScene = windowScene
        let viewController = RepositoriesListRouter.createRepositoriesList()
        let navigationController = UINavigationController(rootViewController: viewController)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}

