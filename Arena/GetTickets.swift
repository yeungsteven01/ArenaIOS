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
    
    // Get a reference to the "tickets" node in the Realtime Database
    let ticketsRef = Database.database().reference().child("tickets")

    // Retrieve the data at the "tickets" node once
    ticketsRef.observeSingleEvent(of: .value, with: { (snapshot) in
        // Check if the snapshot is nil
        if snapshot.value == nil {
            // If the snapshot is nil, return an empty array of Ticket objects
            completion([])
        } else {
            // Check if the snapshot value is nil
            if snapshot.value == nil {
              // If the snapshot value is nil, return early from the function
              return
            }

            // Iterate over the tickets in the snapshot
            for child in snapshot.children {
                let ticketData = child as! DataSnapshot
                let ticket = ticketData.value as! Ticket
                ticketFound.append(ticket)
            }
        }
        // Return the array of Ticket objects using the completion parameter
        completion(ticketFound)
    })
}
