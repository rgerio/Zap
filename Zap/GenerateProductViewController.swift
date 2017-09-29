//
//  GenerateProductViewController.swift
//  Zap
//
//  Created by Matheus Herminio de Carvalho on 29/09/17.
//  Copyright © 2017 Zap. All rights reserved.
//

import UIKit
import Firebase

class GenerateProductViewController: UIViewController,UITextFieldDelegate,UITextViewDelegate{
// UITextViewDelegate
    //let rootRef = database().reference()
    var ref: DatabaseReference! = Database.database().reference()
    
    @IBOutlet weak var nomeLojaTextField: UITextField!
    @IBOutlet weak var nomeVendedorTextField: UITextField!
    @IBOutlet weak var nomeProduoTextField: UITextField!
    @IBOutlet weak var descricaoTextView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nomeLojaTextField.delegate = self
        nomeVendedorTextField.delegate = self
        nomeProduoTextField.delegate = self
        descricaoTextView.delegate = self
        drawDescricaoTextView()
    

        // Do any additional setup after loading the view.
    }
    
    func drawDescricaoTextView(){
        let color = UIColor(red: 186/255, green: 186/255, blue: 186/255, alpha: 1.0).cgColor
        descricaoTextView.layer.borderColor = color
        descricaoTextView.layer.borderWidth = 0.5
        descricaoTextView.layer.cornerRadius = 5
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func textFieldShouldReturn(_ textField : UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
    if (text == "\n") {
    textView.resignFirstResponder()
    return false
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

}
