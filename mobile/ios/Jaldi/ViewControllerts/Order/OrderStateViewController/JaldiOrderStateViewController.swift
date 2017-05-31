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
     @IBOutlet weak var workerView: JaldiOrderWorkersView!
    @IBOutlet weak var mapView: MKMapView!
    private var locationManager: CLLocationManager?
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var orderTitleLabel: UILabel!
    @IBOutlet weak var milesAwayLabel: UILabel!
    @IBOutlet weak var cloasButton: UIButton!
    var appearance: Appearance = .none
    private var orderState: JaldiOrderState = JaldiOrderState.tidyingUp
    var order: JaldiOrder?
    lazy var formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeStyle = DateFormatter.Style.short
        formatter.dateStyle = DateFormatter.Style.short
        return formatter
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if let order = self.order {
            workerView.configureWith(order: order)
            orderState = order.orderState
        }
        orderStateView.configureWith(orderState: orderState)
        configureTimeAndTitleLabels()
        configureLocationManager()
        self.addOrderPin()
        configureAppearance()
    }
    //MARK: Configuration
    private func configureAppearance() {
        switch appearance {
        case .push:
            let image  = UIImage(named: "backward_arrow_light_gray")
            cloasButton.setImage(image, for: .normal)
        case .present:
            let image  = UIImage(named: "close_button_light_gray")
            cloasButton.setImage(image, for: .normal)
        case .none:
            cloasButton.isHidden = true
        }
    }
    private func addOrderPin() {
        guard  let cureentOrder = order, let latitude = cureentOrder.latitude, let longitude = cureentOrder.longitude else{
            return
        }
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let reportTime = cureentOrder.orderDate ?? Date()
        let formattedTime = formatter.string(from: reportTime)
        
        let annotation = MKPointAnnotation()
        if let type = cureentOrder.type , let hours = cureentOrder.hours {
            annotation.title = "\(type) (\(hours) hours)"
        }else{
        annotation.title = "CLEANING"
        }
        
        annotation.subtitle = formattedTime
        annotation.coordinate = coordinate
        
        mapView.addAnnotation(annotation)
    }

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
        switch appearance {
        case .push:
            self.navigationController?.popViewController(animated: true)
        case .present:
            self.dismiss(animated: true) {
            }
        case .none:
            break
        }
    }
    @IBAction func currentLocationAction(_ sender: Any) {
//        guard let location = locationManager?.location?.coordinate else {
//            return
//        }
        if let location = mapView?.userLocation.coordinate {
          mapView.centerCoordinate = location
        }
        
    }
}
extension JaldiOrderStateViewController:MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didUpdate
        userLocation: MKUserLocation) {
//        mapView.centerCoordinate = userLocation.location!.coordinate
        self.configureDistance()
    }
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !annotation.isKind(of: MKUserLocation.self) else {
            return nil
        }
        let annotationIdentifier = "AnnotationIdentifier"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier)
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
            annotationView!.canShowCallout = true
        }
        else {
            annotationView!.annotation = annotation
        }
        annotationView!.image = UIImage(named: "house_icon")
        return annotationView
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
