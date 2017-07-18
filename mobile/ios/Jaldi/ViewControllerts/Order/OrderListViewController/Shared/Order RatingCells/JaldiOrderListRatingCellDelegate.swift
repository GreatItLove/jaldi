//
//  JaldiOrderListRatingCellDelegate.swift
//  Jaldi
//
//  Created by Grigori Jlavyan on 5/31/17.
//  Copyright © 2017 Handybook. All rights reserved.
//

import Foundation
import UIKit
protocol JaldiOrderListRatingCellDelegate: class {
    func orderList(ratingCell:UITableViewCell, didSaveComment comment:String?)
    func orderList(ratingCell:UITableViewCell, didSaveRating rating:Float)
}
