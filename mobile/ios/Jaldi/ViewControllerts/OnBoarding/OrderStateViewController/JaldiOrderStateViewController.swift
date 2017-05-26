//
//  JaldiOrderStateViewController.swift
//  Jaldi
//
//  Created by Grigori Jlavyan on 5/25/17.
//  Copyright © 2017 Handybook. All rights reserved.
//

import UIKit
import MapKit
class JaldiOrderStateViewController: UIViewController {

    let meterToMiles = 0.000621371
    @IBOutlet weak var orderStateView: JaldiOrderStateView!
    @IBOutlet weak var mapView: MKMapView!
    private var locationManager: CLLocationManager?
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var orderTitleLabel: UILabel!
    @IBOutlet weak var milesAwayLabel: UILabel!
    private var orderState: JaldiOrderState = JaldiOrderState.tidyingUp
    var order: JaldiOrder?
    override func viewDidLoad() {
        super.viewDidLoad()
        orderStateView.configureWith(orderState: orderState)
        configureTimeAndTitleLabels()
        configureLocationManager()
    }
    //MARK: Configuration
    private func configureLocationManager() {
        mapView.showsUserLocation = true
        mapView.delegate = self
        locationManager = CLLocationManager()
        locationManager?.delegate = self;
        locationManager?.requestWhenInUseAuthorization()
    }
    private func configureTimeAndTitleLabels(){
        orderTitleLabel.text = NSLocalizedString("OrderStateTitle", comment: "")
        guard let order = self.order , let orderDate = order.orderDate else {
            return
        }
        let endDate  = (order.hours != nil) ? orderDate.add(hours: order.hours!) : orderDate
        let startTimeStr = orderDate.dateStringWith(format: "HH:mm a")
        let endTimeTimeStr = endDate.dateStringWith(format: "HH:mm a")
        timeLabel.text = "\(startTimeStr) - \(endTimeTimeStr)"
    }
    fileprivate func configureDistance(){
        guard let latitude = self.order?.latitude, let longitude = self.order?.longitude else {
            return
        }
        let orderLocation =  CLLocation(latitude: latitude, longitude: longitude)
        if let userLocation = mapView.userLocation.location {
            let distance = userLocation.distance(from: orderLocation)
            let miles = distance * self.meterToMiles
            if miles > 1 {
                milesAwayLabel.text = "\(String(format: "%.2f", miles)) MILES AWAY "
            }else{
                milesAwayLabel.text = "\(String(format: "%.f", distance)) METERS AWAY"
            }
        }
    }
    //MARK: Actions
    @IBAction func closeAction(_ sender: Any) {
        self.dismiss(animated: true) {
        }
    }
}
extension JaldiOrderStateViewController:MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didUpdate
        userLocation: MKUserLocation) {
        mapView.centerCoordinate = userLocation.location!.coordinate
        self.configureDistance()
    }
}
extension JaldiOrderStateViewController:CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if (status == .restricted || status == .denied)  {
            self.showAlertWith(title: "Location Disabled", message: "Please enable location services in the Settings app.")
        }else{
            if (status == .authorizedWhenInUse){
                mapView.showsUserLocation = true
            }
        }
    }
}

