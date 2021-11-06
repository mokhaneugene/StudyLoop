//
//  MainFlow.swift
//  StudyLoop
//
//  Created by Eugene Mokhan on 06/11/2021.
//

import UIKit

final class MainFlow {
    // MARK: - Private properties
    private var window: UIWindow?
    private var rootVC: UINavigationController?

    // MARK: - Initializator
    init(window: UIWindow?) {
        self.window = window

        self.launch()
    }

    // MARK: - Public methods
    func start() {
        self.window?.rootViewController = self.rootVC
    }
}

private extension MainFlow {
    // MARK: - Private methods
    func launch() {
        let viewController = self.createTabBarController()
        rootVC = UINavigationController(rootViewController: viewController)
    }

    // TabBarController
    func createTabBarController() -> UITabBarController {
        let handlers = TabBarResources.Handlers()
        return TabBarFactory().makeController(handlers: handlers)
    }
}
