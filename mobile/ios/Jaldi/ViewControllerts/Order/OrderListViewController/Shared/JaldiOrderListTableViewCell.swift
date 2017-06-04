//
//  JaldiOrderListTableViewCell.swift
//  Jaldi
//
//  Created by Grigori Jlavyan on 5/27/17.
//  Copyright © 2017 Handybook. All rights reserved.
//

import UIKit

class JaldiOrderListTableViewCell: UITableViewCell {
    
    private let orderStateFinishedColor = UIColor(red: 255/256.0, green: 253/256.0, blue: 241/256.0, alpha: 1)//43b0d0
    @IBOutlet weak var orderListWorkersView: JaldiOrderListWorkersView!
    @IBOutlet weak var orderListStateView: OrderListStateView!
    
    @IBOutlet weak var orderTypeLabel: UILabel!
    @IBOutlet weak var orderAddressLabel: UILabel!
    @IBOutlet weak var orderTimeLabel: UILabel!
    @IBOutlet weak var numberOfHoursLabel: UILabel!
    @IBOutlet weak var orderPriceLabel: UILabel!
    @IBOutlet weak var workersLabel: UILabel!
    lazy var formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeStyle = DateFormatter.Style.short
        formatter.dateStyle = DateFormatter.Style.medium
        return formatter
    }()
    lazy var timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeStyle = DateFormatter.Style.short
        formatter.dateStyle = DateFormatter.Style.none
        return formatter
    }()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //Mark: Configuration
    func configureWith(order:JaldiOrder) {
        if order.orderRatingState == .none{
          self.backgroundColor = UIColor.white
        }else{
           self.backgroundColor = orderStateFinishedColor
        }
        orderListWorkersView.configureWith(order: order)
        orderListStateView.configureWith(orderState: order.orderState)
        configureOrderDetailsFor(order: order)
    }
    private func configureOrderDetailsFor(order:JaldiOrder) {
        orderTypeLabel.text = orderTitleFor(homeCategory: order.homeCategory)
        orderTypeLabel.sizeToFit()
        orderAddressLabel.text = order.address ?? ""
        configureTimeFor(order: order)
        
        let hours = order.hours ?? 0
        numberOfHoursLabel.text = "Hours: \(hours)"
        
        let workers  = order.workers ?? 0
        orderPriceLabel.text = "Workers: \(workers)"
        
        let cost  = order.cost ?? 0
        orderPriceLabel.text = "Cost: \(Int(cost)) QAR"
    }
    
    private func configureTimeFor(order:JaldiOrder) {
        let hours = order.hours ?? 0
        let startTime = order.orderDate ?? Date()
        let endTime = startTime.add(hours: hours)
        let startTimeStr = formatter.string(from: startTime)
        let endTimeStr = timeFormatter.string(from: endTime)
        orderTimeLabel.text = "\(startTimeStr) - \(endTimeStr)"
    }
    
    private func orderTitleFor(homeCategory:HomeCategory) -> String {
       return HomeCategoryHeleper.orderTitleFor(homeCategory:homeCategory)
    }
    
}
