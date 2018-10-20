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
    var handle: Auth?
    
    @IBOutlet weak var waitingSpinner: UIActivityIndicatorView!
    @IBOutlet weak var userEmail: UITextField!
    
    @IBOutlet weak var userPassword: UITextField!
    
    override func viewWillAppear(_ animated: Bool) {
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            // ...
            } as? Auth
        userEmail.text = ""
        userPassword.text = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.userEmail.delegate=self
        self.userPassword.delegate=self
//        fireData = FirebaseLogic()
    }

    @IBAction func signIn(_ sender: UIButton) {
        
        let isDataEmpty = setUserData()
        if(!isDataEmpty){
//            waitingSpinner.isHidden = false
//            signInViewModel.checkIfUserExistAndCorrect(myUser: user){userFound in
//                if userFound == "User Exists"{
//                    self.waitingSpinner.isHidden = true
//                    self.performSegue(withIdentifier: "signInToCountries", sender: sender)
//                } else {
//                    self.waitingSpinner.isHidden = true
//                    self.showWarning(warningMsg: userFound)
//                }
//            }
            let email = userEmail.text!
            
            Auth.auth().signIn(withEmail:  email, password: userPassword.text!) { (user, error) in
                guard let myUser = user?.email else {
                    self.showWarning(warningMsg: error!.localizedDescription)
//                    print(error?.localizedDescription)
                    return }
                print(myUser)
                 self.performSegue(withIdentifier: "signInToCountries", sender: sender)
            }

        }
                
    }
    
    
    @IBAction func signUp(_ sender: Any) {
        
        
    }
    
    func setUserData() -> Bool {
        if userEmail.text == "" || userPassword.text == "" {
            showWarning(warningMsg: "Please Enter Missing Fields")
            return true
        }
        user.email = userEmail.text
        user.password = userPassword.text
        
        return false
    }
    
    override func performSegue(withIdentifier identifier: String, sender: Any?) {
        
        if identifier == "signInToCountries" {
            let storyboard = UIStoryboard(name: "CountriesStoryBoard", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "CountriesViewController") as! CountriesTableViewController
            present(vc, animated: true, completion: nil)
        }
        
    }
    
    
    func showWarning(warningMsg: String){
        let alert = UIAlertController(title: "Alert", message: warningMsg, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if (handle != nil){
             Auth.auth().removeStateDidChangeListener(handle!)
        }
       
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

