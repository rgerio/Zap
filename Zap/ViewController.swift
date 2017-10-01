//
//  ViewController.swift
//  Zap
//
//  Created by Rogério Bezerra Santos on 20/09/17.
//  Copyright © 2017 Zap. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let defaults = UserDefaults.standard

    @IBOutlet var consButton: UIButton!

    @IBOutlet var selButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let savedTipoAcesso = self.defaults.object(forKey: "TipoAcesso") as? String
        print("QUAL SERÁ O TIPO DE PESSOA?")
        if savedTipoAcesso != nil {
            print("JÁ SEI O TIPO DE PESSOA")
            performSegue(withIdentifier: savedTipoAcesso!, sender: self)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func pressConsButton(_ sender: Any) {
        self.defaults.set("segueCons", forKey: "TipoAcesso")
        performSegue(withIdentifier: "segueCons", sender: self)
    }
    
    @IBAction func pressSelButton(_ sender: Any) {
        self.defaults.set("segueSel", forKey: "TipoAcesso")
        performSegue(withIdentifier: "segueSel", sender: self)
    }
    
}

