//
//  TabBarFactory.swift
//  StudyLoop
//
//  Created by Eugene Mokhan on 06/11/2021.
//

import UIKit

final class TabBarFactory {
    func makeController(handlers: TabBarResources.Handlers) -> UITabBarController {
        let viewModel = TabBarViewModel(handlers: handlers)
        let viewController = TabBarViewContorller()

        viewController.configure(viewModel: viewModel)

        return viewController
    }
}

