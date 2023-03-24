//
//  LoginVM.swift
//  NetflixClone
//
//  Created by Ahmet Utlu on 21.03.2023.
//

import Foundation

enum LoginVMStateChange: StateChange {
    case LoginSuccess
    case networkFailure(String)
}

class LoginVM: StatefulVM<LoginVMStateChange> {
    let dataSource = LoginDS()
    
    
    //MARK: - Network Request

    func createToken() {
        
        Networking.request(router: AuthRouter.createToken) { (response: CreateTokenResponseModel?, errorString) in
            guard let response = response,
                  let token = response.requestToken else { return }
            
            if response.success {
                self.login(token)
            }
            
        } onFailure: { (errorString, errorType) in
            guard let error = errorString else { return }
            
            self.emit(.networkFailure(error))
        }
    }
    
    func login(_ token: String) {
        var model = LoginRequestModel()
        model.username = dataSource.username
        model.password = dataSource.password
        model.requestToken = token
        
        Networking.request(router: AuthRouter.login(model)) { (response: CreateTokenResponseModel?, errorString) in
            guard let response = response,
                  let token = response.requestToken else { return }
            
            if response.success {
                self.createSession(token)
                Defs.shared.defsUserModel = UserModel()
                Defs.shared.defsUserModel?.setup(username: model.username, name: model.password)
            }
            
        } onFailure: { (errorString, errorType) in
            
            self.emit(.networkFailure(errorString ?? "Please check your username or password."))
        }
    }
    
    func createSession(_ token: String) {
        Networking.request(router: AuthRouter.createSession(token)) { (response: CreateSessionResponseModel?, errorString) in
            guard let response = response,
                  let sessionId = response.sessionId else { return }
            
            if response.success {
                self.getAccountDetail(sessionId: sessionId)
            }
            
        } onFailure: { (errorString, errorType) in
            guard let error = errorString else { return }
            
            self.emit(.networkFailure(error))
        }
    }
    
    func getAccountDetail(sessionId: String) {
        Networking.request(router: AccountRouter.detail(sessionId), shouldShowLoading: true) { (response: AccountDetailResponseModel?, errorString) in
            guard let response = response else { return }
            
            Defs.shared.defsUserModel = UserModel()
            Defs.shared.defsUserModel?.setup(model: response)
            self.emit(.LoginSuccess)
            
        } onFailure: { (errorString, errorType) in
            guard let error = errorString else { return }
            
            self.emit(.networkFailure(error))
        }
    }
}
