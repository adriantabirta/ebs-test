//
//  ViewController.swift
//  EbsTest
//
//  Created by Oneest on 8/18/18.
//  Copyright © 2018 Oneest. All rights reserved.
//

import UIKit

class ViewController: UIViewController, StoryboardInitable {

    @IBOutlet weak var tableview: UITableView!
    fileprivate var products: [Product] = []
    
    lazy var refreshControl: UIRefreshControl = {
        $0.addTarget(self, action: #selector(ViewController.handleRefresh(_:)), for: UIControlEvents.valueChanged)
        $0.tintColor = UIColor.ebsPurple
        return $0
    }(UIRefreshControl())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.tableFooterView = UIView()
        tableview.refreshControl = refreshControl
        refreshControl.beginRefreshing()
        loadData()
    }
    
    static var storyboardName: String {
        return "Main"
    }
}

// MARK: UITableViewDelegate

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController.instantiateViaStoryboard().configure(productId: products[indexPath.row].id)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height * 0.45
    }
}

// MARK: UITableViewDataSource

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return (tableView.dequeueCell(for: indexPath) as ProductCell).configure(products[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
}

// MARK: Private methods

extension ViewController {
    
    @objc private func handleRefresh(_ refreshControl: UIRefreshControl) {
        cleanOldData()
        loadData()
    }
    
    private func cleanOldData() {
        refreshControl.endRefreshing()
        products.removeAll()
        tableview.reloadData()
    }
    
    private func loadData() {
        RequestSender().send(RequestType.products(offest: 0, limit: 10), success: { [weak self] (products: [Product]?) in
            guard let products = products else { return }
            self?.products = products
            DispatchQueue.main.async {
                self?.refreshControl.endRefreshing()
                self?.tableview.reloadData()
            }
            
        }) { [weak self] (error) in
            DispatchQueue.main.async {
                self?.refreshControl.endRefreshing()
            }
            Alert().message(error?.message ?? "Error").show()
            print(error?.localizedDescription ?? "")
        }
    }
}





