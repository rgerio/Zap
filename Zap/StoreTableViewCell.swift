//
//  StoreTableViewCell.swift
//  Zap
//
//  Created by Bruno Roberto Gouveia Carneiro da Cunha Filho on 22/09/17.
//  Copyright © 2017 Zap. All rights reserved.
//

import UIKit

class StoreTableViewCell: UITableViewCell {

    @IBOutlet weak var storeNameLabel: UILabel!
    @IBOutlet weak var storeLastTimeLabel: UILabel!
    @IBOutlet weak var storeImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        storeImage.layer.cornerRadius = 32
        storeImage.layer.masksToBounds = true
        storeImage.layer.borderWidth = 1
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
