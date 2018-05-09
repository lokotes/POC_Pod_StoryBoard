//
//  TaskTableViewCell.swift
//  AppTasksDay
//
//  Created by MacAMP on 8/05/18.
//  Copyright © 2018 MacAMP. All rights reserved.
//

import UIKit

class TaskTableViewCell: UITableViewCell {

    @IBOutlet weak var titleTask: UILabel!
    @IBOutlet weak var estadoTask: UILabel!
    @IBOutlet weak var viewbgTask: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
