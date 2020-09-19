//
//  LoginViewController.swift
//  iMessage (using Firebase)
//
//  Created by Elbek Shaykulov on 8/9/20.
//  Copyright © 2020 Elbek Shaykulov. All rights reserved.
//

import UIKit
import Firebase
class LoginViewController: UIViewController {

    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    
    @IBAction func loginPressed(_ sender: UIButton) {
        if let email = emailText.text , let password = passwordText.text
        {
            Auth.auth().signIn(withEmail: email, password: password) {   authResult, error in
                if let e = error
                {
                    self.errorLabel.text = e.localizedDescription
                }else{
                    self.performSegue(withIdentifier: "LoginToChat", sender: self)
                }
         }
            
        }
    }
    
    
   


}
