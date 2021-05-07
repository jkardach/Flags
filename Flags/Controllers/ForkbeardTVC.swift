//
//  ForkbeardTVC.swift
//  Flags
//
//  Created by jim kardach on 5/7/21.
//

import UIKit

class ForkbeardTVC: UITableViewController {
    let rows = ["Flags is an iOS app developed by Forkbeard Labs",
                "License: Uses state data and images under MIT license",
                "  See: https:/github.com/CivilServiceUSA/us-states",
                "Uses Decoding JSON from your bundle extension: Hacking With Swift",
                "Uses How to load a remote image URL into UIImageView: Hacking With Swift",
                "Uses Resize UIImage Without Stretching in Swift extension: Robert Pieta",
                "Developed as a homework assignment for DeAnza Community College Swift Class",
                "Feel free to use/ learn from this code!",
                "https://github.com/jkardach/Flags",
                "Author: Jim Kardach, Founder of Forkbeard Labs"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return rows.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell1", for: indexPath)
        cell.textLabel?.font = UIFont(name:"ArialRoundedMTBold", size: 20.0)
        cell.textLabel?.text = rows[indexPath.row]
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping

        if indexPath.row == rows.count - 1 {
            cell.imageView?.image = UIImage(named: "Forkbeard")
        } else {
            cell.imageView?.image = nil
        }

        return cell
    }




}
