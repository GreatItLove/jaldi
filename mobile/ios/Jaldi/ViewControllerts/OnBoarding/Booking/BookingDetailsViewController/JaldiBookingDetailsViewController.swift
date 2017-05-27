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
    var suggestedHoursItem:BookingDetailsItem?
    var suggestedHoursClosure: ((Int,Int) -> Int) = {x,y in
        let value = Int((x + y - 2) / 2) + 3
        return min(10,value)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureTableView()
        configureBookingProgress()
        self.configureSuggestedHours()
    }
    //MARK: Confifuration
    private func configureTableView() -> Void {
        theTableView.estimatedRowHeight = 115
//     vartheTableView.rowHeight = UITableViewAutomaticDimension
    }
    private func configureSuggestedHours() {
        if let booking = bookingObject{
            if booking.bookingDetails.hoursSuggestionEnabled {
                let minValue  = suggestedHoursClosure(0, 0)
                let maxValue  = suggestedHoursClosure(10, 10)
                let hours  =  (minValue...maxValue).map { "\($0)" }
                suggestedHoursItem = BookingDetailsItem(title: "Suggested Hours", desc: nil, bookingProperties: hours)
                booking.bookingDetails.hours = minValue
            }
            
        }
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
            let sugestedHoursCount = (bookingObject?.bookingDetails.hoursSuggestionEnabled)! ? 1 : 0
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
            let lastIndex  = bookingDetailsItems.count + ((bookingObject?.bookingDetails.hoursSuggestionEnabled)! ? 1 : 0 )
            if (bookingObject?.bookingDetails.hoursSuggestionEnabled)! && indexPath.row == lastIndex{
              cell.configureWith(detailItem: suggestedHoursItem!, isLastCell: (indexPath.row == lastIndex))
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
        if  (bookingObject?.bookingDetails.hoursSuggestionEnabled)!  {
            let  lastindex = self.theTableView.numberOfRows(inSection: 0) - 1
            if indexPath.row != lastindex{
                self.correctSuggestedHours()
            }else{
                if let suggestedHoursItem = suggestedHoursItem {
                    suggestedHoursItem.sellectedIndex = index
                    let hours  = Int(suggestedHoursItem.bookingProperties[suggestedHoursItem.sellectedIndex])
                    bookingObject?.bookingDetails.hours = hours!
                }
            }
        }
    }
    private func correctSuggestedHours() {
        
        guard let hoursSugestationEnabled = bookingObject?.bookingDetails.hoursSuggestionEnabled,  let firstValueStr  = bookingObject?.bookingDetails.detailItems[0].sellectedIndex, let secondValueStr  = bookingObject?.bookingDetails.detailItems[1].sellectedIndex else {
            return
        }
        if hoursSugestationEnabled{
            let firstValue = Int(firstValueStr)
            let secondValue = Int(secondValueStr)
            let  newValue = self.suggestedHoursClosure(firstValue, secondValue)
            if  let index  = suggestedHoursItem?.bookingProperties.index(of: "\(newValue)"){
                if suggestedHoursItem?.sellectedIndex != index{
                    suggestedHoursItem?.sellectedIndex = index
                    let  lastindex = self.theTableView.numberOfRows(inSection: 0)
                    let indexPath  = IndexPath(item: (lastindex -  1), section: 0)
                    self.theTableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.fade)
                }
                bookingObject?.bookingDetails.hours = newValue
            }
        }
    }
}
