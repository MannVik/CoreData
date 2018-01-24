//
//  DataController.swift
//  Coredata
//
//  Created by manish on 22/01/18.
//  Copyright © 2018 manish. All rights reserved.
//

import UIKit

class DataController: UIViewController {

    @IBOutlet weak var bookTableView: UITableView!
    let appDel = UIApplication.shared.delegate as! AppDelegate
    var books: [Book] = []
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        getData()
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleAddAction))
        
        navigationItem.rightBarButtonItem = addButton
    }
    
    func handleAddAction(){
        print("add")
        showAlert()
    }
    
    
    
    func showAlert()  {
        let alert = UIAlertController(title: "Enter", message: "Chapter Name & Note", preferredStyle: .alert)
        
        //2. Add the text field. You can configure it however you need.
        alert.addTextField { (textField) in
            textField.placeholder = "Chapter Name"
        }
        
        alert.addTextField { (textField) in
            textField.placeholder = "Note"
        }
        
        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            guard let nameTextField = alert?.textFields![0],
                let noteTextField = alert?.textFields?[1] else { return }// Force unwrapping because we know it exists.
            print("Name Text field: \(nameTextField.text)")
            print("Note Text field: \(noteTextField.text)")
            self.add(bookName: nameTextField.text!, note: noteTextField.text!)
        }))
        
        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
B
    }
    
    func add(bookName: String, note: String) {
        
        let book = Book(context: context)
        book.name = bookName
        book.notes = note
        appDel.saveContext()
        print("Saved")
        getData()
        
    }
    
    func getData() {
        
        do {
            books = try context.fetch(Book.fetchRequest())
        } catch {
            print("Fetching Failed")
        }
        bookTableView.reloadData()
        
    }
    
    func actionDelete(sender:UIButton) {
        guard let cell = sender.superview?.superview as? DetailCellTableViewCell else {
            return
        }
        let index = bookTableView.indexPath(for: cell)
        let book = books[(index?.row)!]
        context.delete(book)
        appDel.saveContext()
        getData()
    }
    
    func actionEdit(sender:UIButton) {
        guard let cell = sender.superview?.superview as? DetailCellTableViewCell else {
            return
        }
        let index = bookTableView.indexPath(for: cell)
        let book = books[(index?.row)!]
        //print(index?.row)
        let alert = UIAlertController(title: "UPDATE", message: "Chapter Name & Note", preferredStyle: .alert)
        
        //2. Add the text field. You can configure it however you need.
        alert.addTextField { (textField) in
            textField.text = book.name
        }
        
        alert.addTextField { (textField) in
            textField.text = book.notes
        }
        
        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "UPDATE", style: .default, handler: { [weak alert] (_) in
            guard let nameTextField = alert?.textFields![0],
                let noteTextField = alert?.textFields?[1] else { return }// Force unwrapping because we know it exists.
//            let data = Book(context: self.context)
            book.name = nameTextField.text
            book.notes = noteTextField.text
            self.appDel.saveContext()
            self.getData()
        }))
        
        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
    }
}

extension DataController: UITableViewDelegate{
    
}
extension DataController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCellTableViewCell", for: indexPath) as!  DetailCellTableViewCell
        cell.selectionStyle = .none
        cell.lblName?.text = books[indexPath.row].name
        cell.btnEdit.addTarget(self, action: #selector(actionEdit), for: .touchUpInside)
        cell.btnDelete.addTarget(self, action: #selector(actionDelete), for: .touchUpInside)

        return cell
    }
}

