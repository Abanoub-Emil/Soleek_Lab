//
//  FireDatabase.swift
//  FireBaseDemo
//
//  Created by Champion on 5/18/18.
//  Copyright © 2018 ITI. All rights reserved.
//

import Foundation
import Firebase

class FirebaseLogic {
    var ref:DatabaseReference!
    var user:User!
    var val:NSMutableDictionary
    init() {
        user = User()
        ref = Database.database().reference()
        val=[:]
    }
    
    func savetoFire(obj:User) {
        let child1 = self.ref.child("Inova").child("Greetings").childByAutoId()
        
        child1.setValue("Hello \(obj.email ?? "inova")")
       
        
        let msg:Dictionary = ["My Name":obj.email!,
                              "Company Name":obj.password! ,
                              "Post Time":ServerValue.timestamp()]
                               as [String:Any]
        
        self.ref.child("Inova").child("Info").setValue(msg)
        
    }
    
    func showFromFire(subChild:String) {
        
        self.ref.child("Inova").child("Info").observeSingleEvent(of: .value, with: { (snapshot) in
            let xval = snapshot.value as? NSDictionary
            for (key, value) in xval! {
                self.val[key]=value
                print("\(key) : \(value)")
                
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
