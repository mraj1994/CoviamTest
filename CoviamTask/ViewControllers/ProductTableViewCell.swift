//
//  ProductTableViewCell.swift
//  CoviamTask
//
//  Created by Mraj singh on 02/03/20.
//  Copyright © 2020 Mraj singh. All rights reserved.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var otherOffersLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func setupCell(data: Product) {
        
        if let imageURLArray = data.images {
                self.imageView?.loadImageUsingCache(withUrl: imageURLArray[0])
            }
            self.productNameLabel.text = data.name
            self.productPriceLabel.text = data.price?.priceDisplay
            
        if let number = data.otherOfferings?.count, let price = data.otherOfferings?.startPrice {
                 self.otherOffersLabel.text = String(format: "%@ other offers starting from %@", "\(number)",price)
            }
    }

}
