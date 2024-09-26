//
//  ViewController.swift
//  ProtectedWebCirculationApp
//
//  Created by Eren Elçi on 27.09.2024.
//

import UIKit

class ViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    var internetArray = [String]()
    var selectedFirstWebSite: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        internetArray = ["github.com" ,"google.com" , "apple.com"]
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = UITableViewCell()
        var context = cell.defaultContentConfiguration()
        context.text = internetArray[indexPath.row]
        cell.contentConfiguration = context
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return internetArray.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedFirstWebSite = internetArray[indexPath.row]
        performSegue(withIdentifier: "toWebVC", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toWebVC" {
            if let destinationVC = segue.destination as? WebViewController {
                destinationVC.selectedFirstWeb = selectedFirstWebSite
            }
        }
    }


}

