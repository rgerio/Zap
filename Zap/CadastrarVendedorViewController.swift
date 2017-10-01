//
//  CadastrarVendedorViewController.swift
//  Zap
//
//  Created by Matheus Herminio de Carvalho on 30/09/17.
//  Copyright © 2017 Zap. All rights reserved.
//

import UIKit
import FirebaseDatabase

class CadastrarVendedorViewController: UIViewController {
    var dbref: DatabaseReference!
    let defaults = UserDefaults.standard
    
    var loja_id: DatabaseReference!
    var vendedor_id: DatabaseReference!
    
    @IBOutlet weak var nomeLojaTextField: UITextField!
    @IBOutlet weak var nomeVendedorTextField: UITextField!
    @IBOutlet weak var chaveLojaTextField: UITextField!


     override func viewDidLoad() {
        super.viewDidLoad()
        dbref = Database.database().reference()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
    @IBAction func cadastrarButton(_ sender: UIButton) {
        //DECLARACAO DE ALERTS
        let alertNomeLoja = UIAlertController(title: "Loja Inválida", message: "Por favor, digite o nome da loja.", preferredStyle: UIAlertControllerStyle.alert)
        alertNomeLoja.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        
        let alertNomeVendedor = UIAlertController(title: "Vendedor Inválido", message: "Por favor, digite o nome do vendedor.", preferredStyle: UIAlertControllerStyle.alert)
        alertNomeVendedor.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        
        //VALIDACOES
        var dadosValidos = true
        if dadosValidos {
            if let nomeLoja = self.nomeLojaTextField.text {
                if nomeLoja == "" {
                    self.present(alertNomeLoja, animated: true, completion: nil)
                    dadosValidos = false
                }
            } else {
                dadosValidos = false
            }
        }
        
        if dadosValidos {
            if let nomeVendedor = self.nomeVendedorTextField.text {
                if nomeVendedor == "" {
                    self.present(alertNomeVendedor, animated: true, completion: nil)
                    dadosValidos = false
                }
            } else {
                dadosValidos = false
            }
        }
        
        //PROCESSAMENTO DOS DADOS
        if dadosValidos {
            self.dbref.child("lojas").queryOrdered(byChild: "nome").queryEqual(toValue: self.nomeLojaTextField.text!).observeSingleEvent(of: .value, with: { (snapshot) in
                var existeLoja = false
                for snap in snapshot.children {
                    let value = (snap as! DataSnapshot).value as? NSDictionary
                    let nomeLoja = value?["nome"] as? String ?? ""
                    print("Nome da loja: \(nomeLoja)")
                    if nomeLoja == self.nomeLojaTextField.text! {
                        print("A LOJA EXISTE")
                        existeLoja = true
                        self.loja_id = (snap as! DataSnapshot).ref
                        print("Loja_ID: \(self.loja_id.key)")
                    }
                }
                
                if !existeLoja {
                    print("A LOJA NÃO EXISTE")
                    self.loja_id = self.dbref.child("lojas").childByAutoId()
                    self.loja_id.setValue(["nome": self.nomeLojaTextField.text!])
                    print("NOVA LOJA ADICIONADA")
                }
                
                if self.vendedor_id == nil {
                    self.vendedor_id = self.dbref.child("vendedores").childByAutoId()
                    self.vendedor_id.setValue(["nome": self.nomeVendedorTextField.text!, "loja_id": self.loja_id.key, "disponivel": true])
                    print("NOVO VENDEDOR ADICIONADO")
                    self.defaults.set(self.vendedor_id.key, forKey: "Vendedor")
                    print("NOVO VENDEDOR GRAVADO")
                } else {
                    print("VENDEDOR EXISTE")
                }
                
                self.defaults.set("segueSelExiste", forKey: "TipoAcesso")
                self.performSegue(withIdentifier: "moveToChatVendedor", sender: self)
                
            }) { (error) in
                    print(error.localizedDescription)
                    dadosValidos = false
            }
        }
    }
    
    
}
