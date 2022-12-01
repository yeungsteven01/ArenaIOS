//
//  Ticket.swift
//  Arena
//
//  Created by Aram Baali on 11/27/22.
//

import Foundation
import UIKit

class Ticket {
    var game: Game
    var numberOfTickets: Int
    var price: Int
    var seller: String
    var viewsCount: Int
    var sellerContact: String
    
    init(game: Game, numberOfTickets: Int, price: Int, seller: String, viewsCount: Int, sellerContact: String) {
        self.game = game
        self.numberOfTickets = numberOfTickets
        self.price = price
        self.seller = seller
        self.viewsCount = viewsCount
        self.sellerContact = sellerContact
    }
}

var ticketsMasterlist: [Ticket] = []
