//
//  JaldiAppConstants.swift
//  Jaldi
//
//  Created by Grigori Jlavyan on 5/2/17.
//  Copyright © 2017 Handybook. All rights reserved.
//

import Foundation
import UIKit

struct AppNotifications {
    static let loginNotificationName = "JALDI_APP_LOGIN_NOTIFICATION"
    static let logoutNotificationName = "JALDI_APP_LOG_OUT_NOTIFICATION"
    static let orderUpdatedNotificationName = "JALDI_APP_ORDER_UPDATED_NOTIFICATION"
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
struct AvailablePromoCodes {
    static let promoCodes = ["1001",
                           "1002",
                           "1003",
                           "1004",
                           "1005",
                           "1006",
                           "1007",
                           "1008",
                           "1009",
                           "1010"]
    static func promoCodeIsAvailable(promoCode:String) -> Bool {
        return promoCodes.contains(promoCode)
    }
}
struct AppDateFormats {
    static let weekFormat = "EEEE, MMM d"
    static let timeFormat = "HH:mm a"
    static let appDateFormat = "dd/MM/YYYY HH:mm"
}
struct AppImages {
    static let dumy_profile_pic = UIImage(named:"dummy_user_pic1")!
}
