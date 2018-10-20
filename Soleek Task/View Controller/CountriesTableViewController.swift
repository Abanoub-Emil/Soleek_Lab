//
//  CountriesTableViewController.swift
//  Soleek Task
//
//  Created by Champion on 10/19/18.
//  Copyright © 2018 ITI. All rights reserved.
//

import UIKit
import SwiftyJSON
import SDWebImage

class CountriesTableViewController: UITableViewController {
    var allCountries = [Country]()
    let countriesURL = "https://www.androidbegin.com/tutorial/jsonparsetutorial.txt"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        AFWrapper.requestGETURL(countriesURL, success: { (json) in
            let worldPopulation = JSON(json)["worldpopulation"]
           
            for country in worldPopulation.arrayValue {
                let myCountry = Country()
                myCountry.name = country["country"].stringValue
                myCountry.flag = country["flag"].stringValue
                self.allCountries.append(myCountry)
            }
            self.tableView.reloadData()
            }) { (Error) in
                print(Error.localizedDescription)
        }
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
// MARK: - Table view data source

extension CountriesTableViewController{
    
    
   
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return allCountries.count
    }
    
    
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
     cell.textLabel?.text = allCountries[indexPath.row].name
        cell.imageView?.sd_setImage(with: URL(string: allCountries[indexPath.row].flag!), placeholderImage: UIImage(named: "appIcon.png"))
     return cell
     }
    
    
    
}


extension CountriesTableViewController {
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}


