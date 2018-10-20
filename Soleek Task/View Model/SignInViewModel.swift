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
    
    
    func checkIfUserExistAndCorrect(myUser: User, success:@escaping (String) -> Void)  {
        
        fireData.getFromFire(success: { (allUsers) in
            if allUsers == nil {
                success("Please check your internet Connection")
            }
            for user in allUsers! {
                print(user.email!)
                if user.email == myUser.email! {
                    print(myUser.email!)
                    print("User Exists")
                    if user.password == myUser.password! {
                        success("User Exists")
                        break
                    } else {
                        success("Please check your password and try again")
                        break
                    }
                }
            }
             success("Please check your Email and try again")
        })
        
    }
    
    
}
