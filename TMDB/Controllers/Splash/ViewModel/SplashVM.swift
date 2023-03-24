//
//  SplashVM.swift
//  NetflixClone
//
//  Created by Ahmet Utlu on 22.03.2023.
//

import Foundation

enum SplashVMStateChange: StateChange {
    case handleAuthorized
    case handleNotAuthorized
}

class SplashVM: StatefulVM<SplashVMStateChange> {

    let datasource = SplashDS()
    
    private func hasUserModel() -> Bool {
        return Defs.shared.defsUserModel != nil
    }
    
     func handleNav() {
        if self.hasUserModel() {
            emit(.handleAuthorized)
        } else {
            emit(.handleNotAuthorized)
        }
    }
}
