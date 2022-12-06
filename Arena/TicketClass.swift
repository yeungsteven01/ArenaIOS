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
    
    func toDictionary() -> [String: Any] {
            // Convert the game object to a dictionary
            let gameDictionary = self.game.toDictionary()

            return [
                "game": gameDictionary,
                "numberOfTickets": self.numberOfTickets,
                "price": self.price,
                "seller": self.seller,
                "viewsCount": self.viewsCount,
                "sellerContact": self.sellerContact
            ]
        }
    
    static func fromDictionary(_ dictionary: [String: Any]) -> Ticket {
            // Retrieve the game data from the dictionary
            let gameData = dictionary["game"] as! [String: Any]

            // Convert the game data to a Game object
            let game = Game.fromDictionary(gameData)

            // Retrieve the other values from the dictionary
            let numberOfTickets = dictionary["numberOfTickets"] as! Int
            let price = dictionary["price"] as! Int
            let seller = dictionary["seller"] as! String
            let viewsCount = dictionary["viewsCount"] as! Int
            let sellerContact = dictionary["sellerContact"] as! String

            return Ticket(game: game, numberOfTickets: numberOfTickets, price: price, seller: seller, viewsCount: viewsCount, sellerContact: sellerContact)
        }
}

var ticketsMasterlist: [Ticket] = []
