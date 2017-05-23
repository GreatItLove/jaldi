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
    func placePicker(JaldiPlacePicker:JaldiPlacePicker, didSelect address:String)
}
class JaldiPlacePicker: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    var placemark: MKPlacemark?
    weak var delegate: JaldiPlacePickerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.showsUserLocation = false
        mapView.delegate = self
        self.addRecognizer()
        self.zoomIn()
    }
    
    //MARK: GestureRecognizer
    private func addRecognizer(){
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(JaldiPlacePicker.handleTap(gestureRecognizer:)))
        mapView.addGestureRecognizer(gestureRecognizer)
    }
    
    func handleTap(gestureRecognizer: UIGestureRecognizer) {
        let touchPoint = gestureRecognizer.location(in: mapView)
        let newCoordinates = mapView.convert(touchPoint, toCoordinateFrom: mapView)
        if let _ =  placemark {
          mapView.removeAnnotation(placemark!)
        }
        let getLat: CLLocationDegrees = newCoordinates.latitude
        let getLon: CLLocationDegrees = newCoordinates.longitude
        let location  = CLLocation(latitude: getLat, longitude: getLon)
        CLGeocoder().reverseGeocodeLocation(location, completionHandler:
            {(placemarks, error) in
                if (placemarks?.count)! > 0 {
                    let topResult:CLPlacemark = placemarks![0];
                    self.placemark = MKPlacemark(placemark: topResult)
                    let region = MKCoordinateRegionMakeWithDistance(
                        location.coordinate, 2000, 2000)
                    self.mapView.setRegion(region, animated: true);
                    self.mapView.addAnnotation(self.placemark!);
                }
        })
   
    }
   private func zoomIn() {
        guard let location = mapView.userLocation.location else {
            return
        }
        let region = MKCoordinateRegionMakeWithDistance(
        location.coordinate, 2000, 2000)
        mapView.setRegion(region, animated: true)
    }
    //MARK: Actions
    @IBAction func closeAction(_ sender: Any) {
        if let _ = self.placemark , let address = self.placemark?.name {
            delegate?.placePicker(JaldiPlacePicker: self, didSelect: address)
         }
        self.dismiss(animated: true, completion: nil)
    }
    
}
extension JaldiPlacePicker:MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didUpdate
        userLocation: MKUserLocation) {
        mapView.centerCoordinate = userLocation.location!.coordinate
    }
}
