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
                    
                    let mainTabController = self.storyboard?.instantiateViewController(withIdentifier: "MainTabBar") as! TabBarViewController
            
                    NotificationCenter.default.post(name: Notification.Name("userID"), object: self.uid)
                    
                    mainTabController.modalPresentationStyle = .fullScreen
                    self.present(mainTabController, animated:true, completion: nil)

                    
                    
                }
            })
        }
    }
    

    

}
