//
//  MilisecondDateTransform.swift
//  Jaldi
//
//  Created by Sedrak Dalaloyan on 6/8/17.
//  Copyright © 2017 Handybook. All rights reserved.
//

import Foundation
import ObjectMapper

class MilisecondDateTransform: TransformType {
    typealias Object = Date
    typealias JSON = Int
    
    init() {}
    
    func transformFromJSON(_ value: Any?) -> Date? {
        if let timeInt = value as? Int {
            return Date(timeIntervalSince1970: TimeInterval(timeInt/1000))
        }
        return nil
    }
    
    func transformToJSON(_ value: Date?) -> Int? {
        if let date = value {
            return Int(date.timeIntervalSince1970 * 1000)
        }
        return nil
    }
}
