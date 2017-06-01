//
//  JaldiPlacePicker.swift
//  Jaldi
//
//  Created by Grigori Jlavyan on 5/16/17.
//  Copyright © 2017 Handybook. All rights reserved.
//

import UIKit
import MapKit
protocol JaldiPlacePickerDelegate: class {
    func placePicker(JaldiPlacePicker:JaldiPlacePicker, didSelect latitude:Double ,longitude:Double )
}
class JaldiPlacePicker: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    private var locationManager: CLLocationManager?
    
    var location: CLLocation?
//    var placemark: MKPlacemark?
    weak var delegate: JaldiPlacePickerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.showsUserLocation = false
        mapView.delegate = self
//        self.addRecognizer()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.zoomIn()
        }
        locationManager = CLLocationManager()
        locationManager?.delegate = self;
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.startUpdatingLocation()
            }
    
    //MARK: GestureRecognizer
    private func addRecognizer(){
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(JaldiPlacePicker.handleTap(gestureRecognizer:)))
        mapView.addGestureRecognizer(gestureRecognizer)
    }
    
    func handleTap(gestureRecognizer: UIGestureRecognizer) {
        let touchPoint = gestureRecognizer.location(in: mapView)
        let newCoordinates = mapView.convert(touchPoint, toCoordinateFrom: mapView)
         mapView.centerCoordinate = newCoordinates
    }
    fileprivate func zoomIn() {
        guard let location = self.location else {
            self.centerWithLocation()
            return
        }
        let region = MKCoordinateRegionMakeWithDistance(
            location.coordinate, 2000, 2000)
        self.mapView.setRegion(region, animated: true)
    }
    private func centerWithLocation() {
        guard let location = locationManager?.location else {
            return
        }
        let region = MKCoordinateRegionMakeWithDistance(
            location.coordinate, 2000, 2000)
        mapView.setRegion(region, animated: true)
    }
    //MARK: Actions
    @IBAction func closeAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func doneAction(_ sender: Any) {
        self.getCurrentLocationAndDismiss()
    }
    @IBAction func currentLocationAction(_ sender: Any) {
        guard let location = locationManager?.location?.coordinate else {
            return
        }
        let region = MKCoordinateRegionMakeWithDistance(
            location, 500, 500)
        mapView.setRegion(region, animated: true)
    }
    
    private func getCurrentLocationAndDismiss() {
        let centerCoordinate = mapView.centerCoordinate
        let getLat: CLLocationDegrees = centerCoordinate.latitude
        let getLon: CLLocationDegrees = centerCoordinate.longitude
        
        self.showHudWithMsg(message: nil)
        let task  = JaldiUpdateLocationTask(latitude: getLat, longitude: getLon)
        task.execute(in: NetworkDispatcher.defaultDispatcher(), taskCompletion: { [weak self] (value) in
            self?.hideHud()
            self?.delegate?.placePicker(JaldiPlacePicker: self!, didSelect: getLat, longitude: getLon)
            self?.dismiss(animated: true, completion: nil)
            
        }) {[weak self] (error, _) in
            self?.hideHud()
            if let error = error {
                if case NetworkErrors.networkMessage(error_: _, message: let message) = error {
                    self?.showAlertWith(title: NSLocalizedString("Error", comment: ""), message: message)
                }else{
                    self?.showAlertWith(title: NSLocalizedString("Error", comment: ""), message: NSLocalizedString("CantUpdateLocation", comment: ""))
                }
            }
            print(error ?? "Error")
        }
    }
  
    
    deinit{
        locationManager?.stopUpdatingLocation()
    }
}
extension JaldiPlacePicker:MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didUpdate
        userLocation: MKUserLocation) {
        mapView.centerCoordinate = userLocation.location!.coordinate
    }
}
extension JaldiPlacePicker:CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if (status == .restricted || status == .denied)  {
            self.showAlertWith(title: "Location Disabled", message: "Please enable location services in the Settings app.")
        }else{
            if (status == .authorizedWhenInUse){
                self.zoomIn()
            }
        }
    }
    func locationManager(_ manager: CLLocationManager,
                                  didUpdateLocations locations: [CLLocation]){
    
    }
}
