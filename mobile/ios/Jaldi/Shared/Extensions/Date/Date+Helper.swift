//
//  Date+Helper.swift
//  Jaldi
//
//  Created by Grigori Jlavyan on 5/5/17.
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
    func add(hours:Int) -> Date {
        let calendar = Calendar.current
        return  calendar.date(byAdding: .hour, value: hours, to: self)!
    }
    static var appDateFormater:DateFormatter{
        get {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = AppDateFormats.appDateFormat
            return dateFormatter
        }
    }
    
}
