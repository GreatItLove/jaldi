//
//  JaldiOnBoradingListViewController.swift
//  Jaldi
//
//  Created by Grigori Jlavyan on 5/2/17.
//  Copyright © 2017 Handybook. All rights reserved.
//

import UIKit

class JaldiOnBoradingListViewController: UIViewController {

    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var theTableView: UITableView!
    var services: [JaldiService] = []
    
    var  homeCategory:HomeCategory?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadServices()
        configureTabelView()
    }
    

    //MARK: Configuration
    private func loadServices() {
        guard let category = homeCategory else {
            return
        }
        services =  JaldiServiceHeleper.servicesFor(category: category)
        theTableView.reloadData()
    }
    private func configureTabelView() {
        theTableView.rowHeight = 90
    }
    
    //MARK: Actions
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func signInAction(_ sender: Any) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Login", bundle: nil)
        let signInViewController = storyboard.instantiateViewController(withIdentifier: "JaldiSignInViewController") as? JaldiSignInViewController
        let navController = UINavigationController(rootViewController: signInViewController!)
        navController.isNavigationBarHidden = true
        self.present(navController, animated: true, completion: nil)
        
    }
}

// MARK: UITableView
extension JaldiOnBoradingListViewController: UITableViewDelegate,UITableViewDataSource {
   
    func numberOfSections(in tableView: UITableView) -> Int{
        return (services.count > 1 ? 1: 0)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  services.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let simpleTableIdentifier = "JaldiOnBoradingListViewCell"
        let cell:JaldiOnBoradingListViewCell = tableView.dequeueReusableCell(withIdentifier: simpleTableIdentifier, for: indexPath) as! JaldiOnBoradingListViewCell
        let service = services[indexPath.row]
        cell.configureWith(service: service)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?{
        
        let simpleTableIdentifier = "JaldiOnBoradingListViewHeaderCell"
        let cell:JaldiOnBoradingListViewHeaderCell! = tableView.dequeueReusableCell(withIdentifier: simpleTableIdentifier) as? JaldiOnBoradingListViewHeaderCell
        if let category = homeCategory {
            cell.configureWith(category: category)
        }
        return cell!;
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       let service = services[indexPath.row]
        self.showBookingDetailsViewController(service: service)
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 115
    }
    
    fileprivate func showBookingDetailsViewController(service:JaldiService) {
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Booking", bundle: nil)
        if let bookingDetailsViewController = storyboard.instantiateViewController(withIdentifier: "JaldiBookingDetailsViewController") as? JaldiBookingDetailsViewController{
            bookingDetailsViewController.bookingObject = BookingHelper.bookingObjectFor(service: service)
            let navController = UINavigationController(rootViewController: bookingDetailsViewController)
            navController.isNavigationBarHidden = true
            self.present(navController, animated: true, completion: nil)
        }
    }

}
