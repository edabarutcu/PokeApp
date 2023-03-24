//
//  ApplicationCoordinator.swift
//  PokemonList
//
//  Created by Eda Barutçu on 21.03.2023.
//

import UIKit

class ApplicationCoordinator : Coordinator {
    
    let window : UIWindow
    let rootViewController : UINavigationController
    let homeCoordinator : ViewControllerCoordinator
    
    init(window: UIWindow) {
        self.window = window
        rootViewController = UINavigationController()
        homeCoordinator = ViewControllerCoordinator(presenter: rootViewController)
    }
    
    func start() {
        window.rootViewController = rootViewController
        homeCoordinator.start()
        window.makeKeyAndVisible()
    }
}
