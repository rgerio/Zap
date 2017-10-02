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
    
    var dbref: DatabaseReference!
    let defaults = UserDefaults.standard
   
    @IBOutlet weak var nomeProduoTextField: UITextField!
    @IBOutlet weak var descricaoTextView: UITextView!
    @IBOutlet weak var imagemProdutoUIImageView: UIImageView!
    
    var codigo = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nomeProduoTextField.delegate = self
        self.nomeProduoTextField.tag = 0
        self.descricaoTextView.delegate = self
        self.descricaoTextView.tag = 1
        drawDescricaoTextView()
        self.dbref = Database.database().reference()
   
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

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Try to find next responder
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            // Not found, so remove keyboard.
            textField.resignFirstResponder()
            self.gerarCodigo(nil)
        }
        // Do not add a line break
        return false
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
        textView.resignFirstResponder()
        return false
    }
        return true
    }

    @IBAction func gerarCodigo(_ sender: Any?) {
        let alertEmpty = UIAlertController(title: "Nome Inválido", message: "Por favor, verifique o nome do produto e tente novamente.", preferredStyle: UIAlertControllerStyle.alert)
        alertEmpty.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
       
        if  let nomeProduto = nomeProduoTextField.text,
            let descricao = descricaoTextView.text, !nomeProduto.isEmpty
        {
             let vendedores = self.dbref.child("vendedores")
             let produtos = self.dbref.child("produtos")
            vendedores.observeSingleEvent(of: .value, with: { (snapshot) in
                let produto =  Produto(Nome: nomeProduto,LojaId: self.defaults.string(forKey: "LojaKey")!, Descricao: descricao)

                produto.codigo = produto.gerarCodigo()
                    print(produto.codigo)
                    if(!snapshot.hasChild(produto.codigo)){
                        
                       produtos.child(produto.codigo).setValue(["nome": produto.nome, "descricao":produto.descricao, "imagem":"nao", "loja_id":produto.lojaId])
                        
                         self.codigo = produto.codigo
                        
                         self.performSegue(withIdentifier: "generateCode", sender: self)
                }
           
            })

        }else{
            
            self.present(alertEmpty, animated: true, completion: nil)
            
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "generateCode") {
            let vc = segue.destination as! ShowCodeViewController
            vc.codigo = self.codigo
        }
    }
    
}
