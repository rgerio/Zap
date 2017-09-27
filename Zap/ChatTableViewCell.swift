//
//  ChatTableViewCell.swift
//  Zap
//
//  Created by Rogério Bezerra Santos on 27/09/17.
//  Copyright © 2017 Zap. All rights reserved.
//

import UIKit

class ChatTableViewCell: UITableViewCell {

    @IBOutlet weak var message: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
