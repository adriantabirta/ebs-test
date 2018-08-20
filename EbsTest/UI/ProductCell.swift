//
//  ProductCell.swift
//  EbsTest
//
//  Created by Oneest on 8/18/18.
//  Copyright © 2018 Oneest. All rights reserved.
//

import UIKit

final class ProductCell: UITableViewCell, NibInitable, Reusable {

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productDetails: UILabel!
    @IBOutlet weak var productPrice: UILabel!

    func configure(_ product: Product) -> Self {
        productImage.load(url: product.imageURL, placeholder: nil)
        productName.text = product.title
        productDetails.text = product.shortDescription
        productPrice.text = product.price.description
        return self
    }
}
