//
//  HostTableViewCell.swift
//  DataSafer
//
//  Created by Fellipe Thufik Costa Gomes Hoashi on 10/1/16.
//  Copyright © 2016 Fellipe Thufik Costa Gomes Hoashi. All rights reserved.
//

import UIKit

class HostTableViewCell: UITableViewCell {

    
    @IBOutlet weak var hostName: UILabel!
    @IBOutlet weak var hostIP: UILabel!
    @IBOutlet weak var backupStatus: UILabel!    
    @IBOutlet weak var computerImage: UIImageView!
   
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
