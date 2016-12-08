//
//  ElementsTableTableViewController.swift
//  AC3.2-MidtermElements
//
//  Created by Maria on 12/8/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class ElementsTableTableViewController: UITableViewController {
    
    var elements: [Element] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
//    self.refreshControl?.addTarget(self, action: #selector(handleRefresh(refreshControl:)), for: UIControlEvents.valueChanged)
        
        loadData()
}

    func loadData() {
    APIRequestManager.manager.getData(endPoint: "https://api.fieldbook.com/v1/58488d40b3e2ba03002df662/elements") { (data: Data?) in
    if let validData = data,
    let validElements = Element.getElements(from: validData) {
    self.elements = validElements
    
    DispatchQueue.main.async {
    self.tableView.reloadData()
       
        }
    }
  }
}


func handleRefresh(refreshControl: UIRefreshControl) {
    
    loadData()
    
    refreshControl.endRefreshing()
}


    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return elements.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "elementsCell", for: indexPath)
        let element = elements[indexPath.row]
        
        cell.textLabel?.text = element.name
        cell.detailTextLabel?.text = "\(element.symbol) (\(element.number)) \(element.weight)"
        
        return cell
    }

override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "ElementDetailSegue" {
    if let destinationViewController = segue.destination as? ElementDetailViewController,
        let cell = sender as? UITableViewCell,
        let indexPath = tableView.indexPath(for: cell) {
    destinationViewController.element = elements[indexPath.row]
        
     }
   }
 }
}
