//
//  SignUpViewModel.swift
//  Soleek Task
//
//  Created by Champion on 10/19/18.
//  Copyright © 2018 ITI. All rights reserved.
//

import Foundation

class SignUpViewModel {
    
    lazy var fireData = FirebaseLogic()
    
    
    
    func checkIfUserExistAndSaveData(myUser: User, success:@escaping (String) -> Void) {
        fireData.getFromFire(success: { (allUsers) in
            if allUsers == nil {
                return
            }
            for user in allUsers! {
                print(user.email!)
                if user.email == myUser.email{
                    success("User Exists")
                    return
                }
            }
            self.fireData.savetoFire(obj: myUser)
            success("New User")
        })
        
    }
}
