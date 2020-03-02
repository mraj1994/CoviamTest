//
//  SearchResultViewController.swift
//  CoviamTask
//
//  Created by Mraj singh on 01/03/20.
//  Copyright © 2020 Mraj singh. All rights reserved.
//

import UIKit

class SearchResultViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var pageTitle = ""
    var itemList = [Product]()
    var loadCount = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = pageTitle
        
    }

    @IBAction func backButtonTapped(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
}


//Table View delegate and Data source methods
extension SearchResultViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell", for: indexPath) as! ProductTableViewCell
        
        if itemList.count > 0 {
            cell.setupCell(data: itemList[indexPath.row])
        } 
        
        
        if indexPath.row + 1 == itemList.count {
            loadCount += 1
            loadMoreData(start: loadCount * itemList.count)
           
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }

    
    
    
}


extension SearchResultViewController {
    
    
    // this mehtods loads more data while scrolling
    func loadMoreData(start: Int){
        let params: [String:Any] = [
                 "searchTerm" : pageTitle,
                 "start" : "\(start)",
                 "itemPerPage" : "20"
        ]
        API().sendRequest(parameters: params) { [weak self](result,error) in
            if error != nil {
                print(error)
                return
            }
                 
        if let productDataArray =  result!["products"] as? [[String: Any]] {
            var product = Product()
            for productDict in productDataArray {
                product = Product(params: productDict)
                    self?.itemList.append(product)
                }
            }
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
}

