//
//  JaldiBookingPaymentMethodCell.swift
//  Jaldi
//
//  Created by Grigori Jlavyan on 5/11/17.
//  Copyright © 2017 Handybook. All rights reserved.
//

import UIKit

protocol JaldiBookingPaymentMethodCellDelegate: class {
    func showCardInformation()
}

class JaldiBookingPaymentMethodCell: UITableViewCell {
    weak var delegate : JaldiBookingPaymentMethodCellDelegate?
    
    @IBOutlet weak var terminalImageView: UIImageView!
    @IBOutlet weak var cardImageView: UIImageView!
    @IBOutlet weak var cashImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let cashTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(cashImageTapped(tapGestureRecognizer:)))
        cashImageView.addGestureRecognizer(cashTapGestureRecognizer)
        
        let cardTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(cardImageTapped(tapGestureRecognizer:)))
        cardImageView.addGestureRecognizer(cardTapGestureRecognizer)
        
        let terminalTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(terminalImageTapped(tapGestureRecognizer:)))
        terminalImageView.addGestureRecognizer(terminalTapGestureRecognizer)
    }

    func cashImageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        cashImageView.image = AppImages.holder_active_pic
        cardImageView.image = AppImages.holder_pic
        terminalImageView.image = AppImages.holder_pic
        // Your action
    }
    
    func cardImageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        cashImageView.image = AppImages.holder_pic
        cardImageView.image = AppImages.holder_active_pic
        terminalImageView.image = AppImages.holder_pic
        // Your action
    }
    
    func terminalImageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        cashImageView.image = AppImages.holder_pic
        cardImageView.image = AppImages.holder_pic
        terminalImageView.image = AppImages.holder_active_pic
        // Your action
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

