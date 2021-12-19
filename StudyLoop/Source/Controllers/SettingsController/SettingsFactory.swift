//
//  SettingsFactory.swift
//  StudyLoop
//
//  Created by Eugene Mokhan on 06/11/2021.
//

import UIKit

final class SettingsFactory {
    func createController(handlers: SettingsResources.Handlers) -> UIViewController {
        let viewModel = SettingsViewModel(handlers: handlers)
        let viewController = SettingsViewController()

        viewController.configure(viewModel: viewModel)

        return viewController
    }
}
