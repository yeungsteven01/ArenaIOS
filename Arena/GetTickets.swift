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
                let ticketData = child as! DataSnapshot
                let gameData = ticketData.childSnapshot(forPath: "game").value as! [String: Any]
                let gameNameData = (gameData["team"] as? String) ?? "ulm"
                let gameMasterListSelection: Game
                print(gameNameData)
                if gameNameData == "ulm" {
                    gameMasterListSelection = gamesMasterlist[0]
                } else if gameNameData == "alabama" {
                    gameMasterListSelection = gamesMasterlist[1]
                } else if gameNameData == "utsa" {
                    gameMasterListSelection = gamesMasterlist[2]
                } else if gameNameData == "texastech" {
                    gameMasterListSelection = gamesMasterlist[3]
                } else if gameNameData == "westvirginia" {
                    gameMasterListSelection = gamesMasterlist[4]
                } else if gameNameData == "oklahoma" {
                    gameMasterListSelection = gamesMasterlist[5]
                } else if gameNameData == "iowastate" {
                    gameMasterListSelection = gamesMasterlist[6]
                } else if gameNameData == "oklahomastate" {
                    gameMasterListSelection = gamesMasterlist[7]
                } else if gameNameData == "kansasstate" {
                    gameMasterListSelection = gamesMasterlist[8]
                } else if gameNameData == "tcu" {
                    gameMasterListSelection = gamesMasterlist[9]
                } else if gameNameData == "kansas" {
                    gameMasterListSelection = gamesMasterlist[10]
                } else if gameNameData == "baylor" {
                    gameMasterListSelection = gamesMasterlist[11]
                } else {
                    gameMasterListSelection = gamesMasterlist[0]
                }
                let numberOfTickets = (ticketData.value(forKey: "numberOfTickets") as? Int) ?? 0
                let price = ticketData.value(forKey: "price") as! Int
                let seller = ticketData.value(forKey: "seller") as! String
                let viewsCount = ticketData.value(forKey: "viewsCount") as! Int
                let sellerContact = ticketData.value(forKey: "sellerContact") as! String
                let ticket = Ticket(game: gameMasterListSelection, numberOfTickets: numberOfTickets, price: price, seller: seller, viewsCount: viewsCount, sellerContact: sellerContact)
                ticketFound.append(ticket)
            }
            completion(ticketFound)
        }
    })
}

