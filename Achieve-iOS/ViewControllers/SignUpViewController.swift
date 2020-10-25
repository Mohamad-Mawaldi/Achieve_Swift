//
//  SignUpViewController.swift
//  Achieve-iOS
//
//  Created by Mohamad on 2020-10-05.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class SignUpViewController: UIViewController {
    
    
    @IBOutlet var emailTF: UITextField!
    @IBOutlet var userNameTF: UITextField!
    @IBOutlet var passwordTF: UITextField!
    
    var uid :String = "";
    


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func SignUpClick(_ sender: Any) {
        if emailTF.text != nil && passwordTF.text != nil && userNameTF.text != nil{
            Auth.auth().createUser(withEmail: emailTF.text!, password: passwordTF.text!, completion: { (result, error) in
                if error != nil {
                    print("there was an error", error!)
                } else {
                    self.uid = (result?.user.uid)!
                    let ref = Database.database().reference(withPath: "users").child(self.uid).child("userInfo")
                    ref.setValue(["email" : self.emailTF.text , "userName": self.userNameTF.text , "password" : self.passwordTF.text] )
                    
                    
                    NotificationCenter.default.post(name: Notification.Name("userID"), object: self.uid)
                    
                    let mainTabController = self.storyboard?.instantiateViewController(withIdentifier: "MainTabBar") as! TabBarViewController
                    mainTabController.modalPresentationStyle = .fullScreen
                    
                    
                    
                    self.present(mainTabController, animated:true, completion: nil)
                    
                }
            } )
            
        }
    }
    
    @IBAction func dissMissClick(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }

}
