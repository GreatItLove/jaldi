//
//  JaldiOnboardingInputView.swift
//  Jaldi
//
//  Created by Grigori Jlavyan on 4/30/17.
//  Copyright © 2017 Handybook. All rights reserved.
//

import UIKit
protocol JaldiOnboardingInputViewDelegate: class {
    func onboarding(inputView:JaldiOnboardingInputView, didBeginEditing textField:UITextField, registrationState:RegistrationState)
    func onboarding(inputView:JaldiOnboardingInputView, textFieldDidEndEditing textField:UITextField, registrationState:RegistrationState)
    func onboarding(inputView:JaldiOnboardingInputView, didReturn textField:UITextField, registrationState:RegistrationState)
}
class JaldiOnboardingInputView: UIView {
    
    @IBOutlet weak var inputViewTitleLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var onboardingTextField: UITextField!
    
    fileprivate var state: RegistrationState = .phone
    fileprivate weak var delegate: JaldiOnboardingInputViewDelegate!
    fileprivate var enabledToReturn: Bool = false {
        didSet {
            if enabledToReturn {
            }
        }
    }

    func resignActive() {
        onboardingTextField.resignFirstResponder()
    }
    func becomeActive() {
        onboardingTextField.becomeFirstResponder()
    }
    //MARK: Configuration
    func configureWith(user:JaldiRegistration,
                       registrationState:RegistrationState ,
                       onboardingInputViewDelegat:JaldiOnboardingInputViewDelegate) {
        
        self.state = registrationState
        self.delegate = onboardingInputViewDelegat
        self.configureOnboardingTextFieldWith(user:user, registrationState:registrationState)
        self.configureTitle(registrationState: registrationState)
        self.configureNextButtonStateWith(user: user, registrationState: registrationState)
    }
    
    //MARK: Actions
    @IBAction func nextAction(_ sender: Any) {
        let canReturn  = self.isValid(inputString: onboardingTextField.text)
        if canReturn {
            delegate?.onboarding(inputView: self, didReturn: onboardingTextField, registrationState: self.state)
        }
    }
    
    fileprivate func  configureOnboardingTextFieldWith(user:JaldiRegistration,
                                                       registrationState:RegistrationState) {
        onboardingTextField.placeholder = RegistrationPlaceholderText.registrationPlaceholderTextFor(registrationState: registrationState)
        switch registrationState {
        case .phone:
            onboardingTextField.text = user.phone
            onboardingTextField.keyboardType = .phonePad
            onboardingTextField.isSecureTextEntry = false
        case .confirmationCode:
            onboardingTextField.text = user.confirmationCode
            onboardingTextField.keyboardType = .default
            onboardingTextField.isSecureTextEntry = false
        case .password:
            onboardingTextField.text = user.password
            onboardingTextField.keyboardType = .default
            onboardingTextField.isSecureTextEntry = true
        case .confirmPassword:
            onboardingTextField.text = user.confirmPassword
            onboardingTextField.keyboardType = .default
            onboardingTextField.isSecureTextEntry = true
        case .email:
            onboardingTextField.text = user.email
            onboardingTextField.keyboardType = .emailAddress
            onboardingTextField.isSecureTextEntry = false
        case .name:
            onboardingTextField.text = user.name
            onboardingTextField.keyboardType = .default
            onboardingTextField.isSecureTextEntry = false
        
        }
    }
    fileprivate func  configureTitle(registrationState:RegistrationState) {
        inputViewTitleLabel.text = RegistrationStateTitle.registrationStateTitleFor(registrationState: registrationState)
    }
    
    fileprivate func  configureNextButtonStateWith(user:JaldiRegistration,
                                                   registrationState:RegistrationState) {
        var enabled = false
        switch registrationState {
        case .phone:
           enabled =  self.isValid(inputString: user.phone )
        case .confirmationCode:
            enabled =  self.isValid(inputString: user.confirmationCode )
        case .password:
            enabled =  self.isValid(inputString: user.password )
        case .email:
            enabled =  self.isValid(inputString: user.email)
        case .confirmPassword:
            enabled =  self.isValid(inputString: user.confirmPassword)
        case .name:
            enabled =  self.isValid(inputString: user.name)
        }
        self.setNextButtonState(enabled: enabled)
    }
    fileprivate func  setNextButtonState(enabled: Bool) {
        if enabled {
            nextButton.backgroundColor = AppColors.GreenColor
            nextButton.isEnabled = enabled
        }else{
            nextButton.backgroundColor = AppColors.GrayColor
            nextButton.isEnabled = enabled
        }
    }
    
    //MARK: Validation
    fileprivate func  isValid(inputString:String?) -> Bool
    {
        guard let inputString = inputString else {
            return false
        }
        switch state {
        case .phone:
            return JaldiValidator.isValid(phone: inputString)
        case .confirmationCode:
            return true
        case .password:
            return true
        case .confirmPassword:
            return true
        case .name:
            return true
        case .email:
            return JaldiValidator.isValidEmail(inputString:inputString)
        }
    }
}
//MARK: UITextFieldDelegate
extension JaldiOnboardingInputView: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
      delegate?.onboarding(inputView: self, didBeginEditing:textField, registrationState:self.state )
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.onboarding(inputView: self, textFieldDidEndEditing: textField, registrationState:self.state)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if state == .phone {
            if ((textField.text?.characters.count)! > 12 && string.characters.count > 0) {
                return false
            }
            if string.characters.count == 0 {
                let newValue = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? string
                self.checkValidationAndChangeStateIfNededFor(newValue: newValue)
                return true
            }
            if JaldiValidator.isNumeric(inputString: string){
                let newValue = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? string
                textField.text = JaldiValidator.correct(phoneNumber: newValue)
                self.checkValidationAndChangeStateIfNededFor(newValue: textField.text!)
            }
            return false
        }
        let newValue = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? string
        self.checkValidationAndChangeStateIfNededFor(newValue: newValue)
      return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let canReturn  = self.isValid(inputString: textField.text)
        if canReturn {
         delegate?.onboarding(inputView: self, didReturn: textField, registrationState: self.state)
         return true
        }
      return false
    }
    
    fileprivate func checkValidationAndChangeStateIfNededFor(newValue:String) {
       let isValid = self.isValid(inputString: newValue)
       self.setNextButtonState(enabled: isValid)
    }
}
