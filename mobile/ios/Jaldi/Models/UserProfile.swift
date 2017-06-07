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
    let guestDeviceTokenDefaultKey = "guestDeviceTokenDefaultKey"

    static let currentProfile = UserProfile()
    
    var user:JaldiUser?
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
    
    var deviceToken:String? {
        get {
            return UserDefaults.standard.object(forKey: guestDeviceTokenDefaultKey) as? String
        }
        set{
            let userDefaults  = UserDefaults.standard
            userDefaults.setValue(newValue, forKey: guestDeviceTokenDefaultKey)
            userDefaults.synchronize()
        }
    }
    
    func currentGuestUser() -> JaldiUser {
        let guest = JaldiUser.emptyUser()
        guest.email = self.guestEmail
        guest.password = self.guestPassword
        guest.zip = self.guestZip
        return guest
    }
    func loginAsGuest(guest:JaldiUser) {
      self.user = guest
      self.guestPassword = guest.password
      self.guestEmail = guest.email
      self.guestZip = guest.zip
      NotificationCenter.default.post(name: NSNotification.Name(rawValue: AppNotifications.loginNotificationName), object: nil)
    }
    
    func logoutProfile(){
        self.clearToken()
        self.guestEmail = nil
        self.guestPassword = ""
    }
    private func clearToken() {
        var env = Environment.defaultEnvironment()
        env.autToken = nil
    }
    private init(){
    }
    
    func autoLogin(completion: @escaping ((_ success:Bool)->Void)) {
        guard let userName = self.guestEmail,   let password = self.guestPassword else {
            self.clearToken()
            completion(false)
            return
        }
        let task  = JaldiLoginTask(user: userName, password: password)
        task.execute(in: NetworkDispatcher.defaultDispatcher(), taskCompletion: { (value) in
            self.getProfile(completion: completion)
        }) { (error, _) in
            self.clearToken()
            completion(false)
        }
    }
    
    private func getProfile(completion: @escaping ((_ success:Bool)->Void)) {
        let task  = JaldGetProfileTask()
        task.execute(in: NetworkDispatcher.defaultDispatcher(), taskCompletion: { (user) in
            guard let user = user else{
                self.clearToken()
                completion(false)
                return
            }
            user.password = self.guestPassword
            UserProfile.currentProfile.loginAsGuest(guest: user)
            
        }) { (error, _) in
             self.clearToken()
             completion(false)
        }
    }
    
}
