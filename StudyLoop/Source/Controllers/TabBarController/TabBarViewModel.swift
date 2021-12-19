//
//  TabBarViewModel.swift
//  StudyLoop
//
//  Created by Eugene Mokhan on 06/11/2021.
//

import Foundation
import UIKit

final class TabBarViewModel {
    // MARK: - Private properties
    private let handlers: TabBarResources.Handlers

    // MARK: - Initializator
    init(handlers: TabBarResources.Handlers) {
        self.handlers = handlers
    }

    // MARK: - Public methods
    func controllers() -> [UINavigationController] {
        let items = handlers.controllers()
        var controllers: [UINavigationController] = []

        if let myWordsController = items.myWords {
            let myWords = UINavigationController(rootViewController: myWordsController)
            myWords.tabBarItem = UITabBarItem(title: TabBarResources.DisplayData.myWordsTitle,
                                              image: R.image.myWordsIcon(),
                                              selectedImage: nil)
            controllers.append(myWords)
        }

        if let settingsController = items.settings {
            let settings = UINavigationController(rootViewController: settingsController)
            settings.tabBarItem = UITabBarItem(title: TabBarResources.DisplayData.settingsTitle,
                                               image: R.image.settingsIcon(),
                                               selectedImage: nil)
            controllers.append(settings)
        }

        return controllers
    }
}
