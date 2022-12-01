//
//  LibraryTableViewCell.swift
//  Arena
//
//  Created by Aram Baali on 11/26/22.
//

import Foundation
import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class LibraryTableViewCell: UITableViewCell {
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var numberOfTickets: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var viewsCount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
