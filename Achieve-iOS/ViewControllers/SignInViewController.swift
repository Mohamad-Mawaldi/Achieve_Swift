//
//  SignInViewController.swift
//  Achieve-iOS
//
//  Created by Mohamad on 2020-10-05.
//

import UIKit
import FirebaseAuth

class SignInViewController: UIViewController {

    @IBOutlet var passwordTF: UITextField!
    @IBOutlet var emailTF: UITextField!
    
    
    var uid:String = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func SignInClick(_ sender: Any) {
        
        if emailTF.text != nil && passwordTF.text != nil{
            Auth.auth().signIn(withEmail: emailTF.text!, password: passwordTF.text!, completion: { (result, error) in
                if error != nil {
                    print("there was an error", error!)
                } else {
                    self.uid = (result?.user.uid)!
                    print("works!!!!!!!!!!!!!", self.uid)
                    
                    let mainListController = self.storyboard?.instantiateViewController(withIdentifier: "MainList") as! TaskViewController
                    mainListController.modalPresentationStyle = .fullScreen
                    self.present(mainListController, animated:true, completion: nil)


                    
                    
                }
            })
        }
    }
    

    

}
