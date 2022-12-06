//
//  GetTickets.swift
//  Arena
//
//  Created by Harper Deloach on 12/4/22.
//

import Foundation
import Firebase
import FirebaseDatabase

func getTickets(completion: @escaping ([Ticket]) -> Void) {
    var ticketFound: [Ticket] = []

    let ticketsRef = Database.database().reference().child("tickets")

    ticketsRef.observeSingleEvent(of: .value, with: { (snapshot) in
        if snapshot.value == nil {
            completion([])
        } else {
            for child in snapshot.children {
                let snapshotValue = child as! DataSnapshot
                let ticketData = snapshotValue.value
                if let object = ticketData as? [String: Any] {
                  // Access the individual values in the object
                  let gameData = object["game"] as! [String: Any]
                  let date = gameData["date"] as! String
                  let dayTime = gameData["dayTime"] as! String
                  let logo = gameData["logo"] as! String
                  let team = gameData["team"] as! String
                  let numberOfTickets = object["numberOfTickets"] as! Int
                  let price = object["price"] as! Int
                  let seller = object["seller"] as! String
                  let sellerContact = object["sellerContact"] as! String
                  let viewsCount = object["viewsCount"] as! Int
                  
                    ticketFound.append(Ticket(game: Game(game: team, date: date, dayTime: dayTime), numberOfTickets: numberOfTickets, price: price, seller: seller, viewsCount: viewsCount, sellerContact: sellerContact))
                } else {
                  // Handle the case where the object is not a dictionary
                    print("Error with snapshot")
                }
            }
            completion(ticketFound)
        }
    })
}
