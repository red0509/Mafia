//
//  CountTableCell.swift
//  Mafia
//
//  Created by Anton Pavlov on 31.08.16.
//  Copyright © 2016 Anton Pavlov. All rights reserved.
//

import UIKit

class CountTableCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var count: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
