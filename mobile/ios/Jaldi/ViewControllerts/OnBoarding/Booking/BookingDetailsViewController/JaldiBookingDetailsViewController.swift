//
//  JaldiBookingDetailsViewController.swift
//  Jaldi
//
//  Created by Grigori Jlavyan on 5/4/17.
//  Copyright © 2017 Handybook. All rights reserved.
//

import UIKit

class JaldiBookingDetailsViewController: UIViewController,BookingNavigation {

    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var theTableView: UITableView!
    var bookingObject:BookingObject?
    var curretScreen: BookingScreen = BookingScreen.details
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureTableView()
        configureBookingProgress()
    }
    //MARK: Confifuration
    private func configureTableView() -> Void {
        theTableView.estimatedRowHeight = 115
//        theTableView.rowHeight = UITableViewAutomaticDimension
    }

    //MARK: Actions
    @IBAction func closeAction(_ sender: Any) {
        self.dismiss(animated: true) {
        }
    }
    @IBAction func nextAction(_ sender: Any) {
        self.showNextScreen()
    }
    
    private func showNextScreen() {
        if !self.isLastScreen() {
            if let nextViewController = self.nextScreen() {
                self.navigationController?.pushViewController(nextViewController, animated: true)
            }
        }
    }
    
}

// MARK: UITableView
extension JaldiBookingDetailsViewController: UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int{
        return (bookingObject != nil  ? 1: 0)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = bookingObject?.bookingDetails.detailItems.count{
        return  count + 1
        }
        return    0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if indexPath.row == 0 {
            let simpleTableIdentifier = "JaldiBookingDetailsHeaderCell"
            let cell:JaldiBookingDetailsHeaderCell! = tableView.dequeueReusableCell(withIdentifier: simpleTableIdentifier) as? JaldiBookingDetailsHeaderCell
            cell.configureWith(title: bookingObject?.bookingDetails.title)
            cell.backgroundColor = UIColor.clear
            return cell;

        }
        let simpleTableIdentifier = "JaldiBookingDetailsTableViewCell"
        let cell:JaldiBookingDetailsTableViewCell = tableView.dequeueReusableCell(withIdentifier: simpleTableIdentifier, for: indexPath) as! JaldiBookingDetailsTableViewCell
        if let bookingDetailsItems = bookingObject?.bookingDetails.detailItems{
          cell.configureWith(detailItem: bookingDetailsItems[indexPath.row - 1 ], isLastCell: (indexPath.row == (bookingDetailsItems.count )))
          cell.delegate = self
        }
        return cell
    }
    
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?{
//        
//        let simpleTableIdentifier = "JaldiBookingDetailsHeaderCell"
//        let cell:JaldiBookingDetailsHeaderCell! = tableView.dequeueReusableCell(withIdentifier: simpleTableIdentifier) as? JaldiBookingDetailsHeaderCell
//       cell.configureWith(title: bookingObject?.bookingDetails.title)
//        return cell;
//    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return  indexPath.row == 0 ? 50: UITableViewAutomaticDimension
    }

}
extension JaldiBookingDetailsViewController:JaldiBookingDetailsTableViewCellDelegate {
    func detailsItem(cell:JaldiBookingDetailsTableViewCell, didChangeSelected index:Int){
        guard let indexPath = theTableView.indexPath(for: cell) else {return}
        self.theTableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.fade)
    }
}
