//
//  Product.swift
//  EbsTest
//
//  Created by Oneest on 8/18/18.
//  Copyright © 2018 Oneest. All rights reserved.
//

import Foundation

struct Product: Decodable {
    
    var id: Int
    var title: String
    var image: String
    var shortDescription: String
    var price: Int
    var salePercent: Int
    var details: String
    
    private enum CodingKeys: String, CodingKey {
        case id, title, image, shortDescription = "short_description", price, salePercent = "sale_precent", details
    }
    
    var imageURL: URL? {
        return URL(string: image)
    }
}
