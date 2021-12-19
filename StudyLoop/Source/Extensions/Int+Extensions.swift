//
//  Int+Extensions.swift
//  StudyLoop
//
//  Created by Eugene Mokhan on 17/11/2021.
//

import Foundation

extension Int {
    func formatHoureMinute() -> String {
        let minutes = (self / 60) % 60
        let hours = self / 3600
        let converted =  String(format: "%02d:%02d", hours, minutes)
        return converted
    }
}
