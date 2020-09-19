//
//  ChatViewController.swift
//  iMessage (using Firebase)
//
//  Created by Elbek Shaykulov on 8/9/20.
//  Copyright © 2020 Elbek Shaykulov. All rights reserved.
//

import UIKit
import Firebase

class ChatViewController: UIViewController
{
    
    
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    
    let db = Firestore.firestore()
    var messages :[Message] = []
    
    
    
    override func viewDidLoad() {
        
        navigationItem.hidesBackButton = true
        title = "✉️iMessage"
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
        
        loadData()
    }
    
    
    func loadData()
    {
        
        
        db.collection("messages")
            .order(by: "date")
            .addSnapshotListener { (querySnapshot, error) in
                
                self.messages = []
                if let e  = error {
                    print("Error getting documents: \(e)")
                } else {
                    if let snapshotDocuments = querySnapshot?.documents
                    {
                        for doc in snapshotDocuments
                        {
                            let data = doc.data()
                            if let messageSender = data["sender"] as? String, let messageBody = data["body"] as? String
                            {
                                let newMessage = Message(sender: messageSender , body: messageBody)
                                self.messages.append(newMessage)
                                
                                
                                DispatchQueue.main.async {
                                    self.tableView.reloadData()
                                    let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                                    self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                                    
                                }
                                
                            }
                        }
                        
                    }
                }
        }
        
        
        
    }
    
    
    
    @IBAction func sendPressed(_ sender: UIButton)
    {
        if let messageBody = messageTextfield.text , let messageSender = Auth.auth().currentUser?.email
        {
            db.collection("messages").addDocument(data: ["sender":messageSender,"body":messageBody,"date": Date().timeIntervalSince1970 ] ) { (error) in
                if let e = error
                {
                    print(e.localizedDescription)
                }else{
                    print("Saved")
                    DispatchQueue.main.async {
                        self.messageTextfield.text = ""
                    }
                     
                }
            }
        }
    }
    
    
    
    
    
    
    
    @IBAction func logOut(_ sender: UIBarButtonItem) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        
    }
    
    
    
}



extension ChatViewController: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let message = messages[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! MessageCell
        cell.label.text = message.body
        
        if message.sender ==  Auth.auth().currentUser?.email
        {
            cell.leftImageView.isHidden = true
            cell.rightImageView.isHidden = false
            
        }else{
            cell.leftImageView.isHidden = false
            cell.rightImageView.isHidden = true
        }
        
        return cell
    }
    
    
}
