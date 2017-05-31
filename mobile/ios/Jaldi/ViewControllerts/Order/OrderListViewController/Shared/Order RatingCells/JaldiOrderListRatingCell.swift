//
//  JaldiOrderListRatingCell.swift
//  Jaldi
//
//  Created by Grigori Jlavyan on 5/30/17.
//  Copyright © 2017 Handybook. All rights reserved.
//

import UIKit

class JaldiOrderListRatingCell: UITableViewCell {

    weak var delagate:JaldiOrderListRatingCellDelegate?
    @IBOutlet weak var cosmosView:CosmosView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    //MARK: Actions
    @IBAction func submitAction(_ sender: Any) {
        let rate = cosmosView?.rating ?? 0
      delagate?.orderList(ratingCell: self, didSaveRating: Float(rate))
    }
}
