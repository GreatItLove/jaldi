//
//  JaldiBookingDetailsTableViewCell.swift
//  Jaldi
//
//  Created by Grigori Jlavyan on 5/4/17.
//  Copyright © 2017 Handybook. All rights reserved.
//

import UIKit
protocol JaldiBookingDetailsTableViewCellDelegate: class {
    func detailsItem(cell:JaldiBookingDetailsTableViewCell, didChangeSelected index:Int)
}
class JaldiBookingDetailsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var detailsItemTitleLabel: UILabel!
    @IBOutlet weak var detailsItemDescriptionLabel: UILabel!
    @IBOutlet weak var bottomLine: UIView!
    @IBOutlet var pickerView: AKPickerView!
    var detailItem: BookingDetailsItem?
    weak var delegate:JaldiBookingDetailsTableViewCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    //MARK: Configuration
    func configureWith(detailItem:BookingDetailsItem , isLastCell:Bool) {
        self.detailItem = detailItem
       self.configurePicker()
       detailsItemTitleLabel.text = detailItem.title
       bottomLine.isHidden = isLastCell
       self.configureDescritionLabelWith(detailItem: detailItem)
       self.pickerView.selectItem(detailItem.sellectedIndex, animated: false)
    }
    
    private func configurePicker() {
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        
        self.pickerView.font = UIFont(name: "HelveticaNeue-Light", size: 20)!
        self.pickerView.highlightedFont = UIFont(name: "HelveticaNeue", size: 20)!
        self.pickerView.pickerViewStyle = .flat
        self.pickerView.maskDisabled = true
        self.pickerView.reloadData()
    }
    
    fileprivate func configureDescritionLabelWith(detailItem:BookingDetailsItem) {
        if detailItem.canShowDescription(){
            detailsItemDescriptionLabel.isHidden = false
            detailsItemDescriptionLabel.text = detailItem.desc
        }else{
            detailsItemDescriptionLabel.isHidden = true
        }
    
    }
}
// MARK: - AKPickerViewDataSource

extension JaldiBookingDetailsTableViewCell: AKPickerViewDataSource, AKPickerViewDelegate {

    func numberOfItemsInPickerView(_ pickerView: AKPickerView) -> Int {
        return self.detailItem?.bookingProperties.count ?? 0
    }

    func pickerView(_ pickerView: AKPickerView, titleForItem item: Int) -> String {
        return self.detailItem?.bookingProperties[item] ?? ""
    }
    
    func pickerView(_ pickerView: AKPickerView, imageForItem item: Int) -> UIImage {
        return UIImage(named: "")!
    }
    
    // MARK: - AKPickerViewDelegate
    func pickerView(_ pickerView: AKPickerView, didSelectItem item: Int) {
        let descripyionIsShownBefore = detailItem?.canShowDescription()
        detailItem?.sellectedIndex = item
        let descripyionIsShownAfter = detailItem?.canShowDescription()
        if descripyionIsShownBefore != descripyionIsShownAfter {
           self.delegate?.detailsItem(cell: self, didChangeSelected: item)
        }
       
    }

}

