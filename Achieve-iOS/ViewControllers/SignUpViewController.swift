//
//  SignUpViewController.swift
//  Achieve-iOS
//
//  Created by Mohamad on 2020-10-05.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class SignUpViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet var emailTF: UITextField!
    @IBOutlet var userNameTF: UITextField!
    @IBOutlet var passwordTF: UITextField!
    
    var uid :String = "";
    


    override func viewDidLoad() {
        super.viewDidLoad()

        self.emailTF.delegate = self
        self.userNameTF.delegate = self
        self.passwordTF.delegate = self

    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailTF.resignFirstResponder()
        userNameTF.resignFirstResponder()
        passwordTF.resignFirstResponder()
        return(true)

    }
    
    
    @IBAction func SignUpClick(_ sender: Any) {
        if emailTF.text != nil && passwordTF.text != nil && userNameTF.text != nil{
            Auth.auth().createUser(withEmail: emailTF.text!, password: passwordTF.text!, completion: { (result, error) in
                if error != nil {
                    print("there was an error", error!)
                } else {
                    self.uid = (result?.user.uid)!
                    let ref = Database.database().reference(withPath: "users").child(self.uid).child("userInfo")
                    ref.setValue(["email" : self.emailTF.text , "userName": self.userNameTF.text] )
                    
                    
                    
                    let mainListStoryboard = UIStoryboard(name: "MainList", bundle: nil).instantiateInitialViewController() as! UINavigationController
                    mainListStoryboard.modalPresentationStyle = .fullScreen
                    self.present(mainListStoryboard, animated:true, completion: nil)
                    
                }
            } )
            
        }
    }
    
    @IBAction func dissMissClick(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }

}
