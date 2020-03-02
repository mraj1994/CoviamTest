//
//  ProductDataModel.swift
//  CoviamTask
//
//  Created by QuietGrowth pty ltd on 02/03/20.
//  Copyright © 2020 Mraj singh. All rights reserved.
//

import Foundation

class Product {
    var name: String?
    var price: Price?
    var image: [String]?
    var review: Review?
    var otherOffering: OtherOfferings?
    
    init() {
        
    }
    
    init(params: [String:Any]) {
        self.name = params["name"] as? String
        
        if let priceDict  = params["price"] as? [String:Any] {
            var price = Price()
            price.priceDisplay = priceDict["priceDisplay"] as? String
            price.offerPriceDisplay = priceDict["offerPriceDisplay"] as? String

            self.price = price
        }
        
        self.image = params["images"] as? [String]
        
        if let reviewDict = params["review"] as? [String:Any] {
            var review = Review()
            review.count = reviewDict["count"] as? Int
            review.rating = reviewDict["rating"] as? Int
            
            self.review = review
        }
        
        if let othersOfferingDict = params["otherOfferings"] as? [String:Any] {
            var otherOffering = OtherOfferings()
            
            otherOffering.count = othersOfferingDict["count"] as? Int
            otherOffering.startPrice = othersOfferingDict["startPrice"] as? String
            
            self.otherOffering = otherOffering
        }
        
    }
    
    
}


struct Price {
    var priceDisplay: String?
    var offerPriceDisplay: String?
    
}


struct Review {
    var rating: Int?
    var count: Int?
    
}

struct OtherOfferings {
    var count: Int?
    var startPrice: String?

}
