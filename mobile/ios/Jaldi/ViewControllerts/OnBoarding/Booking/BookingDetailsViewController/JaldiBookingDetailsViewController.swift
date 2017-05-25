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
    var sugestedHoursItem:BookingDetailsItem?
    var sugestedHoursClosure: ((Int,Int) -> Int) = {x,y in
        return Int((x + y - 2) / 2) + 3 }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureTableView()
        configureBookingProgress()
        if let booking = bookingObject{
            if booking.bookingDetails.hoursSugestationEnabled {
            let minValue  = sugestedHoursClosure(0, 0)
            let maxValue  = sugestedHoursClosure(10, 10)
            let hours  =  (minValue...maxValue).map { "\($0)" }
            sugestedHoursItem = BookingDetailsItem(title: "Suggested Hours", desc: nil, bookingProperties: hours)
            }
        }
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
            let sugestedHoursCount = (bookingObject?.bookingDetails.hoursSugestationEnabled)! ? 1 : 0
        return  count + 1 + sugestedHoursCount
        }
        return 0
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
            let lastIndex  = bookingDetailsItems.count + ((bookingObject?.bookingDetails.hoursSugestationEnabled)! ? 1 : 0 )
            if (bookingObject?.bookingDetails.hoursSugestationEnabled)! && indexPath.row == lastIndex{
              cell.configureWith(detailItem: sugestedHoursItem!, isLastCell: (indexPath.row == lastIndex))
            }else{
             cell.configureWith(detailItem: bookingDetailsItems[indexPath.row - 1 ], isLastCell: (indexPath.row == lastIndex))
            }
          
          cell.delegate = self
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return  indexPath.row == 0 ? 50: UITableViewAutomaticDimension
    }

}
extension JaldiBookingDetailsViewController:JaldiBookingDetailsTableViewCellDelegate {
    func detailsItem(cell:JaldiBookingDetailsTableViewCell, didChangeSelected index:Int, needsReload:Bool) {
        guard let indexPath = theTableView.indexPath(for: cell) else {return}
        if needsReload {
            self.theTableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.fade)
        }
        if  (bookingObject?.bookingDetails.hoursSugestationEnabled)!  {
          let  lastindex = self.theTableView.numberOfRows(inSection: 0) - 1
            if indexPath.row != lastindex{
             self.correctSuggestedHours()
            }
        }
        
    }
    private func correctSuggestedHours() {
        
        guard let hoursSugestationEnabled = bookingObject?.bookingDetails.hoursSugestationEnabled,  let firstValueStr  = bookingObject?.bookingDetails.detailItems[0].sellectedIndex, let secondValueStr  = bookingObject?.bookingDetails.detailItems[1].sellectedIndex else {
           return
        }
        if hoursSugestationEnabled{
         let firstValue = Int(firstValueStr)
         let secondValue = Int(secondValueStr)
         let  newValue = self.sugestedHoursClosure(firstValue, secondValue)
            if  let index  = sugestedHoursItem?.bookingProperties.index(of: "\(newValue)"){
              sugestedHoursItem?.sellectedIndex = index
              let  lastindex = self.theTableView.numberOfRows(inSection: 0)
              let indexPath  = IndexPath(item: (lastindex -  1), section: 0)
              self.theTableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.fade)
            }
        }
        
        
    }
}
