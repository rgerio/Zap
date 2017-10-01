//
//  ShowCodeViewController.swift
//  Zap
//
//  Created by Matheus Herminio de Carvalho on 01/10/17.
//  Copyright © 2017 Zap. All rights reserved.
//

import UIKit

class ShowCodeViewController: UIViewController {
    var codigo =  ""
    @IBOutlet weak var codigoLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        codigoLabel.text = codigo
     
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
