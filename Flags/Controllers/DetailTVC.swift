//
//  DetailTVC.swift
//  Flags
//
//  Created by jim kardach on 5/6/21.
//

import UIKit

class DetailTVC: UITableViewController {
    var state: StateData?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        tableView.backgroundView = UIImageView(image: state?.landscape)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 9
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell!
        if indexPath.row == 7 || indexPath.row == 8 {
            cell = tableView.dequeueReusableCell(withIdentifier: "Cell2", for: indexPath)
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: "Cell1", for: indexPath)
        }
        
        cell.imageView?.image = nil
        cell.textLabel!.text = ""
        cell.textLabel?.font = UIFont(name:"ArialRoundedMTBold", size: 20.0)
        switch indexPath.row {
        case 0:
            cell.imageView?.image = state?.flag
            cell.textLabel!.text = "- The Flag of " + state!.state
        case 1:
            cell.imageView?.image = state?.seal
            cell.textLabel!.text = "- The Seal of " + state!.state
        case 2:
            cell.imageView?.image = state?.map
            cell.textLabel!.text = "- Location of " + state!.state
        case 3:
            cell.imageView?.image = state?.skyline
            cell.textLabel!.text = "Capital: " + state!.capital_city
        case 4:
            cell.textLabel!.text = "Largest City: " + state!.largest_city
        case 5:
            cell.textLabel!.text = "Population: " + String(state!.population) +
                " (ranked " + String(state!.population_rank)  + "/50)"
        case 6:
            cell.textLabel!.text = "Statehood: " +
                state!.admission_date + "  (State " + String(state!.admission_number) + ")"
        case 7:
            cell.textLabel!.text = state!.state + "'s Webpage Link "
        case 8:
            cell.textLabel!.text = state!.state + "'s Constitution Link "
        default:
            cell.textLabel!.text = ""
            print("Error, should never hit this", indexPath.row)
        }

        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
    // perform segue to webview if rows 8 or 9 pressed
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 8 || indexPath.row == 7 {
            performSegue(withIdentifier: "ShowWeb", sender: self)
        }

    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // MARK: - Navigation
        if segue.identifier == "ShowWeb" {
            let indexpath = tableView.indexPathForSelectedRow
            let wVC = segue.destination as! WebVC
            if indexpath!.row == 8 {
                wVC.urlString = state?.constitution_url
            } else if indexpath!.row == 7 {
                wVC.urlString = state?.website
            }
        }
    }
    
}
