//
//  DetailViewController.swift
//  EbsTest
//
//  Created by Oneest on 8/18/18.
//  Copyright © 2018 Oneest. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, StoryboardInitable {

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productDescription: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productDetails: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    static var storyboardName: String {
        return "Main"
    }
    
    @discardableResult
    func configure(productId: Int) -> Self {
        RequestSender().send(RequestType.product(id: productId), success: { [weak self] (product: Product?) in
        
            self?.navigationItem.title = product?.title
            self?.productImage.load(url: product?.imageURL, placeholder: nil)
            self?.productTitle.text = product?.title
            self?.productDescription.text = product?.shortDescription
            self?.productPrice.text = "$ \(product?.price.description ?? "")"
            self?.productDetails.text = product?.details
            self?.view.layoutIfNeeded()
        }) { (error) in
            Alert().message(error?.message ?? "Error").show()
            print(error?.localizedDescription ?? "")
        }
        return self
    }
}
