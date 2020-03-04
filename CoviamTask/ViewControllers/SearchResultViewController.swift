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
    
    let spinner = UIActivityIndicatorView(style: .medium)
    var pageTitle = ""
    var itemList = [Product]()
    var loadCount = 0
    var isMoreDataAvailable = true

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = pageTitle
        spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
        
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
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        //this prepares the activity indicator
        let lastSectionIndex = tableView.numberOfSections - 1
        let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
        if indexPath.section ==  lastSectionIndex && indexPath.row == lastRowIndex {
        self.tableView.tableFooterView = spinner
  
        //pagination logic
        if indexPath.row + 1 == itemList.count, isMoreDataAvailable {
            loadMoreData(start: itemList.count + 1)
        }
        }
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
        self.tableView.tableFooterView?.isHidden = false
        spinner.startAnimating()
        API().sendRequest(parameters: params) { [weak self](result,error) in
            if error != nil {
                print(error?.localizedDescription ?? "")
                return
            }
            if let productList = result?.products {
                if productList.count == 0 {
                    self?.isMoreDataAvailable = false
                    DispatchQueue.main.async {
                        self?.tableView.tableFooterView?.isHidden = true
                        self?.spinner.stopAnimating()
                    }
                }
                for product in productList {
                    self?.itemList.append(product)
                }
            }
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
}

