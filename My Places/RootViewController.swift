//
//  RootViewController.swift
//  My Places
//
//  Created by Luke Worley on 6/18/17.
//  Copyright © 2017 Luke Worley. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class RootViewController: UIViewController, UITextFieldDelegate{
    
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var input: UITextField!
    var rootRef: FIRDatabaseReference!

   //let ref = FIRDatabase.database().reference(withPath: "locations")

    override func viewDidLoad() {
        super.viewDidLoad()
        input.tag=0
        password.tag=1
        rootRef = FIRDatabase.database().reference()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UIPageViewController delegate methods

    func textFieldDidEndEditing(_ textField: UITextField) {
        
        let itemsRef = rootRef.database.reference(withPath: "locations")
        let newLoc = itemsRef.child("location")
        newLoc.setValue(input.text!)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nextField = textField.superview?.viewWithTag(textField.tag+1)
        
        if nextField != nil{
            textField.resignFirstResponder()
            nextField?.becomeFirstResponder()
            
        }
        else{
            self.signIn()
        }
        
        return true

    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("text field begain editing")
    }
    
    func signIn(){
        if input.text == "" || password.text == nil{
            let alert = UIAlertController(title: "Missing Field", message: "One or both of the textfields are empty", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            
            // show the alert
            self.present(alert, animated: true, completion: nil)
        }
        else{
            FIRAuth.auth()?.signIn(withEmail: input.text!, password: password.text!, completion: { (user, error) in
                if error == nil{
                    
                    print("signed in")
                    
                }
                else {
                    print(error as! String)
                }
            })
        }
    }
}
