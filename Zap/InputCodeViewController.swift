//
//  InputCodeViewController.swift
//  Zap
//
//  Created by Bruno Roberto Gouveia Carneiro da Cunha Filho on 25/09/17.
//  Copyright © 2017 Zap. All rights reserved.
//

import UIKit
import FirebaseDatabase

class InputCodeViewController: UIViewController, UITextFieldDelegate {
    
    let defaults = UserDefaults.standard
    var dbref: DatabaseReference!

    var cliente_id: DatabaseReference!
    var produto_id: DatabaseReference!
    var conversa_id: DatabaseReference!
    var username = ""
    
    @IBOutlet weak var inputNameLabel: UILabel!
    @IBOutlet weak var inputName: UITextField!
    @IBOutlet weak var inputCode: UITextField!
    @IBAction func buttonEnter(_ sender: Any?) {
        //DECLARACAO DE ALERTS
        let alertName = UIAlertController(title: "Nome Inválido", message: "Digite o seu nome e tente novamente.", preferredStyle: UIAlertControllerStyle.alert)
        alertName.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        
        let alertCode = UIAlertController(title: "Código Inválido", message: "Código Inválido! Por favor tente novamente.", preferredStyle: UIAlertControllerStyle.alert)
        alertCode.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        
        let alertCodeNone = UIAlertController(title: "Código Não Existente", message: "Código Não Existente! Por favor revise o código e tente novamente.", preferredStyle: UIAlertControllerStyle.alert)
        alertCodeNone.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        
        //VALIDACOES
        var dadosValidos = true
        if dadosValidos {
            if let name = self.inputName.text {
                if self.inputName.isHidden == false && name == "" {
                    self.present(alertName, animated: true, completion: nil)
                    dadosValidos = false
                }
            }
        }
        
        if dadosValidos {
            if let code = self.inputCode.text {
                if code.count < 4 {
                    self.present(alertCode, animated: true, completion: nil)
                    dadosValidos = false
                }
            }
        }

        
        //PROCESSAMENTO DOS DADOS
        if dadosValidos {
            self.dbref.child("produtos").observeSingleEvent(of: .value, with: { (snapshot) in
                // OBTENCAO DO PRODUTO
                if (snapshot.hasChild(self.inputCode.text!)) {
                    print("PRODUTO EXISTE")
                    self.produto_id = snapshot.ref.child(self.inputCode.text!)
                    if self.cliente_id == nil {
                        self.cliente_id = self.dbref.child("clientes").childByAutoId()
                        self.cliente_id.setValue(["nome": self.inputName.text])
                        print("NOVO CLIENTE ADICIONADO")
                        self.defaults.set(self.cliente_id.key, forKey: "Cliente")
                        print("NOVO CLIENTE GRAVADO")
                    }
                    if dadosValidos {
                        let conversasCliente = self.dbref.child("conversas").queryOrdered(byChild: "cliente_id").queryEqual(toValue: self.cliente_id.key)
                        
                        conversasCliente.observeSingleEvent(of: .value, with: { (snapshot) in
                            // OBTENCAO DA CONVERSA
                            var existeConversa = false
                            for snap in snapshot.children {
                                let value = (snap as! DataSnapshot).value as? NSDictionary
                                let produto_id = value?["produto_id"] as? String ?? ""
                                print("Produto_ID: \(produto_id)")
                                if produto_id == self.produto_id.key {
                                    print("EXISTE UMA CONVERSA")
                                    existeConversa = true
                                    self.conversa_id = (snap as! DataSnapshot).ref
                                    print("Conversa_ID: \(self.conversa_id.key)")
                                }
                            }
                            
                            if !existeConversa {
                                print("NÃO EXISTE UMA CONVERSA")
                                self.conversa_id = self.dbref.child("conversas").childByAutoId()
                                self.conversa_id.setValue(["cliente_id": self.cliente_id.key, "produto_id": self.produto_id.key, "vendedoratual_id": "", "mensagens":""])
                                print("NOVA CONVERSA ADICIONADA")
                            }
                            
                            self.performSegue(withIdentifier: "moveToChat", sender: self)
                            
                        }) { (error) in
                            print(error.localizedDescription)
                            dadosValidos = false
                        }
                        
                        
                        self.cliente_id.observeSingleEvent(of: .value, with: { (snapshot) in
                            // DEBUG DE OBTENCAO DO CLIENTE
                            let value = snapshot.value as? NSDictionary
                            self.username = value?["nome"] as? String ?? ""
                            print("USUÁRIO: \(self.username)")
                        }) { (error) in
                            print(error.localizedDescription)
                            dadosValidos = false
                        }
                    }
                } else {
                    print("PRODUTO NÃO EXISTE")
                    dadosValidos = false
                    self.present(alertCodeNone, animated: true, completion: nil)
                }
            }) { (error) in
                print(error.localizedDescription)
                dadosValidos = false
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "moveToChat") {
            let vc = segue.destination as! ChatViewController
            vc.conversa_id = self.conversa_id
            vc.senderId = self.cliente_id.key
            vc.senderDisplayName = self.username
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.inputName.delegate = self
        self.inputName.tag = 0
        self.inputCode.delegate = self
        self.inputCode.tag = 1
        
        self.dbref = Database.database().reference()
        
        

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let savedCliente = self.defaults.object(forKey: "Cliente") as? String
        if self.cliente_id == nil && savedCliente != nil {
            self.cliente_id = self.dbref.child(savedCliente!)
            print("CLIENTE CARREGADO")
        }
        
        if self.cliente_id != nil {
            self.inputName.isHidden = true
            self.inputNameLabel.isHidden = true
        }
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
