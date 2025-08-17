//
//  LoginViewModel.swift
//  KitmanAthletes
//
//  Created by Kimti Vaghasia on 16/08/2025.
//
import SwiftUI

class LoginViewModel: ObservableObject {

    @Published var username: String = ""
    @Published var password: String = ""
    @Published var loginSuccess : Bool = false
    
    func login() {
        let loginService = LoginService(apiClient: APIClient())

        loginService.authenticateUser(userName: username, password: password ) { response in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [self] in
                
                if response.error != nil {
                    self.loginSuccess = false
                } else {
                    self.loginSuccess = true
                }
            }
        }
    }
}
