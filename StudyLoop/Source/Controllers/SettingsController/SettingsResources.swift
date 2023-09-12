//
//  SettingsResources.swift
//  StudyLoop
//
//  Created by Eugene Mokhan on 06/11/2021.
//

import Foundation

struct SettingsResources {
    struct Handlers {
        
    }

    enum State {
        case onDataReady
    }

    struct Constants {
        static let levelModel = SettingsCell.Model(title: "Choose your levelChoose your levelChoose your levelChoose your levelChoose your levelChoose your levelChoose your levelChoose your level", summary: "Middle")
        static let phrasesModel = SettingsCell.Model(title: "You like to learn", summary: "PhrasesPhrasesPhrases Phrases PhrasesPhrases Phrases Phrases PhrasesPhrasesPhrasesPhrases")
        static let timeModel = SettingsCell.Model(title: "Choose timeChoose timeChoose timeChoose timeChoose timeChoose timeChoose timeChoose timeChoose timeChoose time", summary: "13:30 - 20:1513:30 - 20:1513:30 - 20:1513:30 - 20:1513:30 - 20:1513:30 - 20:1513:30 - 20:1513:30 - 20:15")
    }
}
