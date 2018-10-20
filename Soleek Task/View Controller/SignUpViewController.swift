//
//  SignUpViewController.swift
//  Soleek Task
//
//  Created by Champion on 10/18/18.
//  Copyright © 2018 ITI. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    var user = User()
    let signUpViewModel = SignUpViewModel()
    
    @IBOutlet weak var userEmail: UITextField!
    
    @IBOutlet weak var userPassword: UITextField!
    
    @IBOutlet weak var confirmUserPassword: UITextField!
    
    @IBOutlet weak var waitingSpinner: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        userEmail.text = ""
        userPassword.text = ""
        confirmUserPassword.text = ""
    }
    
    
    @IBAction func signIn(_ sender: UIButton) {
        let isDataEmpty = setUserData()
        if(!isDataEmpty){
            waitingSpinner.isHidden = false
            signUpViewModel.checkIfUserExistAndSaveData(myUser: user){ userExists in
                if userExists == "User Exists"{
                    self.waitingSpinner.isHidden = true
                    self.showWarning(warningMsg: userExists)
                    return
                } else {
                    self.waitingSpinner.isHidden = true
                    self.performSegue(withIdentifier: "signUpToCountries", sender: sender)
                }
            }
        }
    }
    
    @IBAction func signUp(_ sender: UIButton) {
        
        let isDataEmpty = setUserData()
        if(!isDataEmpty){
            waitingSpinner.isHidden = false
            signUpViewModel.checkIfUserExistAndSaveData(myUser: user){userExists in
                if userExists == "User Exists" {
                    self.waitingSpinner.isHidden = true
                    self.showWarning(warningMsg: userExists)
                    return
                } else {
                    self.waitingSpinner.isHidden = true
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    
    override func performSegue(withIdentifier identifier: String, sender: Any?) {
        
        if identifier == "signUpToCountries" {
            let storyboard = UIStoryboard(name: "CountriesStoryBoard", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "CountriesViewController") as UIViewController
            present(vc, animated: true, completion: nil)
        }
    }
    
    func setUserData() -> Bool {
        if userPassword.text != confirmUserPassword.text{
            showWarning(warningMsg: "First passwrod doesn't match with the second password")
            return true
        }
        
        if userEmail.text == "" || userPassword.text == "" {
            showWarning(warningMsg: "Please Ente Missing Fields")
            return true
        }
        user.email = userEmail.text
        user.password = userPassword.text
        
        return false
    }
    
    func showWarning(warningMsg: String){
        let alert = UIAlertController(title: "Alert", message: warningMsg, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

// MARK: - TextField Delegate

extension SignUpViewController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.userPassword.resignFirstResponder()
        self.userEmail.resignFirstResponder()
        self.confirmUserPassword.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
