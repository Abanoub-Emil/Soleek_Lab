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
    
    @IBOutlet weak var waitingSpinner: UIActivityIndicatorView!
    @IBOutlet weak var userEmail: UITextField!
    
    @IBOutlet weak var userPassword: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.userEmail.delegate=self
        self.userPassword.delegate=self
//        fireData = FirebaseLogic()
    }

    @IBAction func signIn(_ sender: UIButton) {
        waitingSpinner.isHidden = false
        let isDataEmpty = setUserData()
        if(!isDataEmpty){
            signInViewModel.checkIfUserExistAndCorrect(myUser: user){userFound in
                if userFound == "User Exists"{
                    self.waitingSpinner.isHidden = true
                    self.performSegue(withIdentifier: "signInToCountries", sender: sender)
                } else {
                    self.waitingSpinner.isHidden = true
                    self.showWarning(warningMsg: userFound)
                }
            }
        }
        
        
        
    }
    
    
    @IBAction func signUp(_ sender: Any) {
        
    }
    
    func setUserData() -> Bool {
        if userEmail.text == "" || userPassword.text == "" {
            showWarning(warningMsg: "Please Ente Missing Fields")
            return true
        }
        user.email = userEmail.text
        user.password = userPassword.text
        
        return false
    }
    
    override func performSegue(withIdentifier identifier: String, sender: Any?) {
        
        if identifier == "signInToCountries" {
            let storyboard = UIStoryboard(name: "CountriesStoryBoard", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "CountriesViewController") as UIViewController
            present(vc, animated: true, completion: nil)
        }
        
    }
    
    
    func showWarning(warningMsg: String){
        let alert = UIAlertController(title: "Alert", message: warningMsg, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
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

