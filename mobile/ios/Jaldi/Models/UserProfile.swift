//
//  UserProfile.swift
//  Jaldi
//
//  Created by Grigori Jlavyan on 5/2/17.
//  Copyright © 2017 Handybook. All rights reserved.
//

import Foundation
class UserProfile {
    let guestEmailUserDefaultKey = "guestEmailUserDefaultKey"
    let guestZipUserDefaultKey = "guestZipUserDefaultKey"

    static let currentProfile = UserProfile()
    
    var guestEmail:String? {
        get {
            return UserDefaults.standard.object(forKey: guestEmailUserDefaultKey) as? String
        }
        set{
            let userDefaults  = UserDefaults.standard
            userDefaults.setValue(newValue, forKey: guestEmailUserDefaultKey)
            userDefaults.synchronize()
        }
    }
    var guestZip:String? {
        get {
            return UserDefaults.standard.object(forKey: guestEmailUserDefaultKey) as? String
        }
        set{
            let userDefaults  = UserDefaults.standard
            userDefaults.setValue(newValue, forKey: guestEmailUserDefaultKey)
            userDefaults.synchronize()
        }
    }
    func currentGuestUser() -> JaldiOnboardingModel {
        let guest = JaldiOnboardingModel()
        guest.email = self.guestEmail
        guest.zip = self.guestZip
        return guest
    }
    func loginAsGuest(guest:JaldiOnboardingModel) {
      self.guestZip = guest.zip
      self.guestEmail = guest.email
      NotificationCenter.default.post(name: NSNotification.Name(rawValue: AppNotifications.loginNotificationName), object: nil)
    }
    
    func logoutProfile(){
        self.guestEmail = nil
        self.guestZip = ""
    }
    private init(){
    }
}
