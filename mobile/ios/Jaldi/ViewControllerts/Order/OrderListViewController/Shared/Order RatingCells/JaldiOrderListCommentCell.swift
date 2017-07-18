//
//  JaldiOrderListCommentCell.swift
//  Jaldi
//
//  Created by Grigori Jlavyan on 5/30/17.
//  Copyright © 2017 Handybook. All rights reserved.
//

import UIKit

class JaldiOrderListCommentCell: UITableViewCell {

    weak var delagate:JaldiOrderListRatingCellDelegate?
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var commentBorder: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureWith(order:JaldiOrder) {
       commentTextField.text = ""
        self.configureBorder()
    }
    private func configureBorder() {
        commentBorder.layer.cornerRadius = 3
        commentBorder.layer.masksToBounds = true
        commentBorder.clipsToBounds = true
        commentBorder.layer.borderColor = UIColor.lightGray.cgColor
        commentBorder.layer.borderWidth = 1
    }

    //MARK: Actions
    @IBAction func submitAction(_ sender: Any) {
       delagate?.orderList(ratingCell: self, didSaveComment: commentTextField.text)
    }

}
