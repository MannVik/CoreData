//
//  ViewController.swift
//  Coredata
//
//  Created by manish on 22/01/18.
//  Copyright © 2018 manish. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var books = ["Book 1","Book 2","Book 3","Book 4"]
    @IBOutlet weak var nameTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        title = "Book"
        nameTableView.separatorStyle = .none
        nameTableView.reloadData()
    }
}

extension ViewController: UITableViewDelegate{
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "DataController") as! DataController
        navigationController?.pushViewController(controller, animated: true)
 
    }
}
extension ViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.selectionStyle = .none
        cell.textLabel?.text = books[indexPath.row]
        return cell
    }
}

