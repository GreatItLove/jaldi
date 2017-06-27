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
    let meterToKm = 0.001
    @IBOutlet weak var orderStateView: JaldiOrderStateView!
    @IBOutlet weak var workerView: JaldiOrderWorkersView!
    @IBOutlet weak var mapView: MKMapView!
    private var locationManager: CLLocationManager?
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var orderTitleLabel: UILabel!
    @IBOutlet weak var milesAwayLabel: UILabel!
    @IBOutlet weak var cloasButton: UIButton!
    @IBOutlet weak var contactWorker: UITapGestureRecognizer!
    var appearance: Appearance = .none
    private var orderState: JaldiOrderState = JaldiOrderState.created
    var order: JaldiOrder?
    lazy var formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeStyle = DateFormatter.Style.short
        formatter.dateStyle = DateFormatter.Style.short
        return formatter
    }()
    var timer = Timer()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        workerView.delegate = self
        registerNotifications()
        configureLocationManager()
        displayOrder()
        configureAppearance()
        contactWorker.addTarget(self, action: #selector(showContactAlert))
        scheduledTimerWithTimeInterval()
    }

    private func displayOrder() {
        if let order = self.order {
            workerView.configureWith(order: order)
            orderState = order.orderState
        }
        orderStateView.configureWith(orderState: orderState)
        configureTimeLabel()
        configureTitleLabel()
        mapView.removeAnnotations(mapView.annotations)
        self.addOrderPin()
        if orderState == .enRoute || orderState == .working || orderState == .tidyingUp {
            self.addWorkerPin()
        }
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
        mapView.showAnnotations(mapView.annotations, animated: true)
//        let region = MKCoordinateRegionMakeWithDistance(
//            mapView.region.center, mapView.region.span.latitudeDelta, mapView.region.span.longitudeDelta)
//        mapView.setRegion(region, animated: true)
    }
    
    func scheduledTimerWithTimeInterval(){
        timer = Timer.scheduledTimer(timeInterval: 30, target: self, selector: #selector(self.timerUpdate), userInfo: nil, repeats: true)
    }
    
    func timerUpdate() {
        guard let orderId = order?.orderId else {
            return
        }
        self.reloadOrderData(orderId: orderId)
    }
    
    private func addOrderPin() {
        guard  let cureentOrder = order, let latitude = cureentOrder.latitude, let longitude = cureentOrder.longitude else{
            return
        }
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let reportTime = cureentOrder.orderDate ?? Date()
        let formattedTime = formatter.string(from: reportTime)
        
        let annotation = JaldiPointAnnotation()
        let type = HomeCategoryHeleper.orderTitleFor(homeCategory:cureentOrder.homeCategory)
        if let hours = cureentOrder.hours {
            annotation.title = "\(type) (\(hours) hours)"
        }
        
        annotation.subtitle = formattedTime
        annotation.coordinate = coordinate
        annotation.image = UIImage(named: "house_icon")
        
        mapView.addAnnotation(annotation)
    }
    
    
    private func addWorkerPin() {
        let worker = self.order?.workersList?.first
        let latitude = worker?.user?.latitude
        let longitude = worker?.user?.longitude
        if latitude == nil || latitude == 0 || longitude == nil || longitude == 0 {
            return
        }
        let coordinate = CLLocationCoordinate2D(latitude: latitude!, longitude: longitude!)
        let annotation = JaldiPointAnnotation()
        annotation.title = worker?.user?.name
        annotation.coordinate = coordinate
        annotation.type = "url"
        let imageId = worker?.user?.profileImageId ?? nil
        if imageId != nil {
            annotation.url = Environment.imageBaseUrl + imageId!
        }
        
        mapView.addAnnotation(annotation)
    }

    private func configureLocationManager() {
        mapView.showsUserLocation = true
        mapView.delegate = self
        locationManager = CLLocationManager()
        locationManager?.delegate = self;
        locationManager?.requestWhenInUseAuthorization()
    }
    private func configureTimeLabel(){
        orderTitleLabel.text = NSLocalizedString("OrderStateTitle", comment: "")
        guard let order = self.order , let orderDate = order.orderDate else {
            return
        }
        let endDate  = (order.hours != nil) ? orderDate.add(hours: order.hours!) : orderDate
        let startTimeStr = orderDate.dateStringWith(format: "HH:mm a")
        let endTimeTimeStr = endDate.dateStringWith(format: "HH:mm a")
        timeLabel.text = "\(startTimeStr) - \(endTimeTimeStr)"
    }
    private func configureTitleLabel(){
        guard let order = self.order  else {
            return
        }
        orderTitleLabel.text = HomeCategoryHeleper.orderTitleFor(homeCategory:order.homeCategory)
    }
    
    fileprivate func configureDistance(){
        guard let latitude = self.order?.latitude, let longitude = self.order?.longitude else {
            return
        }
        let orderLocation =  CLLocation(latitude: latitude, longitude: longitude)
        var distance: Double = 0
        if orderState == .enRoute || orderState == .working || orderState == .tidyingUp {
            let worker = self.order?.workersList?.first
            let workerLatitude = worker?.user?.latitude
            let workerLlongitude = worker?.user?.longitude
            if workerLatitude == nil || workerLatitude == 0 || workerLlongitude == nil || workerLlongitude == 0 {
                return
            }
            let workerCoordinate = CLLocation(latitude: workerLatitude!, longitude: workerLlongitude!)
            distance = orderLocation.distance(from: workerCoordinate)
            
        } else {
            if let userLocation = mapView.userLocation.location {
                distance = orderLocation.distance(from: userLocation)
            } else {
                return
            }
        }
        let km = distance * self.meterToKm
        if km > 1 {
            milesAwayLabel.text = "\(String(format: "%.2f", km)) KM AWAY "
        } else {
            milesAwayLabel.text = "\(String(format: "%.f", distance)) METERS AWAY"
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
        if let location = mapView?.userLocation.coordinate {
//          mapView.centerCoordinate = location
            let region = MKCoordinateRegionMakeWithDistance(
                location, 500, 500)
            mapView.setRegion(region, animated: true)
            
        }
    }
    //MARK: Contact
    public func showContactAlert() {
        let contactAlert = UIAlertController(title: "Contact", message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        contactAlert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
        contactAlert.addAction(UIAlertAction(title: "Call", style: UIAlertActionStyle.default, handler: { (action: UIAlertAction!) -> () in
            self.callWorker()
        }))
        contactAlert.addAction(UIAlertAction(title: "Message", style: UIAlertActionStyle.default, handler: { (action: UIAlertAction!) -> () in
            self.messageWorker()
        }))
        self.present(contactAlert, animated: true, completion: nil)
    }
    private func callWorker() {
        let worker = order?.workersList?.first
        guard let phone = worker?.user?.phone else{
            return
        }
        guard let url = NSURL(string: "tel://\(phone)") else{
            return
        }
        UIApplication.shared.openURL(url as URL)
    }
    private func messageWorker() {
        let worker = order?.workersList?.first
        guard let phone = worker?.user?.phone else{
            return
        }
        guard let url = NSURL(string: "sms://\(phone)") else{
            return
        }
        UIApplication.shared.openURL(url as URL)
    }
    
    private func registerNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(orderUpdatedNotification(_:)), name: NSNotification.Name(rawValue: AppNotifications.orderUpdatedNotificationName), object: nil)
    }
    
    func orderUpdatedNotification(_ notification: Notification) {
        guard let orderId = order?.orderId, let userInfo = notification.userInfo else {
            return
        }
        let updatedOrderId = userInfo["orderId"] as! Int
        if orderId == updatedOrderId {
            reloadOrderData(orderId: orderId)
        }
    }
    
    func reloadOrderData(orderId:Int) {
        let task  = JaldiOrderByIdTask(orderId: orderId)
        task.execute(in: NetworkDispatcher.defaultDispatcher(), taskCompletion: {(newOrder) in
            UIApplication.shared.keyWindow?.rootViewController?.hideHud()
            guard let _ = newOrder else {
                return
            }
            self.order = newOrder
            self.displayOrder()
        }) {  (error, _) in
            UIApplication.shared.keyWindow?.rootViewController?.hideHud()
            print("error")
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        timer.invalidate()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
extension JaldiOrderStateViewController:MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didUpdate
        userLocation: MKUserLocation) {
//        mapView.centerCoordinate = userLocation.location!.coordinate
        self.configureDistance()
    }
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if !(annotation is JaldiPointAnnotation) {
            return nil
        }
        let annotationView = MKAnnotationView()
        annotationView.annotation = annotation
        annotationView.canShowCallout = true
        let jaldiAnotation = annotation as? JaldiPointAnnotation
        if jaldiAnotation?.type == "url" {
            let imageView = UIImageView(frame: CGRect(x:0, y:0, width:25, height:25))
            let url = jaldiAnotation?.url
            if url != nil {
                imageView.downloadedFrom(link: jaldiAnotation!.url!)
            } else {
                imageView.image = AppImages.dumy_profile_pic
            }
            
            imageView.layer.cornerRadius = imageView.layer.frame.size.width / 2
            imageView.layer.masksToBounds = true
            annotationView.addSubview(imageView)
        } else {
            annotationView.image = jaldiAnotation?.image
        }
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

extension JaldiOrderStateViewController:JaldiOrderStateViewControllerDelegate {
    func orderStateViewControllerDidCancelOrder() {
        guard let orderId = self.order?.orderId else {
            return
        }
        showCanceOrderAlert(orderId: orderId)
    }
    
    fileprivate func showCanceOrderAlert(orderId:Int)  {
        let deletAlert = UIAlertController(title: "", message: "Are you sure you want to cancel this order?", preferredStyle: UIAlertControllerStyle.alert)
        deletAlert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
        deletAlert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.default, handler: { (action: UIAlertAction!) -> () in
            self.cacelOrderById(orderId: orderId)
        }))
        self.present(deletAlert, animated: true, completion: nil)
    }
    private func cacelOrderById(orderId: Int) {
        let task  = JaldiOrderCancelTask(orderId: orderId)
        task.execute(in: NetworkDispatcher.defaultDispatcher(), taskCompletion: {(success) in
         self.setOrderCanceledFor(orderId: orderId)
        }) {  (error, _) in
            print("error")
        }
    }
    private func setOrderCanceledFor(orderId: Int) {
        guard let currentOrder = order else {
            return
        }
        if currentOrder.orderId == orderId {
            currentOrder.status = JaldiStatus.canceled.rawValue
            workerView.configureWith(order: currentOrder)
        }
    }
}

