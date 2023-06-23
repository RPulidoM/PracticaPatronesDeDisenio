//
//  LoginModel.swift
//  PracticaPatronesDisenio
//
//  Created by Rubén Pulido Marchal on 23/6/23.
//

import Foundation

class LoginModel: NSObject {
    
    var updateUI: ((_ token: String, _ error: String) -> Void)?

    func login(email: String, password: String) {
        
        ApiClient(token: "").login(user: email, password: password) { [weak self] token, error in
            debugPrint(token ?? "")
            debugPrint(error ?? "")
            
            if let token = token {
                self?.updateUI?(token, "")
                return
            }

            if let error = error {
                self?.updateUI?("", error.localizedDescription)
                return
            }

        }
    }

}
