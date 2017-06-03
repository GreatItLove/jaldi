//
//  JaldiOrderListViewController.swift
//  Jaldi
//
//  Created by Grigori Jlavyan on 5/27/17.
//  Copyright © 2017 Handybook. All rights reserved.
//

import UIKit

class JaldiOrderListViewController: UIViewController {

    @IBOutlet weak var theTableView: UITableView!
    fileprivate var orders: [JaldiOrder]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.reloadOrders()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        theTableView.reloadData()
    }
    private func reloadOrders() {
        self.showHudWithMsg(message: nil)
        let task  = JaldiMyOrdersTask()
        task.execute(in: NetworkDispatcher.defaultDispatcher(), taskCompletion: {[weak self] (orderList) in
            self?.hideHud()
            self?.orders = orderList
            self?.theTableView.reloadData()
        }) { [weak self] (error, _) in
            self?.hideHud()
            if let error = error {
                if case NetworkErrors.networkMessage(error_: _, message: let message) = error {
                    self?.showAlertWith(title: NSLocalizedString("Error", comment: ""), message: message)
                }else{
                    self?.showAlertWith(title: NSLocalizedString("Error", comment: ""), message: NSLocalizedString("CantLoadOrder", comment: ""))
                }
            }
            print(error ?? "Error")
        }
    }
    //MARK: Actions
    @IBAction func closeAction(_ sender: Any) {
        self.dismiss(animated: true) {
        }
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
        case .rate:
            if indexPath.row == 0{
                return  orderListTableView(tableView, orderListRatingCellForRowAt: indexPath)
            }else{
                return  orderListTableView(tableView, orderListCellForRowAt: indexPath)
            }
        case .comment:
            if indexPath.row == 0{
                return  orderListTableView(tableView, orderListCommentCellForRowAt: indexPath)
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
            self.orderListShow(order: order)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        guard let orders = self.orders else {
            return 0
        }
        let order = orders[indexPath.section]
        if order.orderRatingState == .none || indexPath.row == 1 {
            return 120
        }else {
          return 90
        }

    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 10
        } else {
            return 1
        }
    }
    

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
     return 0.01
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
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
    
    private func orderListShow(order:JaldiOrder) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Order", bundle: nil)
        let orderStateViewController = storyboard.instantiateViewController(withIdentifier: "JaldiOrderStateViewController") as? JaldiOrderStateViewController
        orderStateViewController?.order = order
        orderStateViewController?.appearance = .push
//        testOrderById(orderId: order.orderId!)
        self.navigationController?.pushViewController(orderStateViewController!, animated: true)
    }
    private func testOrderById(orderId: Int) {
        let task  = JaldiOrderByIdTask(orderId: orderId)
        task.execute(in: NetworkDispatcher.defaultDispatcher(), taskCompletion: {(order) in
//            print(order?.orderId)
        }) {  (error, _) in
           print("error")
        }
    }
}
extension JaldiOrderListViewController:JaldiOrderListRatingCellDelegate {
    func orderList(ratingCell:UITableViewCell, didSaveComment comment:String?) {
        
        guard let indexPath  = self.theTableView.indexPath(for: ratingCell),
            let orders  = self.orders , let userFeedback = comment else { return }
        let order =  orders[indexPath.section]
        self.feedback(order: order, userFeedback: userFeedback, indexPath: indexPath)
    }
    func orderList(ratingCell:UITableViewCell, didSaveRating rating:Float) {
        guard let indexPath  = self.theTableView.indexPath(for: ratingCell), let orders  = self.orders else { return }
        let order =  orders[indexPath.section]
        self.rate(order: order, rating: rating, indexPath: indexPath)
    }
    private func rate(order:JaldiOrder, rating:Float, indexPath:IndexPath) {
        guard let orderId = order.orderId else {
            return
        }
        let task  = JaldiOrderRateTask(orderId: orderId, userRating: rating)
        task.execute(in: NetworkDispatcher.defaultDispatcher(), taskCompletion: {[weak self] (success) in
            order.userRating = rating
            order.ratingInProgress = true
            self?.theTableView.reloadRows(at: [indexPath], with: .fade)
        }) { [weak self] (error, _) in
            if let error = error {
                if case NetworkErrors.networkMessage(error_: _, message: let message) = error {
                    self?.showAlertWith(title: NSLocalizedString("Error", comment: ""), message: message)
                }
            }
        }
    }
    
    private func feedback(order:JaldiOrder, userFeedback:String, indexPath:IndexPath) {
        guard let orderId = order.orderId else {
            return
        }
        let task  = JaldiOrderFeedbackTask(orderId: orderId, userFeedback: userFeedback)
        task.execute(in: NetworkDispatcher.defaultDispatcher(), taskCompletion: {[weak self] (success) in
            order.userFeedback = userFeedback
            order.ratingInProgress = true
            self?.theTableView.reloadRows(at: [indexPath], with: .fade)
        }) { [weak self] (error, _) in
            if let error = error {
                if case NetworkErrors.networkMessage(error_: _, message: let message) = error {
                    self?.showAlertWith(title: NSLocalizedString("Error", comment: ""), message: message)
                }
            }
        }
    }
    
}

    
