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

class CountriesTableViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
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
    
    @IBAction func logOut(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}

// MARK: - Table view data source

extension CountriesTableViewController: UITableViewDataSource {
    
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allCountries.count
    }
    
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        cell.textLabel?.text = allCountries[indexPath.row].name
        cell.imageView?.sd_setImage(with: URL(string: allCountries[indexPath.row].flag!), placeholderImage: UIImage(named: "appIcon.png"))
        return cell
    }
    
}

extension CountriesTableViewController: UITableViewDelegate {
    
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}


