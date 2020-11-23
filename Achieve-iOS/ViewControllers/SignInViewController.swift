//
//  SignInViewController.swift
//  Achieve-iOS
//
//  Created by Mohamad on 2020-10-05.
//

import UIKit
import FirebaseAuth

class SignInViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var passwordTF: UITextField!
    @IBOutlet var emailTF: UITextField!
    
    
    var uid:String = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.emailTF.delegate = self
        self.passwordTF.delegate = self

    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailTF.resignFirstResponder()
        passwordTF.resignFirstResponder()
        return(true)

    }
    
    
    
    
    @IBAction func SignInClick(_ sender: Any) {
        
        if emailTF.text != nil && passwordTF.text != nil{
            Auth.auth().signIn(withEmail: emailTF.text!, password: passwordTF.text!, completion: { (result, error) in
                if error != nil {
                    print("there was an error", error!)
                } else {
                    self.uid = (result?.user.uid)!
                    print("works!!!!!!!!!!!!!", self.uid)
                    
                    
                    let mainListStoryboard = UIStoryboard(name: "MainList", bundle: nil).instantiateInitialViewController() as! UINavigationController
                    mainListStoryboard.modalPresentationStyle = .fullScreen
                    self.present(mainListStoryboard, animated:true, completion: nil)
                    
                    
                }
            })
        }
    }
    

    

}
