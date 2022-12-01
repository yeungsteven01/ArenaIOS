//
//  ExchangeViewController.swift
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
import Firebase

class GamesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var gamesTableView: UITableView!
    let gameCell = "GameCell"
    let queue = DispatchQueue(label: "myQueue", qos: .userInteractive)
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UNUserNotificationCenter.current().requestAuthorization(options:[.alert,.badge,.sound]) {
            granted, error in
            if granted {
                print("All set!")
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
        gamesTableView.delegate = self
        gamesTableView.dataSource = self
        gamesTableView.rowHeight = 100
        refresh()
    }
    
    // Refreshes the games table view every 5 seconds to stay updated
    func refresh() {
        queue.async {
            // While a sync while-loop to while the VC is up and the remaining time is above 0
            while true {
                // Wait a second
                sleep(10)
                // In the main thread, dynamically change the remaining time text label
                DispatchQueue.main.async {
                    self.gamesTableView.reloadData()
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gamesMasterlist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let game = gamesMasterlist[row]
        let cell = gamesTableView.dequeueReusableCell(withIdentifier: gameCell, for: indexPath) as! GameTableViewCell
        var gameTicketList: [Ticket] = []
        var totalTickets: Int = 0
        var lowestPrice = 0
        cell.thumbnail.image = game.logo
        cell.date.text = game.date
        cell.dayTime.text = game.dayTime
        for tickets in ticketsMasterlist {
            if tickets.game.team == game.team {
                gameTicketList.append(tickets)
                totalTickets += tickets.numberOfTickets
            }
        }
        cell.availableTickets.text = String(totalTickets)
        if gameTicketList.count == 0 {
            lowestPrice = 0
        } else {
            lowestPrice = gameTicketList[0].price
            for specificGame in gameTicketList {
                if specificGame.price < lowestPrice {
                    lowestPrice = specificGame.price
                }
            }
        }
        cell.lowestPrice.text = "$\(lowestPrice)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        gamesTableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showTickets", let destVC = segue.destination as? TicketsViewController {
            let row = gamesTableView.indexPathForSelectedRow?.row
            destVC.delegate = self
            destVC.game = gamesMasterlist[row!]
        }
    }
}

