//
//  ItemViewController.swift
//  Arena
//
//  Created by Aram Baali on 11/10/22.
//

import Foundation
import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class ItemViewController: UIViewController {
    @IBOutlet weak var gameImage: UIImageView!
    @IBOutlet weak var gameDate: UILabel!
    @IBOutlet weak var gameDayTime: UILabel!
    @IBOutlet weak var gameDescription: UILabel!
    @IBOutlet weak var gamePrice: UILabel!
    @IBOutlet weak var sellerContact: UIButton!
    @IBOutlet weak var sellerName: UILabel!
    
    var delegate: TicketsViewController!
    var ticket: Ticket!
    
    override func viewWillAppear(_ animated: Bool) {
        view.backgroundColor = masterPride
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        gameImage.image = ticket.game.logo
        gameDate.text = ticket.game.date
        gameDayTime.text = ticket.game.dayTime
        gameDescription.text = "\(ticket.numberOfTickets) Ticket | Student Section"
        gamePrice.text = "$\(ticket.price) Each"
        sellerContact.setTitle(ticket.sellerContact, for: .normal)
        sellerName.text = ticket.seller
    }

    @IBAction func numberButtonPress(_ sender: Any) {
    }
}
