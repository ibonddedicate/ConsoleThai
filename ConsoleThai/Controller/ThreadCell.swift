//
//  ThreadCell.swift
//  ConsoleThai
//
//  Created by Surote Gaide on 5/6/20.
//  Copyright © 2020 Surote Gaide. All rights reserved.
//

import UIKit

class ThreadCell: UITableViewCell {
    @IBOutlet weak var threadName: UILabel!
    @IBOutlet weak var threadUsername: UILabel!
    @IBOutlet weak var prefix: UIImageView!
    @IBOutlet weak var viewNumber: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
