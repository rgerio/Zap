//
//  InputCodeViewController.swift
//  Zap
//
//  Created by Bruno Roberto Gouveia Carneiro da Cunha Filho on 25/09/17.
//  Copyright © 2017 Zap. All rights reserved.
//

import UIKit

class InputCodeViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var inputName: UITextField!
    @IBOutlet weak var inputCode: UITextField!
    @IBOutlet weak var buttonEnterOutlet: UIButton!
    @IBAction func buttonEnter(_ sender: Any?) {
        let alertCode = UIAlertController(title: "Código Inválido", message: "Código Inválido! Por favor tente novamente.", preferredStyle: UIAlertControllerStyle.alert)
        alertCode.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        if let code = self.inputCode.text {
            if code.count < 4 {
                self.present(alertCode, animated: true, completion: nil)
            }
        }
        let alertName = UIAlertController(title: "Nome inválido", message: "Digite o seu nome e tente novamente.", preferredStyle: UIAlertControllerStyle.alert)
        alertName.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        if let name = self.inputName.text {
            if name == "" {
                self.present(alertName, animated: true, completion: nil)
            }
        }
        
        if sender == nil{
            self.performSegue(withIdentifier: "moveToChat", sender: self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inputName.delegate = self
        inputName.tag = 0
        inputCode.delegate = self
        inputCode.tag = 1

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Try to find next responder
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            // Not found, so remove keyboard.
            textField.resignFirstResponder()
            self.buttonEnter(nil)
        }
        // Do not add a line break
        return false
    }
    
    func performAction() {
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == self.inputCode{
            if let text = textField.text {
                if text.count > 3{
                    return false
                }else{
                    return true
                }
            }
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
