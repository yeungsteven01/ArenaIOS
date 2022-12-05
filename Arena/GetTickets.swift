//
//  GetTickets.swift
//  Arena
//
//  Created by Harper Deloach on 12/4/22.
//

import Foundation
import Firebase
import FirebaseDatabase

func getTickets() -> [Ticket] {
    
    var ticketFound: [Ticket] = []
    
    // Get a reference to the "tickets" node in the Realtime Database
    let ticketsRef = Database.database().reference().child("tickets")

    // Retrieve the data at the "tickets" node once
    ticketsRef.observeSingleEvent(of: .value, with: { (snapshot) in
        // Get the snapshot value as a dictionary
        let ticketsDict = snapshot.value as! [String: Any]

        // Iterate over the dictionary and print each ticket
        for (_, ticketData) in ticketsDict {
            ticketFound.append(ticketData as! Ticket)
        }
    })
    
    return ticketFound
}
