//
//  MyWordsFlow.swift
//  StudyLoop
//
//  Created by Eugene Mokhan on 06/11/2021.
//

import UIKit

final class MyWordsFlow {
    func makeStartFlow() -> UIViewController {
        let handlers = MyWordsResources.Handlers()
        return MyWordsFactory().makeContorller(handlers: handlers)
    }
}
