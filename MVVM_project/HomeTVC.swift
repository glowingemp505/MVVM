//
//  HomeTVC.swift
//  MVVM_Test
//
//  Created by sameer amjad on 26/04/2022.
//

import UIKit

class HomeTVC: UITableViewCell {

    
        @IBOutlet weak var name: UILabel!
        @IBOutlet weak var source: UILabel!
        @IBOutlet weak var updated: UILabel!
        @IBOutlet weak var id: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
