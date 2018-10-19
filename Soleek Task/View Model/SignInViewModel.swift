//
//  SignInViewModel.swift
//  Soleek Task
//
//  Created by Champion on 10/19/18.
//  Copyright © 2018 ITI. All rights reserved.
//

import Foundation
import Firebase

class SignInViewModel {
    
    lazy var fireData = FirebaseLogic()
    

    
    func checkIfUserExistAndSaveData(myUser: User) {
        fireData.getFromFire(success: { (allUsers) in
            for user in allUsers {
                print(user.email!)
                if user.email == myUser.email{
                    print("user Exists")
                    return
                }
            }
            self.fireData.savetoFire(obj: myUser)
        })
        
    }
    
    
}
