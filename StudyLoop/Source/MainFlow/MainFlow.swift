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

        launch()
    }

    // MARK: - Public methods
    func start() {
        window?.rootViewController = rootVC
    }
}

private extension MainFlow {
    // MARK: - Private methods
    func launch() {
        let viewController = createTabBarController()
        rootVC = UINavigationController(rootViewController: viewController)

        let appearance = UITabBarAppearance()
        configureTabBarAppearance(appearance: appearance)
    }

    // TabBarController
    func createTabBarController() -> UITabBarController {
        let innerMyWordsFlow = MyWordsFlow()
        let myWordsController = innerMyWordsFlow.makeStartFlow()

        let innerSettingsFlow = SettingsFlow()
        let settingsController = innerSettingsFlow.makeStartFlow()

        let items = TabBarResources.ItemController(myWords: myWordsController, settings: settingsController)
        let handlers = TabBarResources.Handlers(
            controllers: { () -> TabBarResources.ItemController in
                return items
            }
        )
        return TabBarFactory().makeController(handlers: handlers)
    }
}
