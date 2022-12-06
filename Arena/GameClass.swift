//
//  GameClass.swift
//  Arena
//
//  Created by Aram Baali on 11/27/22.
//

import Foundation
import UIKit

class Game {
    var logo: UIImage
    var team: String
    var date: String
    var dayTime: String
    
    init(game: String, date: String, dayTime: String) {
        if let logoImage = UIImage(named: "\(game).png") {
                // Use the logo image if it is present in the project
                self.logo = logoImage
        } else {
            // Use a default logo image if the team logo image is not present in the project
            self.logo = UIImage(named: "default")!
        }
        self.team = teams[game]!
        self.date = date
        self.dayTime = dayTime
    }
    
    func toDictionary() -> [String: Any] {
        // Retrieve the key associated with the given value from the `teams` dictionary
        let keys = teams.keys.filter({ teams[$0] == self.team })
        let logoName: String

        if let key = keys.first {
            // The key associated with the given value is `key`
            logoName = key
        } else {
            // No key-value pair in the dictionary has the given value, defult case
            logoName = "ulm"
        }

        return [
            "logo": logoName,
            "team": logoName,
            "date": self.date,
            "dayTime": self.dayTime
        ]
    }

    
    static func fromDictionary(_ dictionary: [String: Any]) -> Game {
        // Retrieve the logo name from the dictionary
        let logoName = dictionary["logo"] as? String
        
        // Convert the logo name to an UIImage object
        let logo = UIImage(named: "ulm.png")!

        // Retrieve the other values from the dictionary
        let team = dictionary["team"] as? String
        let date = dictionary["date"] as? String
        let dayTime = dictionary["dayTime"] as? String
        
        return Game(game: team ?? "", date: date ?? "", dayTime: dayTime ?? "")
    }

}

let teams = ["ulm":           "ULM",
             "alabama":       "Alabama",
             "utsa":          "UTSA",
             "texastech":     "Texas Tech",
             "westvirginia":  "West Virginia",
             "oklahoma":      "Oklahoma",
             "iowastate":     "Iowa State",
             "oklahomastate": "Oklahoma State",
             "kansasstate":   "Kansas State",
             "tcu":           "TCU",
             "kansas":        "Kansas",
             "baylor":        "Baylor"]

let gamesMasterlist: [Game] = [Game(game: "ulm",           date: "Sep 3",  dayTime: "SAT 7:00PM"),
                               Game(game: "alabama",       date: "Sep 10", dayTime: "SAT 11:00AM"),
                               Game(game: "utsa",          date: "Sep 17", dayTime: "SAT 7:00PM"),
                               Game(game: "texastech",     date: "Sep 24", dayTime: "SAT 2:30PM"),
                               Game(game: "westvirginia",  date: "Oct 1",  dayTime: "SAT 6:30PM"),
                               Game(game: "oklahoma",      date: "Oct 8",  dayTime: "SAT 11:00AM"),
                               Game(game: "iowastate",     date: "Oct 15", dayTime: "SAT 11:00AM"),
                               Game(game: "oklahomastate", date: "Oct 22", dayTime: "SAT 2:30PM"),
                               Game(game: "kansasstate",   date: "Nov 5",  dayTime: "SAT 6:00PM"),
                               Game(game: "tcu",           date: "Nov 12", dayTime: "SAT 6:30PM"),
                               Game(game: "kansas",        date: "Nov 19", dayTime: "SAT 2:30PM"),
                               Game(game: "baylor",        date: "Nov 25", dayTime: "FRI 11:00AM")]
