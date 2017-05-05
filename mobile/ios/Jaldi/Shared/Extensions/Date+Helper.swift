//
//  Date+Helper.swift
//  Jaldi
//
//  Created by Mnats Karakhanyan on 5/5/17.
//  Copyright © 2017 Handybook. All rights reserved.
//

import Foundation
extension Date {
    func dateStringWith(format:String,timeZone:TimeZone = TimeZone.autoupdatingCurrent ) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = timeZone
        return dateFormatter.string(from: self)
    }
}
