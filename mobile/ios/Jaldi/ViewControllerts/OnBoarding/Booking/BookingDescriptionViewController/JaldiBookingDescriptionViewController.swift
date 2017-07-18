//
//  JaldiBookingDescriptionViewController.swift
//  Jaldi
//
//  Created by Grigori Jlavyan on 5/4/17.
//  Copyright © 2017 Handybook. All rights reserved.
//

import UIKit

class JaldiBookingDescriptionViewController: UIViewController,BookingNavigation {

    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var theTableView: UITableView!
    @IBOutlet weak var changeButtonBottomConstraint: NSLayoutConstraint!
    var bookingObject:BookingObject?
    var curretScreen: BookingScreen = BookingScreen.desc
    var selectedTextView: UITextView?
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureBookingProgress()
        addRecognizer()
        addNotification()
    }
    //MARK: Confifuration
    private func configureTableView() -> Void {
        theTableView.rowHeight = 115
    }
   
    //MARK: Actions
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func nextAction(_ sender: Any) {
        self.selectedTextView?.resignFirstResponder()
        self.showNextScreen()
    }
    
    private func showNextScreen() {
        if !self.isLastScreen() {
            if let nextViewController = self.nextScreen() {
                self.navigationController?.pushViewController(nextViewController, animated: true)
            }
        }
    }
    //MARK: GestureRecognizer
    private func addRecognizer(){
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(JaldiBookingDescriptionViewController.handleTap(gestureRecognizer:)))
        view.addGestureRecognizer(gestureRecognizer)
    }
    func handleTap(gestureRecognizer: UIGestureRecognizer) {
        self.selectedTextView?.resignFirstResponder()
    }
    
    //MARK: Notification
    private func addNotification(){
        NotificationCenter.default.addObserver(self, selector: #selector(JaldiBookingDescriptionViewController.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(JaldiBookingDescriptionViewController.keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    private func removeNotification(){
        NotificationCenter.default.removeObserver(self)
    }
    
    func keyboardWillShow(_ notification:Notification) {
        let info = (notification as NSNotification).userInfo!
        
        let kbFrame = info[UIKeyboardFrameEndUserInfoKey]
        let animationDuration = (info[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue
        let keyboardFrame = (kbFrame as? NSValue)?.cgRectValue
        let height = keyboardFrame!.size.height
        
        self.changeButtonBottomConstraint.constant = height
        
        UIView.animate(withDuration: animationDuration!, animations: { () -> Void in
            self.view.layoutIfNeeded()
        }, completion: { (finished) -> Void in
            
        })
    }
    
    func keyboardWillHide(_ notification:Notification) {
        let info = (notification as NSNotification).userInfo!
        let animationDuration = (info[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue
        
        self.changeButtonBottomConstraint.constant = 0
        UIView.animate(withDuration: animationDuration!, animations: { () -> Void in
            self.view.layoutIfNeeded()
        }, completion: { (finished) -> Void in
        })
    }
    
    deinit{
        removeNotification()
    }

}

// MARK: UITableView
extension JaldiBookingDescriptionViewController: UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int{
        return (bookingObject != nil  ? 1: 0)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let simpleTableIdentifier = "JaldiBookingDescriptionTableCell"
        let cell:JaldiBookingDescriptionTableCell = tableView.dequeueReusableCell(withIdentifier: simpleTableIdentifier, for: indexPath) as! JaldiBookingDescriptionTableCell
        if let bookingObject = bookingObject {
          cell.configureWith(bookingObject: bookingObject)
            cell.delegate = self
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?{
        
        let simpleTableIdentifier = "JaldiBookingDetailsHeaderCellDescription"
        let cell:JaldiBookingDetailsHeaderCell! = tableView.dequeueReusableCell(withIdentifier: simpleTableIdentifier) as? JaldiBookingDetailsHeaderCell
        cell.configureWith(title: BookingHelper.defaultTitle)
        return cell;
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
}
extension JaldiBookingDescriptionViewController: JaldiBookingDescriptionTableCellDelegate {

    func bookingDescription(cell:JaldiBookingDescriptionTableCell,
                            didBeginEditing textView:UITextView) {
        selectedTextView = textView
    }
    
    func bookingDescription(cell:JaldiBookingDescriptionTableCell,
                            didEndEditing textView:UITextView){
        bookingObject?.description = textView.text
    }
}

