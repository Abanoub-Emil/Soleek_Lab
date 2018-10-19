//
//   SignInViewController.swift
//  Soleek Task
//
//  Created by Champion on 10/18/18.
//  Copyright © 2018 ITI. All rights reserved.
//

import UIKit
import Firebase

class SignInViewController: UIViewController {
//    var fireData: FirebaseLogic!
    var user = User()
    let signInViewModel = SignInViewModel()
    
    @IBOutlet weak var userEmail: UITextField!
    
    @IBOutlet weak var userPassword: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.userEmail.delegate=self
        self.userPassword.delegate=self
//        fireData = FirebaseLogic()
    }

    @IBAction func signIn(_ sender: UIButton) {
        let isDataEmpty = setUserData()
        if(!isDataEmpty){
            signInViewModel.checkIfUserExistAndSaveData(myUser: user)
        }
        
    }
    
    
    @IBAction func signUp(_ sender: Any) {
        
    }
    
    func setUserData() -> Bool {
        if userEmail.text == "" || userPassword.text == "" {
            return true
        }
        user.email = userEmail.text
        user.password = userPassword.text
        
        return false
    }
    
    
}


// MARK: - TextField Delegate

extension SignInViewController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.userPassword.resignFirstResponder()
        self.userEmail.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

