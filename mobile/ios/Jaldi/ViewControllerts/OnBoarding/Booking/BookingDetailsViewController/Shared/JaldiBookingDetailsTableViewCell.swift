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
    var maxSize:CGSize =  CGSize(width: 0, height: 0)
    
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
        self.configureMaxSize(detailItem: detailItem)
       self.configurePicker()
       detailsItemTitleLabel.text = detailItem.title
       bottomLine.isHidden = isLastCell
       self.configureDescritionLabelWith(detailItem: detailItem)
       self.pickerView.selectItem(detailItem.sellectedIndex, animated: false)
    }
    func configureMaxSize(detailItem:BookingDetailsItem){
        if let proparties = self.detailItem?.bookingProperties{
            for proparty in proparties{
                let size = self.sizeForString(proparty as NSString)
                if maxSize.width < size.width{
                  maxSize = size
                }
            }
        }
    }
    
    private func configurePicker() {
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        
        self.pickerView.font = UIFont(name: "HelveticaNeue-Light", size: 15)!
        self.pickerView.highlightedFont = UIFont(name: "HelveticaNeue", size: 15)!
        self.pickerView.pickerViewStyle = .wheel
        self.pickerView.maskDisabled = false
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
    func pickerView(_ pickerView: AKPickerView, marginForItem item: Int) -> CGSize{
        if let proparty =  self.detailItem?.bookingProperties[item]{
          let size = self.sizeForString(proparty as NSString)
            let margin = maxSize.width - size.width - 44
            if margin > 0 {
                return CGSize(width: margin/2, height: 0)
            }
        }
     
        return CGSize(width: 0, height: 0)
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
    fileprivate func sizeForString(_ string: NSString) -> CGSize {
        let size =  string.size(attributes: [NSFontAttributeName: self.pickerView.font])
        let highlightedSize = string.size(attributes: [NSFontAttributeName: self.pickerView.highlightedFont])
        return CGSize(
            width: ceil(max(size.width, highlightedSize.width)),
            height: ceil(max(size.height, highlightedSize.height)))
    }

}

