//
//  ProductDataModel.swift
//  CoviamTask
//
//  Created by QuietGrowth pty ltd on 02/03/20.
//  Copyright © 2020 Mraj singh. All rights reserved.
//

import Foundation


struct SearchResult:Codable {
    var code:Int?
    var status : String?
    var data: Result?
    
}

struct Result: Codable {
    var products : [Product]
}


struct Product: Codable {
    var name: String?
    var price: Price?
    var images: [String]?
    var review: Review?
    var otherOfferings: OtherOfferings?
    
}


struct Price: Codable {
    var priceDisplay: String?
    var offerPriceDisplay: String?
    
}


struct Review:Codable {
    var rating: Int?
    var count: Int?
    
}

struct OtherOfferings: Codable {
    var count: Int?
    var startPrice: String?

}
