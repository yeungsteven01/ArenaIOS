//
//  GameTableViewCell.swift
//  Arena
//
//  Created by Aram Baali on 11/26/22.
//

import Foundation
import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class GameTableViewCell: UITableViewCell {
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var dayTime: UILabel!
    @IBOutlet weak var availableTickets: UILabel!
    @IBOutlet weak var lowestPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
