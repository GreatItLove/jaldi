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
    let guestPasswordUserDefaultKey = "guestPasswordUserDefaultKey"
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
    var guestPassword:String? {
        get {
            return UserDefaults.standard.object(forKey: guestPasswordUserDefaultKey) as? String
        }
        set{
            let userDefaults  = UserDefaults.standard
            userDefaults.setValue(newValue, forKey: guestPasswordUserDefaultKey)
            userDefaults.synchronize()
        }
    }
    
    var guestZip:String? {
        get {
            return UserDefaults.standard.object(forKey: guestZipUserDefaultKey) as? String
        }
        set{
            let userDefaults  = UserDefaults.standard
            userDefaults.setValue(newValue, forKey: guestZipUserDefaultKey)
            userDefaults.synchronize()
        }
    }
    func currentGuestUser() -> JaldiUser {
        let guest = JaldiUser()
        guest.email = self.guestEmail
        guest.password = self.guestPassword
        guest.zip = self.guestZip
        return guest
    }
    func loginAsGuest(guest:JaldiUser) {
      self.guestPassword = guest.password
      self.guestEmail = guest.email
      self.guestZip = guest.zip
      NotificationCenter.default.post(name: NSNotification.Name(rawValue: AppNotifications.loginNotificationName), object: nil)
    }
    
    func logoutProfile(){
        self.guestEmail = nil
        self.guestPassword = ""
    }
    private init(){
    }
}
