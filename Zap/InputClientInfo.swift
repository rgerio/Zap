//
//  InputClientInfo.swift
//  Zap
//
//  Created by Bruno Roberto Gouveia Carneiro da Cunha Filho on 27/09/17.
//  Copyright © 2017 Zap. All rights reserved.
//

import UIKit
import Foundation
class InputClientInfo: UITextField, UITextFieldDelegate {

    
    let border = CALayer()
    let width = CGFloat(2.0)
    
    required init?(coder aDecoder: (NSCoder!)) {
        super.init(coder: aDecoder)
        self.delegate=self;
        border.borderColor = UIColor( red: 100/255, green: 100/255, blue:100/255, alpha: 1.0 ).cgColor
        
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
    
    override func draw(_ rect: CGRect) {
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.frame.size.width, height: self.frame.size.height)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.frame.size.width, height: self.frame.size.height)
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
//
//  InputClientInfo.swift
//  Zap
//
//  Created by Bruno Roberto Gouveia Carneiro da Cunha Filho on 27/09/17.
//  Copyright © 2017 Zap. All rights reserved.
//


