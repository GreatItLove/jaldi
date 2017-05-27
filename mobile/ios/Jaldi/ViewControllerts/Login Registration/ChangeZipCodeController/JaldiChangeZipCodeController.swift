//
//  JaldiChangeZipCodeController.swift
//  Jaldi
//
//  Created by Grigori Jlavyan on 5/2/17.
//  Copyright © 2017 Handybook. All rights reserved.
//

import UIKit

class JaldiChangeZipCodeController: UIViewController {
    @IBOutlet weak var zipTextField: UITextField!
    @IBOutlet weak var changeButtonBottomConstraint: NSLayoutConstraint!
    var presentedFromNotInYourAreaScreen:Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addRecognizer()
        self.addNotification()
        self.configureTextFields()
    }
    
    //MARK: Actions
    @IBAction func closeAction(_ sender: Any) {
        zipTextField.resignFirstResponder()
        self.dismiss(animated: true) {
        }
    }
    
    @IBAction func changeAction(_ sender: Any) {
        guard let zip = zipTextField.text else{
          return
        }
        let zipIsAvailable =  AvailableZipCodes.zipCodeIsAvailable(zipCode: zip)
        if zipIsAvailable {
            UserProfile.currentProfile.guestZip = zip
            if presentedFromNotInYourAreaScreen {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: AppNotifications.zipCodeIsChangedNotificationName), object: nil)
            }
             self.dismiss(animated: true, completion: nil)
            
        }else{
            let storyboard: UIStoryboard = UIStoryboard(name: "Login", bundle: nil)
            let notInYourAreaViewController = storyboard.instantiateViewController(withIdentifier: "JaldiNotInYourAreaViewController") as? JaldiNotInYourAreaViewController
            let guest = JaldiUser.emptyUser()
            guest.email = UserProfile.currentProfile.guestEmail
            guest.zip = zipTextField.text
            notInYourAreaViewController?.guest = guest
            notInYourAreaViewController?.presentedFromCangeZipScreen = true
            self.present(notInYourAreaViewController!, animated: true, completion: nil)
        }
        
    }
    
    //MARK: Configurations
    private func configureTextFields() {
        zipTextField.placeholder = "ZIP Code"
    }
    //MARK: GestureRecognizer
    private func addRecognizer(){
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(JaldiChangeZipCodeController.handleTap(gestureRecognizer:)))
        view.addGestureRecognizer(gestureRecognizer)
    }
    func handleTap(gestureRecognizer: UIGestureRecognizer) {
        self.zipTextField.resignFirstResponder()
    }
    
    //MARK: Notification
    private func addNotification(){
        NotificationCenter.default.addObserver(self, selector: #selector(JaldiChangeZipCodeController.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(JaldiChangeZipCodeController.keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
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
