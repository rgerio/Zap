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
    
    @IBOutlet weak var nomeLojaTextField: UITextField!
    
    @IBOutlet weak var nomeVendedorTextField: UITextField!
    
    
    @IBOutlet weak var chaveLojaTextField: UITextField!

    
    
  //NSUserDefaults.
   // defaults.s
    override func viewDidLoad() {
        super.viewDidLoad()
        dbref = Database.database().reference()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func cadastrarButton(_ sender: UIButton) {
        //alertas
        let alertEmpty = UIAlertController(title: "Campos não preenchidos", message: "Preencha os campos! Por favor.", preferredStyle: UIAlertControllerStyle.alert)
        
        alertEmpty.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil)) //gerenciando as notificaçoes
       
       let alertKeyInvalidate = UIAlertController(title: "Chave da loja inválida ", message: "Não consta no sistema! Por favor digite uma chave válida!.", preferredStyle: UIAlertControllerStyle.alert)
        
        alertKeyInvalidate.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        
        let alertNameInvalidate = UIAlertController(title: "Nome loja inválido!", message: "Preencha o nome correto da loja!", preferredStyle: UIAlertControllerStyle.alert)
        
        alertNameInvalidate.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        

        //verificando campos vazios
        if  let nomeLoja = nomeLojaTextField.text, let nomeVendedor = nomeVendedorTextField.text ,let chaveLoja = chaveLojaTextField.text ,!nomeLoja.isEmpty && !nomeVendedor.isEmpty && !chaveLoja.isEmpty
         {
         //referencias
         let lojasRef = self.dbref.child("lojas")
         let vendedoresRef = self.dbref.child("vendedores")
         //abrindo observe para verificar lojas
         lojasRef.observeSingleEvent(of: .value, with:{
            (snapshot) in
            if(snapshot.hasChild(chaveLoja)){
                lojasRef.child(chaveLoja).observeSingleEvent(of: .value,with:
                    { (snapshot) in
                    
                        let value = snapshot.value as? NSDictionary
                        let nomeLojaFirebase = value?["nome"] as? String ?? ""
                        if (nomeLojaFirebase == nomeLoja){
                            let chave = vendedoresRef.childByAutoId()
                            chave.setValue(["nome": nomeVendedor,"loja_id":chaveLoja,"disponivel":"sim"])
                            
                            self.defaults.set(chave.key, forKey: "VendedorKey")
                            self.defaults.set(chaveLoja, forKey: "LojaKey")
                            
                            self.performSegue(withIdentifier: "moveToChatVendedor", sender: self)
                            
                        }else{
                            
                            self.present(alertNameInvalidate, animated: true, completion: nil)
                        }
                   })
                
            }else{
                self.present(alertNameInvalidate, animated: true, completion: nil)
            }
          
        
         })
                
            

        }else{
           self.present(alertEmpty, animated: true, completion: nil)
        }
    }
}
