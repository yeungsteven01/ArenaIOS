//
//  PutTicket.swift
//  Arena
//
//  Created by Harper Deloach on 12/4/22.
//

import Foundation
import FirebaseDatabase

func putTicket(ticket: Ticket) {
    
    // Get a reference to the "tickets" node in the Realtime Database
    let ticketsRef = Database.database().reference().child("tickets")

    // Write the new ticket to the "tickets" node
    ticketsRef.childByAutoId().setValue(ticket)
    
}
