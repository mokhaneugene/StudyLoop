//
//  SettingsViewModel.swift
//  StudyLoop
//
//  Created by Eugene Mokhan on 06/11/2021.
//

import Foundation

final class SettingsViewModel {
    // MARK: - Private properties
    private typealias Constants = SettingsResources.Constants
    
    private let handlers: SettingsResources.Handlers

    // MARK: - Public properties
    var cellsModel: [SettingsCell.Model] = []

    var onStateChange: ((SettingsResources.State) -> Void)?

    // MARK: - Initializator
    init(handlers: SettingsResources.Handlers) {
        self.handlers = handlers
    }

    // MARK: - Public methods
    func launch() {
        setupItems()
    }

    func setModelForSettingCell(_ settingCell: SettingsCell?, indexPath: IndexPath) {
        guard let cellModel = cellsModel[safe: indexPath.row] else { return }
        settingCell?.configure(with: cellModel)
    }
}

private extension SettingsViewModel {
    // MARK: - Private methods
    func setupItems() {
        onStateChange?(.onDataReady)
        setupCells()
    }

    func setupCells() {
        cellsModel = [Constants.levelModel,
                      Constants.phrasesModel,
                      Constants.timeModel]
    }
}
