//
//  Array+Safe.swift
//  StudyLoop
//
//  Created by Eugene Mokhan on 20/12/2021.
//

import Foundation

extension Array {
    subscript(safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
}
