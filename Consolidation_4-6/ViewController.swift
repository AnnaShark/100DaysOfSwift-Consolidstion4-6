//
//  ViewController.swift
//  Consolidation_4-6
//
//  Created by Anna Shark on 2/9/22.
//

import UIKit
import Foundation

class ViewController: UITableViewController {
    
    var shoppingList = [String]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAddItem))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(startAgain))
        title = "Shopping list"
        
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let share = UIBarButtonItem(barButtonSystemItem:.action, target: self, action: #selector(shareTapped))
        toolbarItems = [spacer, share]
        navigationController?.isToolbarHidden = false
    }
    
    @objc func startAgain() {
        shoppingList.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Item", for: indexPath)
        cell.textLabel?.text = shoppingList[indexPath.row]
        return cell
    }

    @objc func promptForAddItem() {
        let ac = UIAlertController(title: "Enter an item", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Add to the list", style: .default) {
            [weak self, weak ac] action in
            guard let answer = ac?.textFields?[0].text else {return}
                self?.submit(answer)
        }
        
        ac.addAction(submitAction)
        present(ac,animated: true)
    }
    
    func submit (_ answer: String) {
        print("call from submit" )
        
        shoppingList.insert(answer, at: 0)
        tableView.beginUpdates()
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
        tableView.endUpdates()

    }


    @objc func shareTapped() {
        let list = shoppingList.joined(separator: "\n")
 
        let vc = UIActivityViewController(activityItems: [list], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }

}

