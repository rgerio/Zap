//
//  ViewController.swift
//  Zap
//
//  Created by Rogério Bezerra Santos on 20/09/17.
//  Copyright © 2017 Zap. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var consButton: UIButton!
    @IBOutlet var selButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func consPress(_ sender: Any) {
        self.performSegue(withIdentifier: "segueCons", sender: self)
    }
    
    @IBAction func selPress(_ sender: Any) {
        self.performSegue(withIdentifier: "segueSeller", sender: self)
    }
    
}

