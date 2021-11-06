//
//  TabBarViewModel.swift
//  StudyLoop
//
//  Created by Eugene Mokhan on 06/11/2021.
//

import Foundation

final class TabBarViewModel {
    // MARK: - Private properties
    private let handlers: TabBarResources.Handlers

    // MARK: - Initializator
    init(handlers: TabBarResources.Handlers) {
        self.handlers = handlers
    }

    // MARK: - Public methods
    @objc func didTapButton() {
        handlers.onTapButton()
    }
}
