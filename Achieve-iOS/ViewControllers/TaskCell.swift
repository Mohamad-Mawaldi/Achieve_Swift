//
//  TaskCell.swift
//  Achieve-iOS
//
//  Created by Mohamad on 2020-10-20.
//

import UIKit

class TaskCell: UITableViewCell {

    @IBOutlet weak var taskHeader: UILabel!
    //@IBOutlet var checkmarkImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
