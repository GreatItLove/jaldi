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
        orders = JaldiOrderDummyData.ordersFor(orderListType: orderListType)
        theTableView.reloadData()
    }
}

// MARK: UITableView
extension JaldiOrderListViewController: UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int{
        guard let orders = self.orders else {
            return 0
        }
        return orders.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let orders = self.orders  else {
            return 0
        }
        let order =  orders[section]
        let orderRatingState =  order.orderRatingState
        return (orderRatingState == .none) ? 1 : 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        guard let orders = orders else {
            let simpleTableIdentifier = "JaldiOrderListTableViewCell"
            let cell:JaldiOrderListTableViewCell! = tableView.dequeueReusableCell(withIdentifier: simpleTableIdentifier) as? JaldiOrderListTableViewCell
            return cell
        }
        let order = orders[indexPath.section]
        switch order.orderRatingState {
        case .none:
          return  orderListTableView(tableView, orderListCellForRowAt: indexPath)
        case .comment:
            if indexPath.row == 0{
                return  orderListTableView(tableView, orderListCommentCellForRowAt: indexPath)
            }else{
                return  orderListTableView(tableView, orderListCellForRowAt: indexPath)
            }
        case .rate:
            if indexPath.row == 0{
                return  orderListTableView(tableView, orderListRatingCellForRowAt: indexPath)
            }else{
                return  orderListTableView(tableView, orderListCellForRowAt: indexPath)
            }
        case .finished:
            if indexPath.row == 0{
                return  orderListTableView(tableView, orderListRatingFinishedCellForRowAt: indexPath)
            }else{
                return  orderListTableView(tableView, orderListCellForRowAt: indexPath)
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let orders = self.orders else {
            return
        }
        let order = orders[indexPath.section]
        if order.orderRatingState == .none || indexPath.row == 1 {
            delegate?.orderList(viewController: self, didSelect: order)
        }
     }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        guard let orders = self.orders else {
            return 0
        }
        let order = orders[indexPath.section]
        if order.orderRatingState == .none || indexPath.row == 1 {
            return 140
        }else {
          return 90
        }

    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
      return 0.1
    }
    

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
     return 20
    }

    
   //Mark: Table Cells
   private func orderListTableView(_ tableView: UITableView, orderListCellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let simpleTableIdentifier = "JaldiOrderListTableViewCell"
        let cell:JaldiOrderListTableViewCell! = tableView.dequeueReusableCell(withIdentifier: simpleTableIdentifier) as? JaldiOrderListTableViewCell
        guard let orders = orders else {
            return cell
        }
        cell.configureWith(order: orders[indexPath.section])
        return cell
    }
    private func orderListTableView(_ tableView: UITableView, orderListCommentCellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let simpleTableIdentifier = "JaldiOrderListCommentCell"
        let cell:JaldiOrderListCommentCell! = tableView.dequeueReusableCell(withIdentifier: simpleTableIdentifier) as? JaldiOrderListCommentCell
        cell.delagate = self
        guard let orders = orders else {
            return cell
        }
        cell.configureWith(order: orders[indexPath.section])

        return cell
    }
    private func orderListTableView(_ tableView: UITableView, orderListRatingCellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let simpleTableIdentifier = "JaldiOrderListRatingCell"
        let cell:JaldiOrderListRatingCell! = tableView.dequeueReusableCell(withIdentifier: simpleTableIdentifier) as? JaldiOrderListRatingCell
        cell.delagate = self
        return cell
    }
    
    private func orderListTableView(_ tableView: UITableView, orderListRatingFinishedCellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let simpleTableIdentifier = "JaldiOrderListRatingFinishedCell"
        let cell:JaldiOrderListRatingFinishedCell! = tableView.dequeueReusableCell(withIdentifier: simpleTableIdentifier) as? JaldiOrderListRatingFinishedCell
        return cell
    }
}
extension JaldiOrderListViewController:JaldiOrderListRatingCellDelegate {
    func orderList(ratingCell:UITableViewCell, didSaveComment comment:String?) {
        guard let indexPath  = self.theTableView.indexPath(for: ratingCell), let orders  = self.orders else { return }
        let order =  orders[indexPath.section]
        order.comment = comment
        self.theTableView.reloadRows(at: [indexPath], with: .fade)
    }
    func orderList(ratingCell:UITableViewCell, didSaveRating rating:Float) {
        guard let indexPath  = self.theTableView.indexPath(for: ratingCell), let orders  = self.orders else { return }
        let order =  orders[indexPath.section]
        order.rate = rating
        self.theTableView.reloadRows(at: [indexPath], with: .fade)
    }
}

    
