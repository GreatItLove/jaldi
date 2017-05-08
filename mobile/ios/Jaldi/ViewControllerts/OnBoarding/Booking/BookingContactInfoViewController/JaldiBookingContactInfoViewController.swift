//
//  JaldiBookingContactInfoViewController.swift
//  Jaldi
//
//  Created by Grigori Jlavyan on 5/5/17.
//  Copyright © 2017 Handybook. All rights reserved.
//

import UIKit

class JaldiBookingContactInfoViewController: UIViewController,BookingNavigation {

    private struct ContactInfoPlaceholder {
        static let fullName = "Full Name"
        static let street = "Street Address"
        static let apt = "Apt #"
        static let phone = "Phone"
    }

    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var streetTextField: UITextField!
    @IBOutlet weak var aptTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    
    @IBOutlet weak var bookingDatePriceView: JaldiBookingDatePriceView!
    
    
    @IBOutlet weak var changeButtonBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var progressView: UIProgressView!
    var bookingObject:BookingObject?
    var curretScreen: BookingScreen = BookingScreen.contactInfo
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBookingProgress()
        addNotification()
        configureContactInfo()
        configureContactInfoTextFields()
        
    }
    //MARK: Confifuration
    private func configureContactInfo() {
        guard let booking = bookingObject else {
            return
        }
        if booking.contactInfo == nil {
            booking.contactInfo = BookingContactInfo()
        }
        bookingDatePriceView.configureWith(bookingObject: booking)
        
    }
    private func configureContactInfoTextFields() {
        fullNameTextField.text = bookingObject?.contactInfo?.fullName
        streetTextField.text = bookingObject?.contactInfo?.streetAddress
        aptTextField.text = bookingObject?.contactInfo?.apt
        phoneTextField.text = bookingObject?.contactInfo?.phone
    }
    private func updateBookingObjectFromScreen() {
        bookingObject?.contactInfo?.fullName = fullNameTextField.text
        bookingObject?.contactInfo?.streetAddress = streetTextField.text
        bookingObject?.contactInfo?.apt = aptTextField.text
        bookingObject?.contactInfo?.phone = phoneTextField.text
    }
    
    //MARK: Actions
    @IBAction func backAction(_ sender: Any) {
        self.updateBookingObjectFromScreen()
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func nextAction(_ sender: Any) {
        
        self.updateBookingObjectFromScreen()
        if self.checkRequiredFields() {
           self.showNextScreen()
        }
    }

    private func showNextScreen() {
        if !self.isLastScreen() {
            if let nextViewController = self.nextScreen() {
                self.navigationController?.pushViewController(nextViewController, animated: true)
            }
        }
    }
    //MARK: Validation
    private func checkRequiredFields() -> Bool {
        let isValidFullName = self.isValidFullName()
        let isValidStreet = self.isValidStreet()
        let isValidPhone = self.isValidPhone()
        
        return isValidFullName && isValidStreet && isValidPhone
    }
    
    private func isValidFullName() -> Bool {
        var isValid = false
        if let fullName = bookingObject?.contactInfo?.fullName{
            isValid = fullName.characters.count > 0 && (fullName.range(of: " ") != nil)
        }
        if !isValid{
            let str = NSAttributedString(string: ContactInfoPlaceholder.fullName, attributes: [NSForegroundColorAttributeName:UIColor.red])
            fullNameTextField.attributedPlaceholder = str
            fullNameTextField.textColor = UIColor.red
        }
        return isValid
    }
    private func isValidStreet() -> Bool {
        var isValid = false
        if let streetAddress = bookingObject?.contactInfo?.streetAddress{
         isValid =  streetAddress.characters.count > 0
        }
        if !isValid{
            let str = NSAttributedString(string: ContactInfoPlaceholder.street, attributes: [NSForegroundColorAttributeName:UIColor.red])
            streetTextField.attributedPlaceholder = str
            streetTextField.textColor = UIColor.red
        }
        return isValid
    }
    private func isValidPhone() -> Bool {
        var isValid = false
        if let phone = bookingObject?.contactInfo?.phone{
            let text = phone as NSString
            let  strippedNumber =  text.replacingOccurrences(of: "[^0-9,+]", with: "", options: NSString.CompareOptions.regularExpression, range: NSMakeRange(0, text.length)) as NSString
            isValid = strippedNumber.length == 10
        }
       
        if !isValid{
            let str = NSAttributedString(string: ContactInfoPlaceholder.phone, attributes: [NSForegroundColorAttributeName:UIColor.red])
            phoneTextField.attributedPlaceholder = str
            phoneTextField.textColor = UIColor.red
        }
        return isValid
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

//MARK: UITextFieldDelegate
extension JaldiBookingContactInfoViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        textField.textColor = UIColor.darkText
        if textField == phoneTextField {
            
            if ((textField.text?.characters.count)! > 12 && string.characters.count > 0) {
                return false
            }
            if string.characters.count == 0 {
                return true
            }
            if JaldiValidator.isNumeric(inputString: string){
                let newValue = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? string
               textField.text = self.correct(phoneNumber: newValue)
            }
             return false
        }
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return false
    }

    private func correct(phoneNumber:String) -> String {
        var result:NSString = ""
        let text  = phoneNumber as NSString
        let  strippedNumber =  text.replacingOccurrences(of: "[^0-9,+]", with: "", options: NSString.CompareOptions.regularExpression, range: NSMakeRange(0, text.length)) as NSString
        for location in 0..<strippedNumber.length {
            let  character = strippedNumber.character(at: location) as  unichar
            switch location {
            case 0:
                result = result.appendingFormat("(%C", character)
            case 2:
                result = result.appendingFormat("%C)", character)
            case 6:
                result = result.appendingFormat("-%C", character)
            default:
                result = result.appendingFormat("%C", character)
            }
        }
        return result as String
    }
    
}
