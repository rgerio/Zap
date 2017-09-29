//
//  GerarProdutoViewController.swift
//  Zap
//
//  Created by Matheus Herminio de Carvalho on 29/09/17.
//  Copyright © 2017 Zap. All rights reserved.
//

import UIKit

class GerarProdutoViewController: UIViewController, UITextFieldDelegate {
   
    
    
    @IBOutlet weak var nomeVendedorTextField: UITextField!
    @IBOutlet weak var nomeProdutoTextField: UITextField!
    @IBOutlet weak var descricaoTextField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      //  nomeLojaTextField.delegate = self
        nomeVendedorTextField.delegate = self
        nomeProdutoTextField.delegate = self
        //descricaoTextField.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func textFieldShouldReturn(_ textField : UITextField) -> Bool {
        textField.resignFirstResponder()
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
