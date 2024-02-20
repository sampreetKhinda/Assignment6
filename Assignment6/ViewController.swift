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
    var taskArr = ["Submit IOS assignment","Attend lecture at 4pm", "Go to Gym", "Purchase groccery for March"]
   
    private let KeySelectedValues = "KeySelectedIndexes"
    private let FirstTimeValue = "FirstTime"
    var isFirstTime = true
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = toDoTable.dequeueReusableCell(withIdentifier: "ToDoCell", for: indexPath)
              cell.textLabel?.text = taskArr[indexPath.row]
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
                self.taskArr.append(String(textField.text!))
                UserDefaults.standard.set(self.taskArr, forKey: self.KeySelectedValues)
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
        
        toDoTable.delegate = self
        toDoTable.dataSource = self
        
        isFirstTime = (UserDefaults.standard.object(forKey: FirstTimeValue) == nil)
        
        if(isFirstTime){
            UserDefaults.standard.set(false, forKey: FirstTimeValue)
            UserDefaults.standard.set(self.taskArr, forKey: KeySelectedValues)
        } else {
            self.taskArr = UserDefaults.standard.object(forKey: KeySelectedValues) as! [String]
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == .delete {
                    // Delete the row from the data source
                    taskArr.remove(at: indexPath.row)
                    UserDefaults.standard.set(self.taskArr, forKey: self.KeySelectedValues)
                    // Then, delete the row from the table itself
                    tableView.deleteRows(at: [indexPath], with: .fade)
            }
    }
}




