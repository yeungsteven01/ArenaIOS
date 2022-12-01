//
//  LibraryViewController.swift
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

class LibraryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var libraryTableView: UITableView!
    let libraryCell = "LibraryCell"
    let kUserFullNameID = "fullNameID"
    let kUserPhoneID = "phoneID"
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        libraryTableView.delegate = self
        libraryTableView.dataSource = self
        libraryTableView.rowHeight = 75
    }
    
    @IBAction func listTicketPressed(_ sender: Any) {
        if (defaults.string(forKey: kUserFullNameID) == "" || defaults.string(forKey: kUserPhoneID) == "") {
            let controllerProfile = UIAlertController(
                title: "Incomplete Profile",
                message: "Please complete profile before listing a ticket.",
                preferredStyle: .alert)
            controllerProfile.addAction(UIAlertAction(
                title: "OK",
                style: .default))
            present(controllerProfile, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ticketsMasterlist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let ticket = ticketsMasterlist[row]
        let cell = libraryTableView.dequeueReusableCell(withIdentifier: libraryCell, for: indexPath) as! LibraryTableViewCell
        
        cell.thumbnail.image = ticket.game.logo
        cell.numberOfTickets.text = String(ticket.numberOfTickets)
        cell.price.text = String(ticket.price)
        cell.viewsCount.text = String(ticket.viewsCount)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        libraryTableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let row = libraryTableView.indexPathForSelectedRow?.row else { return }
            ticketsMasterlist.remove(at: row)
            libraryTableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "createListing",
           let destVC = segue.destination as? ListingViewController {
            destVC.delegate = self
            destVC.tableView = libraryTableView
        }
    }
}
