//
//  MyWordsFactory.swift
//  StudyLoop
//
//  Created by Eugene Mokhan on 06/11/2021.
//

import UIKit

final class MyWordsFactory {
    func makeContorller(handlers: MyWordsResources.Handlers) -> UIViewController {
        let viewModel = MyWordsViewModel(handlers: handlers)
        let viewController = MyWordsViewController()

        viewController.configure(viewModel: viewModel)

        return viewController
    }
}
