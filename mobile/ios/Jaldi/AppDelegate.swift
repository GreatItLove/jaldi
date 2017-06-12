//
//  AppDelegate.swift
//  Handy
//
//  Created by Grigori Jlavyan on 4/29/17.
//  Copyright © 2017 Handybook. All rights reserved.
//

import UIKit
import CoreLocation
import UserNotifications
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var homeViewController: JaldiHomeViewController?
    var loginNaveController: UINavigationController?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
//        UserProfile.currentProfile.logoutProfile()
        self.registerNotofications()
        self.autoLogin()
        self.registerForPushNotifications(application: application)
        return true
    }
    
    // Called when APNs has assigned the device a unique token
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        // Convert token to string
        let deviceTokenString = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
        
        print("APNs device token: \(deviceTokenString)")
        
        // Persist it in your backend in case it's new
        UserProfile.currentProfile.deviceToken = deviceTokenString
        updateDeviceToken()
    }
    
    // Called when APNs failed to register the device for push notifications
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        // Print the error to console (you should alert the user that registration failed)
        print("APNs registration failed: \(error)")
    }
    
    // Push notification received
    func application(_ application: UIApplication, didReceiveRemoteNotification data: [AnyHashable : Any]) {
        // Print notification payload data
        let orderId = data["orderId"]
        let orderStatus = data["orderStatus"]
        if String(describing: orderStatus) == "FINISHED" {
            self.showMyOrdersController()
            return
        }
        if ( application.applicationState == UIApplicationState.inactive || application.applicationState == UIApplicationState.background ){
            if let _ = orderId {
                UIApplication.shared.keyWindow?.rootViewController?.showHudWithMsg(message: nil)
                let task  = JaldiOrderByIdTask(orderId: orderId as! Int)
                task.execute(in: NetworkDispatcher.defaultDispatcher(), taskCompletion: {(order) in
                    UIApplication.shared.keyWindow?.rootViewController?.hideHud()
                    guard let _ = order else {
                        return
                    }
                    self.showOrderStateController(order: order!)
                }) {  (error, _) in
                    UIApplication.shared.keyWindow?.rootViewController?.hideHud()
                    print("error")
                }
            }
        }else{
            if let _ = orderId {
                NotificationCenter.default.post(name: Notification.Name(rawValue: AppNotifications.orderUpdatedNotificationName), object: nil, userInfo: ["orderId": orderId!])
            }
            print("opened from a push notification when the app was on foreground")
        }
        print("Push notification received: \(data)")
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
    
    func registerForPushNotifications(application: UIApplication) {
            // iOS 10 support
        if #available(iOS 10, *) {
            UNUserNotificationCenter.current().requestAuthorization(options:[.badge, .alert, .sound]){ (granted, error) in }
            application.registerForRemoteNotifications()
        }
            // iOS 9 support
        else if #available(iOS 9, *) {
            UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil))
            UIApplication.shared.registerForRemoteNotifications()
        }
            // iOS 8 support
//        else if #available(iOS 8, *) {
//            UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil))
//            UIApplication.shared.registerForRemoteNotifications()
//        }
            // iOS 7 support
//        else {  
//            application.registerForRemoteNotifications(matching: [.badge, .sound, .alert])
//        }
    }
    
    private func showOrderStateController(order: JaldiOrder) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Order", bundle: nil)
        let orderStateViewController = storyboard.instantiateViewController(withIdentifier: "JaldiOrderStateViewController") as? JaldiOrderStateViewController
        orderStateViewController?.order = order
        orderStateViewController?.appearance = .present
        if let topController = UIApplication.shared.keyWindow?.rootViewController {
            topController.dismiss(animated: false, completion: nil)
            topController.present(orderStateViewController!, animated: true, completion: nil)
        }
    }
    
    private func showMyOrdersController() {
        let storyboard: UIStoryboard = UIStoryboard(name: "Order", bundle: nil)
        let ordersViewController = storyboard.instantiateViewController(withIdentifier: "JaldiOrderListViewController") as? JaldiOrderListViewController
        let navController = UINavigationController(rootViewController: ordersViewController!)
        navController.isNavigationBarHidden = true
        if let topController = UIApplication.shared.keyWindow?.rootViewController {
            topController.dismiss(animated: false, completion: nil)
            topController.present(navController, animated: true, completion: nil)
        }
    }
    
    public func updateDeviceToken() {
        guard let token = UserProfile.currentProfile.deviceToken else {
            return
        }
        let task  = JaldiUpdateTokenTask(token: token)
        task.execute(in: NetworkDispatcher.defaultDispatcher(), taskCompletion: {(response) in
        }) {  (error, _) in
            print("error")
        }
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

