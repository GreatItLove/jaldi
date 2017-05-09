//
//  JaldiBookingPaymentCardCell.swift
//  Jaldi
//
//  Created by Grigori Jlavyan on 5/9/17.
//  Copyright © 2017 Handybook. All rights reserved.
//

import UIKit

enum CardInfoField: Int {
    case cardNumber
    case cardDate
    case cvc
    case promoCode
    case other
    static let requiredFields:[CardInfoField] = [CardInfoField.cardNumber,
                                      CardInfoField.cardDate,
                                      CardInfoField.cvc
                                      ]
}

protocol JaldiBookingPaymentCardCellDelegate: class {
    func paymentCard(cell: JaldiBookingPaymentCardCell, didBeginEditing textField: UITextField, cardInfoField: CardInfoField)
    func paymentCard(cell: JaldiBookingPaymentCardCell, didEndEditing textField: UITextField, cardInfoField: CardInfoField)
    func paymentCard(cell: JaldiBookingPaymentCardCell, didSelectApply button: UIButton, promoCode:String, completion: @escaping (( _ success: Bool ) -> Void))
}

class JaldiBookingPaymentCardCell: UITableViewCell {

    private struct CardInfoPlaceholder {
        static let cardNumber = "Credit Card Number"
        static let cardDate = "MM/YY"
        static let cvc = "CVC"
        static let promoCode = "Promo Code (Optional)"
    }
    
    @IBOutlet weak var cardNumberTextField: UITextField!
    @IBOutlet weak var cardDateTextField: UITextField!
    @IBOutlet weak var cvcTextField: UITextField!
    @IBOutlet weak var promoCodeTextField: UITextField!
    @IBOutlet weak var applyButtoon: UIButton!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    weak var delegate: JaldiBookingPaymentCardCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    //MARK:Configuration
    func configureWith(bookingObject:BookingObject) {
        indicator.stopAnimating()
        self.configureTextFieldsWith(bookingObject:bookingObject)
        self.configureApplyButtonState()
    }
    
    func highlightCardInfo(invalidFields:[CardInfoField]) {
        for cardInfoField in invalidFields{
            self.highlight(cardInfoField: cardInfoField)
        }
    }
    
    private func configureTextFieldsWith(bookingObject:BookingObject) {
        self.configureTextFieldsPlaceholder()
        
        cardNumberTextField.text = bookingObject.cardInfo?.cardNumber ?? ""
        cardDateTextField.text = bookingObject.cardInfo?.cardDate ?? ""
        cvcTextField.text = bookingObject.cardInfo?.cvc ?? ""
        promoCodeTextField.text = bookingObject.cardInfo?.promoCode ?? ""
    }
    private func configureTextFieldsPlaceholder() {
        cardNumberTextField.placeholder = CardInfoPlaceholder.cardNumber
        cardDateTextField.placeholder = CardInfoPlaceholder.cardDate
        cvcTextField.placeholder = CardInfoPlaceholder.cvc
        promoCodeTextField.placeholder = CardInfoPlaceholder.promoCode
    }
    fileprivate func configureApplyButtonState() {
        guard let promoCode = promoCodeTextField.text else {
            applyButtoon.isHidden = true
            return
        }
        applyButtoon.isHidden = promoCode.characters.count == 0
    }
   
    //MARK: Actions
    @IBAction func applyAction(_ sender: UIButton) {
        applyButtoon.isHidden = true
        indicator.startAnimating()
        let promoCode = promoCodeTextField.text ?? ""
        delegate?.paymentCard(cell: self, didSelectApply: sender, promoCode:promoCode, completion: { (sucess) in
            self.configureApplyButtonState()
            self.indicator.stopAnimating()
            
        })
    }
    //MARK: highlighting fields
    private func highlight(cardInfoField:CardInfoField) {
        switch cardInfoField {
        case .cardNumber:
            let str = NSAttributedString(string: CardInfoPlaceholder.cardNumber, attributes: [NSForegroundColorAttributeName:UIColor.red])
            cardNumberTextField.attributedPlaceholder = str
            cardNumberTextField.textColor = UIColor.red
        case .cardDate:
            let str = NSAttributedString(string: CardInfoPlaceholder.cardDate, attributes: [NSForegroundColorAttributeName:UIColor.red])
            cardDateTextField.attributedPlaceholder = str
            cardDateTextField.textColor = UIColor.red
        case .cvc:
            let str = NSAttributedString(string: CardInfoPlaceholder.cvc, attributes: [NSForegroundColorAttributeName:UIColor.red])
            cvcTextField.attributedPlaceholder = str
            cvcTextField.textColor = UIColor.red
        default:
            break
        }
    }
}

//MARK: UITextFieldDelegate
extension JaldiBookingPaymentCardCell: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let cardInfo = self.cardInfoFieldFrom(textField: textField)
        delegate?.paymentCard(cell: self, didBeginEditing: textField, cardInfoField: cardInfo)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let cardInfo = self.cardInfoFieldFrom(textField: textField)
        delegate?.paymentCard(cell: self, didEndEditing: textField, cardInfoField: cardInfo)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        textField.textColor = UIColor.darkText
        let cardInfo = self.cardInfoFieldFrom(textField: textField)
        switch cardInfo {
        case .promoCode:
            let newValue = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? string
            self.applyButtoon.isHidden = newValue.characters.count == 0
        case .cvc:
            let text  = textField.text ?? ""
            if text.characters.count >= 4  && string.characters.count > 0 {
                return false
            }
        case .cardDate:
            let text  = textField.text ?? ""
            if text.characters.count >= 5  && string.characters.count > 0 {
                return false
            }
            if string.characters.count == 0 {
                return true
            }
            if JaldiValidator.isNumeric(inputString: string){
                let newValue = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? string
                textField.text = self.correct(cardDate: newValue)
            }
            return false
        default:
            break
        }
        return true
    }
    
    private func cardInfoFieldFrom(textField: UITextField) -> CardInfoField{
        if textField == cardNumberTextField { return CardInfoField.cardNumber }
        if textField == cardDateTextField   { return CardInfoField.cardDate }
        if textField == cvcTextField        { return CardInfoField.cvc }
        if textField == promoCodeTextField  { return CardInfoField.promoCode }
        return CardInfoField.other
    }
    
    private func correct(cardDate:String) -> String {
        var result:NSString = ""
        let text  = cardDate as NSString
        let  strippedNumber =  text.replacingOccurrences(of: "[^0-9]", with: "", options: NSString.CompareOptions.regularExpression, range: NSMakeRange(0, text.length)) as NSString
        for location in 0..<strippedNumber.length {
            let  character = strippedNumber.character(at: location) as  unichar
            switch location {
            case 2:
                result = result.appendingFormat("/%C", character)
            default:
                result = result.appendingFormat("%C", character)
            }
        }
        return result as String
    }}
