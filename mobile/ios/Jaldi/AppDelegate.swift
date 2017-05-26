//
//  AppDelegate.swift
//  Handy
//
//  Created by Grigori Jlavyan on 4/29/17.
//  Copyright © 2017 Handybook. All rights reserved.
//

import UIKit
import CoreLocation
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var homeViewController: JaldiHomeViewController?
    var loginNaveController: UINavigationController?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
//        UserProfile.currentProfile.logoutProfile()
        self.registerNotofications()
        self.autoLogin()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    //NARK: Root View Controller
    private func autoLogin() {
        
        let guest =  UserProfile.currentProfile.currentGuestUser()
        if guest.canLoginAsGuest(){
            self.setSplashScreenViewController()
            UserProfile.currentProfile.autoLogin(completion: { (success) in
                if !success {
                    self.setGuestViewController()
                }
            })
        }else{
            self.setGuestViewController()
        }
    }
    private func setHomeViewController() {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        let onboardingViewControllerViewController = storyboard.instantiateViewController(withIdentifier: "JaldiHomeViewController") as? JaldiHomeViewController
        let homeNavController  = UINavigationController(rootViewController: onboardingViewControllerViewController!)
        homeNavController.isNavigationBarHidden = true
        
        self.window?.rootViewController = homeNavController
    }
    private func setSplashScreenViewController() {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let splashScreenViewController = storyboard.instantiateViewController(withIdentifier: "JaldiSplashScreenViewController") as? JaldiSplashScreenViewController
        self.window?.rootViewController = splashScreenViewController
    }
    
    private func setGuestViewController() {
        let storyboard: UIStoryboard = UIStoryboard(name: "Login", bundle: nil)
        
        let onboardingViewControllerViewController = storyboard.instantiateViewController(withIdentifier: "JaldiRegistrationViewController") as? JaldiRegistrationViewController
        self.loginNaveController  = UINavigationController(rootViewController: onboardingViewControllerViewController!)
        self.loginNaveController?.isNavigationBarHidden = true
        self.window?.rootViewController = self.loginNaveController
    }
    
    //MARK: Notification
    private func registerNotofications() {
        NotificationCenter.default.addObserver(self, selector: #selector(AppDelegate.loginNotification(_:)), name: NSNotification.Name(rawValue: AppNotifications.loginNotificationName), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(AppDelegate.logoutNotification(_:)), name: NSNotification.Name(rawValue: AppNotifications.logoutNotificationName), object: nil)
         NotificationCenter.default.addObserver(self, selector: #selector(AppDelegate.zipCodeIsChangedNotification(_:)), name: NSNotification.Name(rawValue: AppNotifications.zipCodeIsChangedNotificationName), object: nil)
    }
    
    func loginNotification(_ notification: Notification) {
        self.setHomeViewController()
    }
    
    func logoutNotification(_ notification: Notification) {
        self.setGuestViewController()
    }
    func zipCodeIsChangedNotification(_ notification: Notification) {
        self.setHomeViewController()
    }

}

