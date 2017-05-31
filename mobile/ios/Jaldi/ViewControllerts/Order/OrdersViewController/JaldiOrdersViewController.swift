//
//  JaldiOrdersViewController.swift
//  Jaldi
//
//  Created by Grigori Jlavyan on 5/27/17.
//  Copyright © 2017 Handybook. All rights reserved.
//

import UIKit

class JaldiOrdersViewController: UIViewController {

    @IBOutlet weak var ordersContainerView: SwiftPages!
    
    // controllers
    var pastOrderListController:JaldiOrderListViewController =  {
        let storyboard: UIStoryboard = UIStoryboard(name: "Order", bundle: nil)
        let orderListViewController = storyboard.instantiateViewController(withIdentifier: "JaldiOrderListViewController") as? JaldiOrderListViewController
        return orderListViewController!
    }()
    
    var upComingOrderListController:JaldiOrderListViewController =  {
        let storyboard: UIStoryboard = UIStoryboard(name: "Order", bundle: nil)
        let orderListViewController = storyboard.instantiateViewController(withIdentifier: "JaldiOrderListViewController") as? JaldiOrderListViewController
        return orderListViewController!
    }()
    
    var inProgressOrderListController:JaldiOrderListViewController =  {
        let storyboard: UIStoryboard = UIStoryboard(name: "Order", bundle: nil)
        let orderListViewController = storyboard.instantiateViewController(withIdentifier: "JaldiOrderListViewController") as? JaldiOrderListViewController
        return orderListViewController!
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        ordersContainerView.delegate = self
        configurePages()

    }
 
    //Mark: Configuration
    private func configurePages(){
        automaticallyAdjustsScrollViewInsets = false
        
//        self.pastOrderListController.delegate = self
//        self.upComingOrderListController.delegate = self
//        self.inProgressOrderListController.delegate = self
        
//        self.pastOrderListController.orderListType = .past
//        self.upComingOrderListController.orderListType = .upcoming
//        self.inProgressOrderListController.orderListType = .inProgress
        
        let VCsArray = [self.inProgressOrderListController, self.upComingOrderListController, self.pastOrderListController] as [UIViewController]
        let buttonTitles = ["In progress", "Upcoming", "Past"]
        
        // Sample customization
        ordersContainerView.setOriginY(origin: 0)
        ordersContainerView.setTopBarBackground(color: UIColor.white)
        ordersContainerView.setButtonsTextColor(color: UIColor.darkGray ,selectedColor: UIColor.darkText )
        ordersContainerView.setButtonsTextFontAndSize(fontAndSize: UIFont.systemFont(ofSize: 14))
        ordersContainerView.setAnimatedBarColor(color: AppColors.BlueColor)
        ordersContainerView.setAnimatedBarHeight(pointSize: 5)
        ordersContainerView.setTopBarHeight(pointSize: 35)
        ordersContainerView.enableBarShadow(boolValue: true)
        
        ordersContainerView.initializeWithVCsInstanciatedArrayAndButtonTitlesArray(VCsArray: VCsArray, buttonTitlesArray: buttonTitles)

    }
    //MARK: Actions
    @IBAction func closeAction(_ sender: Any) {
        self.dismiss(animated: true) {
        }
    }
}

// MARK: - SwiftPagesDelegate
extension JaldiOrdersViewController: SwiftPagesDelegate {
    func SwiftPagesCurrentPageNumber(currentIndex: Int){
       print(currentIndex)
    }
}

//extension JaldiOrdersViewController: JaldiOrderListViewControllerDelegate {
//    func orderList(viewController:JaldiOrderListViewController, didSelect order:JaldiOrder) {
//        let storyboard: UIStoryboard = UIStoryboard(name: "Order", bundle: nil)
//        let orderStateViewController = storyboard.instantiateViewController(withIdentifier: "JaldiOrderStateViewController") as? JaldiOrderStateViewController
//        orderStateViewController?.order = order
//        orderStateViewController?.appearance = .push
//        self.navigationController?.pushViewController(orderStateViewController!, animated: true)
//    }
//}

