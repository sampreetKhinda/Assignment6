//
//  ViewController.swift
//  Assignment6
//
//  Created by Sampreet singh on 19/02/24.
//

import UIKit

class ViewController: UIViewController ,
                      UITableViewDataSource, UITableViewDelegate {
  
    @IBOutlet weak var toDoTable: UITableView!
    var citys = ["calgary","halifax","montreal","toronto","vancouver","winnipeg",
                 "calgary","halifax","Sampreet"]
   
    private let KeySelectedValues = "KeySelectedIndexes"
    private let FirstTimeValue = "FirstTime"
    var isFirstTime = true
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return citys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = toDoTable.dequeueReusableCell(withIdentifier: "ToDoCell", for: indexPath)
              cell.textLabel?.text = citys[indexPath.row]
        return cell
    }
    
    @IBAction func createNew(_ sender: Any) {
        var textField = UITextField()
            
        let alert = UIAlertController(title: "Add item", message: "", preferredStyle: .alert)
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        let addItem = UIAlertAction(title: "Ok", style: .default) { action in
            if !String(textField.text!).isEmpty {
                self.citys.append(String(textField.text!))
                UserDefaults.standard.set(self.citys, forKey: self.KeySelectedValues)
                self.toDoTable.reloadData()
            }
        }
            
        let cancel = UIAlertAction(title: "Cancel", style: .default)
        alert.addAction(cancel)
        alert.addAction(addItem)
        present(alert, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let _selectedValueList = citys
        
        toDoTable.delegate = self
        toDoTable.dataSource = self
        
        isFirstTime = (UserDefaults.standard.object(forKey: FirstTimeValue) == nil)
        
        if(isFirstTime){
            UserDefaults.standard.set(false, forKey: FirstTimeValue)
            UserDefaults.standard.set(self.citys, forKey: KeySelectedValues)
        } else {
            self.citys = UserDefaults.standard.object(forKey: KeySelectedValues) as! [String]
        }
    }
}




