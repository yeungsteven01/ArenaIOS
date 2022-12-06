//
//  GameViewController.swift
//  Arena
//
//  Created by Aram Baali on 11/10/22.
//

import Foundation
import UIKit
import UserNotifications
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class TicketsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var ticketsTableView: UITableView!
    let ticketCell = "TicketCell"
    
    var delegate: GamesViewController!
    var game: Game!
    var gameTicketList: [Ticket] = []
    
    override func viewWillAppear(_ animated: Bool) {
        ticketsTableView.backgroundColor = masterPride
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        ticketsTableView.delegate = self
        ticketsTableView.dataSource = self
        ticketsTableView.rowHeight = 75
        //update ticket list
        getTickets(completion: { tickets in
            // Update the ticketsMasterlist variable with the tickets array
            ticketsMasterlist = tickets
        })

        // Find the tickets for the specific college game
        for tickets in ticketsMasterlist {
            if tickets.game.team == game.team {
                gameTicketList.append(tickets)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gameTicketList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Populate the table with the newly created ticket array with the right game
        let row = indexPath.row
        let ticket = gameTicketList[row]
        let cell = ticketsTableView.dequeueReusableCell(withIdentifier: ticketCell, for: indexPath) as! TicketTableViewCell
        cell.numberOfTickets.text = "\(ticket.numberOfTickets) Tickets"
        cell.seller.text = ticket.seller
        cell.price.text = "$" + String(ticket.price)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        ticketsTableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .clear
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetails", let destVC = segue.destination as? ItemViewController {
            let row = ticketsTableView.indexPathForSelectedRow?.row
            destVC.delegate = self
            destVC.ticket = ticketsMasterlist[row!]
            // Once a ticket has been looked at, send a notification in 5 seconds
            // create content
            let content = UNMutableNotificationContent()
            content.title = "Someone has clicked on your ticket!"
            content.subtitle = "The \(ticketsMasterlist[row!].numberOfTickets) tickets you listed for \(ticketsMasterlist[row!].game.team) is being looked at!"
            content.sound = UNNotificationSound.default
            // create trigger
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            // combine it all into a request
            let request = UNNotificationRequest(identifier: "myNotification", content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request)
        }
    }
}
