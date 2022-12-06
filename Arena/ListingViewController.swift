//
//  ListingsViewController.swift
//  Arena
//
//  Created by Aram Baali on 11/10/22.
//

import Foundation
import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import Firebase

class ListingViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var gamesPickerView: UIPickerView!
    @IBOutlet weak var priceField: UITextField!
    @IBOutlet weak var amountField: UITextField!
    @IBOutlet weak var listButton: UIButton!
    let kUserFullNameID = "fullNameID"
    let kUserPhoneID = "phoneID"
    let defaults = UserDefaults.standard
    
    var delegate: LibraryViewController!
    var tableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        view.backgroundColor = masterPride
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        gamesPickerView.delegate = self
        gamesPickerView.dataSource = self
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return gamesMasterlist.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return gamesMasterlist[row].team
    }
    
    @IBAction func listButtonPress(_ sender: Any) {
        if amountField.text == "" && priceField.text == "" {
            let controller = UIAlertController(
                title: "No Input",
                message: "Please complete fields for the amount of tickets and price.",
                preferredStyle: .alert)
            controller.addAction(UIAlertAction(
                title: "OK",
                style: .default))
            present(controller, animated: true)
        } else {
            let controllerPrice = UIAlertController(
                title: "Invalid Input",
                message: "Please enter a valid price.",
                preferredStyle: .alert)
            controllerPrice.addAction(UIAlertAction(
                title: "OK",
                style: .default))
            let controllerAmount = UIAlertController(
                title: "Invalid Input",
                message: "Please enter a valid amount.",
                preferredStyle: .alert)
            controllerAmount.addAction(UIAlertAction(
                title: "OK",
                style: .default))
            let pickerRow = gamesPickerView.selectedRow(inComponent: 0)
            let match = gamesMasterlist[pickerRow]
            guard let amount = Int(amountField.text!) else {
                present(controllerAmount, animated: true)
                return
                
            }
            guard let asking = Int(priceField.text!) else {
                present(controllerPrice, animated: true)
                return
            }
            let name = defaults.string(forKey: kUserFullNameID)
            let phoneNumber = defaults.string(forKey: kUserPhoneID)
            let ticket = Ticket(game: match, numberOfTickets: amount, price: asking, seller: name!, viewsCount: 0, sellerContact: phoneNumber!)
            putTicket(ticket: ticket)
            ticketsMasterlist.append(ticket)
            //getTickets(completion: { tickets in
                //Update the ticketsMasterlist variable with the tickets array
                //ticketsMasterlist = tickets
            //})
            
            tableView.reloadData()
            dismiss(animated: true)
        }
    }
}
