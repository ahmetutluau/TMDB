//
//  StatefulDS.swift
//  NetflixClone
//
//  Created by Ahmet Utlu on 1.03.2023.
//

import Foundation

class StatefulDS<StateChange>: NSObject {
    
    typealias StateChangeHandler = ((StateChange) -> Void)
    
    private var stateChangeHandler: StateChangeHandler?
    
    final func subscribe(_ handler: @escaping StateChangeHandler) {
        stateChangeHandler = handler
    }
    
    final func emit(_ change: StateChange) {
        stateChangeHandler?(change)
    }
}
