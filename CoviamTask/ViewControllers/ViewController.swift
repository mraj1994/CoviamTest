//
//  ViewController.swift
//  CoviamTask
//
//  Created by Mraj singh on 29/02/20.
//  Copyright © 2020 Mraj singh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var searchTextfield: UITextField!
    @IBOutlet weak var searchTableView: UITableView!
    
    var itemList = [Product]()
    var searchTerm = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        self.searchTextfield.resignFirstResponder()
    }
    
    
    
    @IBAction func clearButtonTapped(_ sender: UIButton) {
        searchTerm = ""
        searchTextfield.text = ""
       
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? UINavigationController {
            if let vc = destinationVC.topViewController as? SearchResultViewController {
                vc.itemList = itemList
                vc.pageTitle = searchTerm
            }
        }
    }
    
    @IBAction func searchTextChange(_ sender: UITextField) {
        let params: [String:Any] = [
            "searchTerm" : sender.text ?? "",
            "start" : "0",
            "itemPerPage" : "20"
        ]
    
        // this call api for search
        API().sendRequest(parameters: params) { [weak self](result,error) in
            self?.itemList.removeAll()
            
            if error != nil {
                print(error?.localizedDescription ?? "")
                return
            }
            
            if let productList = result?.products {
                for product in productList {
                    self?.itemList.append(product)
                }
            }

            DispatchQueue.main.async {
                self?.searchTableView.reloadData()
            }
        }
        self.searchTerm = sender.text ?? ""
      
        
    }
    


}

// table view delegate and datasource function
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SuggestedResultsTableViewCell", for: indexPath) as! SuggestedResultsTableViewCell
        
        if itemList.count > 0 {
            cell.productNameLabel.text = itemList[indexPath.row].name
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    
}


// textfield Delegate function
extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            if itemList.count > 0 {
                self.performSegue(withIdentifier: "show_results", sender: nil)
            }
        }
        return true
    }

}



extension ViewController {
    
    //this sets up the UI
    func setupView(){
        searchView.layer.cornerRadius = 6.0
        searchTextfield.returnKeyType = .search
        
    }
}

