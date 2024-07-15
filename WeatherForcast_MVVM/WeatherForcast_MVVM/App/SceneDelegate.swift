//
//  SceneDelegate.swift
//  WeatherForcast_MVVM
//
//  Created by BOMBSGIE on 4/29/24.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    private let appEnvironment = AppEnvironment.shared
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windwScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windwScene)
        window?.rootViewController = appEnvironment.mainWeatherViewController
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) { }
    func sceneDidBecomeActive(_ scene: UIScene) { }
    func sceneWillResignActive(_ scene: UIScene) { }
    func sceneWillEnterForeground(_ scene: UIScene) { }
    func sceneDidEnterBackground(_ scene: UIScene) { }
}

