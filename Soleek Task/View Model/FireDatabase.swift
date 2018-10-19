//
//  FireDatabase.swift
//  FireBaseDemo
//
//  Created by Champion on 5/18/18.
//  Copyright © 2018 ITI. All rights reserved.
//

import Foundation
import Firebase
import SwiftyJSON

class FirebaseLogic {
    var ref:DatabaseReference!
    var user:User!
    var val:NSMutableDictionary
    init() {
        user = User()
        ref = Database.database().reference()
        val=[:]
    }
    
    func savetoFire(obj: User) {
        
//        let child1 = self.ref.child("Inova").child("Greetings").childByAutoId()
//
//        child1.setValue("Hello \(obj.email ?? "inova")")
        if obj.email == nil || obj.password == nil {
            print("no fetched data")
            return
        }
        
        let msg:Dictionary = ["Email":obj.email!,
                              "Password":obj.password!] as [String:Any]
        
        self.ref.child("Users").childByAutoId().setValue(msg)
        
    }
    
    func getFromFire(success:@escaping ([User]) -> Void) {
        var allUsers = [User]()
        self.ref.child("Users").observeSingleEvent(of: .value, with: { (snapshot) in
            let xval = snapshot.value as? NSDictionary
            if xval != nil{
               
                for (key, value) in xval! {
                    let myUser = User()
                    self.val[key]=value
                    //                print("\(key) : \(value)")
                    let resJson = JSON(value)
                    myUser.email = resJson["Email"].stringValue
                    myUser.password = resJson["Password"].stringValue
                    
                    allUsers.append(myUser)
                }
                success(allUsers)
            }
        })
        { (error) in
            print(error.localizedDescription)
        }
    }
    
    func deleteFromFire(subChild:String){
        self.ref.child("Inova").child("Greetings").removeValue()
        self.ref.child("Inova").child("Info").removeValue()
    }
}
