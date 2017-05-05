//
//  JaldiBookingContactInfoViewController.swift
//  Jaldi
//
//  Created by Grigori Jlavyan on 5/5/17.
//  Copyright © 2017 Handybook. All rights reserved.
//

import UIKit

class JaldiBookingContactInfoViewController: UIViewController,BookingNavigation {

    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var changeButtonBottomConstraint: NSLayoutConstraint!
    var bookingObject:BookingObject?
    var curretScreen: BookingScreen = BookingScreen.contactInfo
    var selectedTextView: UITextView?
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBookingProgress()
        addNotification()
    }
    //MARK: Confifuration
   
    
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
