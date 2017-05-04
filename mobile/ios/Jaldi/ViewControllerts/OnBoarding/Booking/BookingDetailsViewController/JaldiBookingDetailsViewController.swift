//
//  JaldiBookingDetailsViewController.swift
//  Jaldi
//
//  Created by Grigori Jlavyan on 5/4/17.
//  Copyright © 2017 Handybook. All rights reserved.
//

import UIKit

class JaldiBookingDetailsViewController: UIViewController {

    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var theTableView: UITableView!
    var bookingObject:BookingObject?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureTableView()
        configureProgress()
    }
    //MARK: Confifuration
    private func configureTableView() -> Void {
        theTableView.estimatedRowHeight = 115
        theTableView.rowHeight = UITableViewAutomaticDimension
    }
    private func configureProgress() -> Void {
       progressView.setProgress(1/4, animated: false)
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
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let onBoradingListViewController = storyboard.instantiateViewController(withIdentifier: "JaldiBookingDescriptionViewController") as? JaldiBookingDescriptionViewController
        onBoradingListViewController?.bookingObject = bookingObject
        self.navigationController?.pushViewController(onBoradingListViewController!, animated: true)
        
    }
    
}

// MARK: UITableView
extension JaldiBookingDetailsViewController: UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int{
        return (bookingObject != nil  ? 1: 0)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookingObject?.bookingDetails.detailItems.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let simpleTableIdentifier = "JaldiBookingDetailsTableViewCell"
        let cell:JaldiBookingDetailsTableViewCell = tableView.dequeueReusableCell(withIdentifier: simpleTableIdentifier, for: indexPath) as! JaldiBookingDetailsTableViewCell
        if let bookingDetailsItems = bookingObject?.bookingDetails.detailItems{
          cell.configureWith(detailItem: bookingDetailsItems[indexPath.row], isLastCell: (indexPath.row == (bookingDetailsItems.count - 1)))
          cell.delegate = self
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?{
        
        let simpleTableIdentifier = "JaldiBookingDetailsHeaderCell"
        let cell:JaldiBookingDetailsHeaderCell! = tableView.dequeueReusableCell(withIdentifier: simpleTableIdentifier) as? JaldiBookingDetailsHeaderCell
       cell.configureWith(title: bookingObject?.bookingDetails.title)
        return cell;
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }

}
extension JaldiBookingDetailsViewController:JaldiBookingDetailsTableViewCellDelegate {
    func detailsItem(cell:JaldiBookingDetailsTableViewCell, didChangeSelected index:Int){
        
        guard let indexPath = theTableView.indexPath(for: cell) else {return}
        self.theTableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.fade)
//       self.theTableView.reloadData()
    }
}
