//
//  StateTVCell.swift
//  Flags
//
//  Created by jim kardach on 5/6/21.
//

import UIKit

class StateTVCell: UITableViewCell {
    @IBOutlet var flag: UIImageView!
    @IBOutlet var state: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
