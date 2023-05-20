//
//  SceneDelegate.swift
//  BusinessEnamDua
//
//  Created by yxgg on 20/05/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let mainViewController = ListBusinessViewController(nibName: "ListBusinessViewController", bundle: nil)
        let navigationController = UINavigationController(rootViewController: mainViewController)
        let viewModel = ListBusinessViewModel(listBusinessUseCase: Injection().provideListBusiness())
        mainViewController.viewModel = viewModel
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
}
