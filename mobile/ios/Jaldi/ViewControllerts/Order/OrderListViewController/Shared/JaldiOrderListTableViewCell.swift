//
//  JaldiOrderListTableViewCell.swift
//  Jaldi
//
//  Created by Grigori Jlavyan on 5/27/17.
//  Copyright © 2017 Handybook. All rights reserved.
//

import UIKit

class JaldiOrderListTableViewCell: UITableViewCell {

    @IBOutlet weak var orderTypeLabel: UILabel!
    @IBOutlet weak var orderAddressLabel: UILabel!
    @IBOutlet weak var orderTimeLabel: UILabel!
    @IBOutlet weak var numberOfHoursLabel: UILabel!
    @IBOutlet weak var orderPriceLabel: UILabel!
    lazy var formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeStyle = DateFormatter.Style.short
        formatter.dateStyle = DateFormatter.Style.short
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
        orderTypeLabel.text = order.type ?? "CLEANING"
        orderAddressLabel.text = order.address ?? ""
        let hours = order.hours ?? 0
        numberOfHoursLabel.text = "\(hours) hours"
        let cost  = order.cost ?? 0
        orderPriceLabel.text = "\(Int(cost)) QR"
        let reportTime = order.orderDate ?? Date()
        orderTimeLabel.text = formatter.string(from: reportTime)
    }
}
