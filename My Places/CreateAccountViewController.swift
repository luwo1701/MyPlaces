//
//  CreateAccountViewController.swift
//  My Places
//
//  Created by Luke Worley on 6/19/17.
//  Copyright © 2017 Luke Worley. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
class CreateAccountViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var confirm: UITextField!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        email.tag=0
        password.tag=1
        confirm.tag=2
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("delegate set")
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nextField = textField.superview?.viewWithTag(textField.tag+1)
        
        if nextField != nil{
            print("completed")
            textField.resignFirstResponder()
            nextField?.becomeFirstResponder()

        }
        else{
            self.createNewAccount()
        }
        
        return true
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func createNewAccount(){
        print("function called by return")
        if password.text==confirm.text{
            print("continuing")
            FIRAuth.auth()?.createUser(withEmail: email.text!, password: password.text!, completion: { (user, error) in
                if error==nil{
                    print("added user")
                }
                else{
                    print(error as! String)
                }
            })
            
            
        }
            
        else{
            let alert = UIAlertController(title: "Incorrect Password", message: "Your passwords don't match", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            
            // show the alert
            self.present(alert, animated: true, completion: nil)
        }
        
    }

}
