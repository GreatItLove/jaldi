//
//  JaldiHomeViewController.swift
//  Jaldi
//
//  Created by Grigori Jlavyan on 5/2/17.
//  Copyright © 2017 Handybook. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
class JaldiHomeViewController: UIViewController {
    
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var theCollectionView: UICollectionView!
    let  allCategories = HomeCategory.allCategories
    private var geocoder: CLGeocoder =  CLGeocoder()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configuration()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.configureAddress()
    }
    
    //MARK: Configuration
    private func configuration() {
        self.configureCollectionView()
        
    }
    private func showPlacePickerIfNeeded() {
        guard let _  = UserProfile.currentProfile.user?.latitude , let _  = UserProfile.currentProfile.user?.longitude else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.presentPlacePicker()
            }
            return
        }
    }
    fileprivate func configureAddress() {
        guard let lat  = UserProfile.currentProfile.user?.latitude ,let lon  = UserProfile.currentProfile.user?.longitude  else{
          addressLabel.text = ""
            return
        }
        let location  = CLLocation(latitude: lat, longitude: lon)
        self.geocoder.reverseGeocodeLocation(location, completionHandler:
            {(placemarks, error) in
                if (placemarks?.count)! > 0
                {
                    let placemark:CLPlacemark = placemarks![0]
                    if let address = placemark.name {
                    UserProfile.currentProfile.user?.address = address
                    self.addressLabel.text = "Not in: \(address)?"
                    }
                    if let country = placemark.country {
                        UserProfile.currentProfile.user?.country = country
                    }
                    if let city = placemark.locality {
                        UserProfile.currentProfile.user?.city = city
                    }
                }
        })
        
    }
    private func configureCollectionView() {
        let collectionViewLayout = theCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let gab =  (self.view.frame.size.width - 2 * 130) / 3
        collectionViewLayout.sectionInset = UIEdgeInsetsMake(gab, gab, 0, gab)
        collectionViewLayout.minimumLineSpacing = 20
    }

    //MARK: Actions
    @IBAction func announcementAction(_ sender: Any) {
//        self.presentAnnouncements()
        self.presentOrders()
    }
    
    @IBAction func signInAction(_ sender: Any) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Login", bundle: nil)
        let signInViewController = storyboard.instantiateViewController(withIdentifier: "JaldiSignInViewController") as? JaldiSignInViewController
        let navController = UINavigationController(rootViewController: signInViewController!)
        navController.isNavigationBarHidden = true
        self.present(navController, animated: true, completion: nil)
    }
    @IBAction func changeAddressAction(_ sender: Any) {
       self.presentPlacePicker()
    }
    func presentPlacePicker() {
        let storyboard: UIStoryboard = UIStoryboard(name: "Login", bundle: nil)
        let placePicker = storyboard.instantiateViewController(withIdentifier: "JaldiPlacePicker") as? JaldiPlacePicker
        placePicker?.delegate = self
        if let lat  = UserProfile.currentProfile.user?.latitude , let lon  = UserProfile.currentProfile.user?.longitude{
            let location  = CLLocation(latitude: lat, longitude: lon)
            placePicker?.location = location
        }
        self.present(placePicker!, animated: true, completion: nil)
    }
    private func presentAnnouncements() {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let announcementViewController = storyboard.instantiateViewController(withIdentifier: "JaldiAnnouncementViewController") as? JaldiAnnouncementViewController
        self.present(announcementViewController!, animated: true, completion: nil)
    }
    private func presentOrders() {
        let storyboard: UIStoryboard = UIStoryboard(name: "Order", bundle: nil)
        let ordersViewController = storyboard.instantiateViewController(withIdentifier: "JaldiOrderListViewController") as? JaldiOrderListViewController
        let navController = UINavigationController(rootViewController: ordersViewController!)
        navController.isNavigationBarHidden = true
        self.present(navController, animated: true, completion: nil)
    }

}

extension JaldiHomeViewController: UICollectionViewDelegate,UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int{
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return allCategories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cellIdentifier =  "JaldiHomeCollectionViewCell"
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? JaldiHomeCollectionViewCell {
            let category:HomeCategory = allCategories[indexPath.row]
            cell.configureWith(category: category)
            return cell
        } else {
            return UICollectionViewCell ()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (self.checkUserLocation()) {
        let category:HomeCategory = allCategories[indexPath.row]
        self.navigateTo(category:category)
        }
    }
    
    //MARK: navigate to Carpenter, Electrician, Mason, Painter, Plumber, Ac Technical
    fileprivate func navigateTo(category:HomeCategory) {
        switch category {
        case .homeCleaning,.mason,.acTechnical,.carpenter,.painter:
            self.showBookingDetailsViewController(category: category)
        case .electrician,.plumber:
           self.showOnBoradingListViewFor(category: category)
        }
    }

    fileprivate func showOnBoradingListViewFor(category:HomeCategory) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let onBoradingListViewController = storyboard.instantiateViewController(withIdentifier: "JaldiOnBoradingListViewController") as? JaldiOnBoradingListViewController
        onBoradingListViewController?.homeCategory = category
        self.navigationController?.pushViewController(onBoradingListViewController!, animated: true)
    }
    
    fileprivate func showBookingDetailsViewController(category:HomeCategory) {
        guard let service =  JaldiServiceHeleper.serviceFor(category: category) else {
            return
        }
        let storyboard: UIStoryboard = UIStoryboard(name: "Booking", bundle: nil)
        if let bookingDetailsViewController = storyboard.instantiateViewController(withIdentifier: "JaldiBookingDetailsViewController") as? JaldiBookingDetailsViewController{
            bookingDetailsViewController.bookingObject = BookingHelper.bookingObjectFor(service: service)
            let navController = UINavigationController(rootViewController: bookingDetailsViewController)
            navController.isNavigationBarHidden = true
            self.present(navController, animated: true, completion: nil)
        }
    }
    private func checkUserLocation() -> Bool {
        guard let _ = UserProfile.currentProfile.user?.latitude, let _ = UserProfile.currentProfile.user?.longitude else {
            let alert = UIAlertController(title: title, message: NSLocalizedString("CooseYourLocationMessage", comment: ""), preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("Ok", comment: ""), style: UIAlertActionStyle.default, handler: { (alert: UIAlertAction!) in self.presentPlacePicker() }))
            self.present(alert, animated: true, completion: nil)
            return false
        }
        return true
    }
}

extension JaldiHomeViewController: JaldiPlacePickerDelegate {
    func placePicker(JaldiPlacePicker:JaldiPlacePicker, didSelect latitude:Double ,longitude:Double ) {
        if let user  = UserProfile.currentProfile.user {
            user.latitude = latitude
            user.longitude = longitude
            self.configureAddress()
        }
    }
}
