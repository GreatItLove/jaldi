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
        locationManager?.requestWhenInUseAuthorization()
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
        self.getCurrentLocationAndDismiss()
    }
    
    private func getCurrentLocationAndDismiss() {
        let centerCoordinate = mapView.centerCoordinate
        let getLat: CLLocationDegrees = centerCoordinate.latitude
        let getLon: CLLocationDegrees = centerCoordinate.longitude
        self.delegate?.placePicker(JaldiPlacePicker: self, didSelect: getLat, longitude: getLon)
        self.dismiss(animated: true, completion: nil)
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
}
