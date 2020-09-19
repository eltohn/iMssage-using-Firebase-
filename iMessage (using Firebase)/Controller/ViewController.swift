//
//  ViewController.swift
//  iMessage (using Firebase)
//
//  Created by Elbek Shaykulov on 8/9/20.
//  Copyright © 2020 Elbek Shaykulov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var welcomeLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    

    let welcomeText = "✉️iMessage"
    var timeMultiplier = 1
    override func viewDidLoad() {
        super.viewDidLoad()
      

        for letter in  welcomeText
        {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2 * Double(timeMultiplier))
         {
            self.welcomeLabel.text?.append(letter)
             
         }
            timeMultiplier = timeMultiplier + 1

        }
        
          
        
    }

    
    
     
    

}

