//
//  SettingsFlow.swift
//  StudyLoop
//
//  Created by Eugene Mokhan on 06/11/2021.
//

import UIKit

final class SettingsFlow {
    func makeStartFlow() -> UIViewController {
        let handlers = SettingsResources.Handlers()
        return SettingsFactory().createController(handlers: handlers)
    }
}
