//
//  TabBarResources.swift
//  StudyLoop
//
//  Created by Eugene Mokhan on 06/11/2021.
//

import UIKit

struct TabBarResources {
    struct ItemController {
        var myWords: UIViewController?
        var settings: UIViewController?
    }
    
    struct Handlers {
        var controllers: () -> ItemController
    }

    struct DisplayData {
        static let myWordsTitle = "My words"
        static let settingsTitle = "Settings"
    }
}
