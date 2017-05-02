//
//  JaldiAppConstants.swift
//  Jaldi
//
//  Created by Grigori Jlavyan on 5/2/17.
//  Copyright © 2017 Handybook. All rights reserved.
//

import Foundation
struct AppNotifications {
    static let loginNotificationName = "JALDI_APP_LOGIN_NOTIFICATION"
    static let logoutNotificationName = "JALDI_APP_LOG_OUT_NOTIFICATION"
    static let zipCodeIsChangedNotificationName = "JALDI_APP_ZIP_CODE_IS_CHANGED_NOTIFICATION"
}
struct AvailableZipCodes {
    static let zipCodes = ["1001",
                           "1002",
                           "1003",
                           "1004",
                           "1005",
                           "1006",
                           "1007",
                           "1008",
                           "1009",
                           "1010"]
    static func zipCodeIsAvailable(zipCode:String) -> Bool {
     return zipCodes.contains(zipCode)
    }
}
