//
//  ChatViewController.swift
//  Zap
//
//  Created by Rogério Bezerra Santos on 27/09/17.
//  Copyright © 2017 Zap. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    @IBOutlet weak var textFieldChatClient: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet var sendButton: UIButton!
    
    var messages = [String]()
    var conversa_id: DatabaseReference!
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.textFieldChatClient.resignFirstResponder()
        return true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IncomingCell", for: indexPath) as! ChatTableViewCell
        cell.textLabel?.text = self.messages[indexPath.row]
        cell.textLabel?.textAlignment = .right
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func pressedSendButton(_ sender: Any) {
        let str = self.textFieldChatClient.text
        self.messages.append(str!)
        self.textFieldChatClient.text = ""
        self.tableView?.reloadData()
        self.textFieldChatClient.resignFirstResponder()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
