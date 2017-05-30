//
//  JaldiOrderListViewController.swift
//  Jaldi
//
//  Created by Grigori Jlavyan on 5/27/17.
//  Copyright © 2017 Handybook. All rights reserved.
//

import UIKit
enum OrderListType: Int {
    case past
    case upcoming
    case inProgress
}
protocol JaldiOrderListViewControllerDelegate: class {
    func orderList(viewController:JaldiOrderListViewController, didSelect order:JaldiOrder)
}
class JaldiOrderListViewController: UIViewController {

    @IBOutlet weak var theTableView: UITableView!
    var orderListType:OrderListType = .past
    fileprivate var orders: [JaldiOrder]?
    weak var delegate: JaldiOrderListViewControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        theTableView.rowHeight = 90
        orders = JaldiOrderDummyData.ordersFor(orderListType: orderListType)
        theTableView.reloadData()
    }
}

// MARK: UITableView
extension JaldiOrderListViewController: UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int{
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let orders = self.orders else {
            return 0
        }
        return orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let simpleTableIdentifier = "JaldiOrderListTableViewCell"
        let cell:JaldiOrderListTableViewCell! = tableView.dequeueReusableCell(withIdentifier: simpleTableIdentifier) as? JaldiOrderListTableViewCell
        guard let orders = orders else {
             return cell
        }
        cell.configureWith(order: orders[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let orders = self.orders else {
            return
        }
        let order = orders[indexPath.row]
        delegate?.orderList(viewController: self, didSelect: order)

     }
}
