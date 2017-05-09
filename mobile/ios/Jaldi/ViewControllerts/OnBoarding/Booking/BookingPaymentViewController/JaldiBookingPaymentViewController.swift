//
//  JaldiBookingPaymentViewController.swift
//  Jaldi
//
//  Created by Grigori Jlavyan on 5/9/17.
//  Copyright © 2017 Handybook. All rights reserved.
//

import UIKit

class JaldiBookingPaymentViewController: UIViewController ,BookingNavigation {
    
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var theTableView: UITableView!
    @IBOutlet weak var changeButtonBottomConstraint: NSLayoutConstraint!
    var bookingObject:BookingObject?
    var curretScreen: BookingScreen = BookingScreen.payment
    var selectedTextField: UITextField?
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        self.configureCardInfo()
        configureBookingProgress()
        addNotification()
    }
    
    //MARK: Confifuration
    private func configureCardInfo() {
        guard let booking = bookingObject else {
            return
        }
        if booking.cardInfo == nil {
            booking.cardInfo = CardInfo()
        }
    }
    private func configureTableView() -> Void {
        theTableView.rowHeight = 115
    }
    
    //MARK: Actions
    @IBAction func backAction(_ sender: Any) {
        selectedTextField?.resignFirstResponder()
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func nextAction(_ sender: Any) {
        self.selectedTextField?.resignFirstResponder()
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
        let invalidFields = self.cardInfoInvalidFields()
    
        let isValid = invalidFields.count == 0
        if !isValid {
          self.highlightCardInfo(invalidFields: invalidFields)
        }
        return isValid
    }
    
    private func cardInfoInvalidFields() -> [CardInfoField] {
        
        guard let cardInfo =  self.bookingObject?.cardInfo else {
            return CardInfoField.requiredFields
        }
        
        var invalidFields  = [CardInfoField]()
        
        let isValidCardNumber = self.isValidCardNumberFor(cardInfo: cardInfo)
        if !isValidCardNumber {
            invalidFields.append(CardInfoField.cardNumber)
        }
        let isValidCvc = self.isValidCvcFor(cardInfo: cardInfo)
        if !isValidCvc {
            invalidFields.append(CardInfoField.cvc)
        }
        
        let isValidCardDate = self.isValidCardDateFor(cardInfo: cardInfo)
        if !isValidCardDate {
            invalidFields.append(CardInfoField.cardDate)
        }

        return invalidFields
    }
    
    private func isValidCardNumberFor(cardInfo:CardInfo) -> Bool {
        guard let cardNumber =  cardInfo.cardNumber else {
            return false
        }
        return JaldiValidator.isValid(cardNumber: cardNumber)
    }
    
    private func isValidCvcFor(cardInfo:CardInfo) -> Bool {
        guard let cvc =  cardInfo.cvc else {
            return false
        }
        return JaldiValidator.isValid(cvc: cvc)
    }
    private func isValidCardDateFor(cardInfo:CardInfo) -> Bool {
        guard let cardDate =  cardInfo.cardDate else {
            return false
        }
        return JaldiValidator.isValid(cardDate: cardDate)
    }
    
    private func highlightCardInfo(invalidFields:[CardInfoField]) {
        guard let cell = (self.theTableView.cellForRow(at: IndexPath(item: 0, section: 0))  as! JaldiBookingPaymentCardCell!) else {
          return
        }
        cell.highlightCardInfo(invalidFields: invalidFields)
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
    
    //MARK: Alert
    fileprivate  func showAlertWith(message:String) -> Void {
        let alert = UIAlertController(title: "", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    deinit{
        removeNotification()
    }
}

// MARK: UITableView
extension JaldiBookingPaymentViewController: UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int{
        return (bookingObject != nil  ? 1: 0)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let simpleTableIdentifier = "JaldiBookingPaymentCardCell"
        let cell:JaldiBookingPaymentCardCell = tableView.dequeueReusableCell(withIdentifier: simpleTableIdentifier, for: indexPath) as! JaldiBookingPaymentCardCell
        if let bookingObject = bookingObject {
            cell.configureWith(bookingObject: bookingObject)
            cell.delegate = self
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 152
        }
        return 44
    }
    
}

extension JaldiBookingPaymentViewController: JaldiBookingPaymentCardCellDelegate {

    func paymentCard(cell:JaldiBookingPaymentCardCell,
                     didBeginEditing textField:UITextField,
                     cardInfoField:CardInfoField)
    {
        selectedTextField = textField
    }
    
    func paymentCard(cell:JaldiBookingPaymentCardCell,
                     didEndEditing textField:UITextField,
                     cardInfoField:CardInfoField)
    {
        switch cardInfoField {
        case .cardNumber:
            self.bookingObject?.cardInfo?.cardNumber = textField.text
        case .cardDate:
            self.bookingObject?.cardInfo?.cardDate = textField.text
        case .cvc:
            self.bookingObject?.cardInfo?.cvc = textField.text
        case .promoCode:
            self.bookingObject?.cardInfo?.promoCode = textField.text
        default:
            break
        }
    }
    
    func paymentCard(cell: JaldiBookingPaymentCardCell,
                     didSelectApply button: UIButton,
                     promoCode:String,
                     completion: @escaping (( _ success: Bool ) -> Void))
    {
        self.selectedTextField?.resignFirstResponder()
        let dispatchTime = DispatchTime.now() + 1.1
        DispatchQueue.main.asyncAfter(deadline: dispatchTime) {
            let promoCodeIsAvailable = AvailablePromoCodes.promoCodeIsAvailable(promoCode: promoCode)
            if (!promoCodeIsAvailable){
                self.showAlertWith(message: "This promo code is invalid")
            }
            completion(promoCodeIsAvailable)
        }
    }
}
