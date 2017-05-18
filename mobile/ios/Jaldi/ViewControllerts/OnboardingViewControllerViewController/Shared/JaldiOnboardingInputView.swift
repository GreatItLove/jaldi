//
//  JaldiOnboardingInputView.swift
//  Jaldi
//
//  Created by Grigori Jlavyan on 4/30/17.
//  Copyright © 2017 Handybook. All rights reserved.
//

import UIKit
protocol JaldiOnboardingInputViewDelegate: class {
    func onboarding(inputView:JaldiOnboardingInputView, didBeginEditing textField:UITextField, onboardingState:OnBoardingState)
    func onboarding(inputView:JaldiOnboardingInputView, textFieldDidEndEditing textField:UITextField, onboardingState:OnBoardingState)
    func onboarding(inputView:JaldiOnboardingInputView, didReturn textField:UITextField, onboardingState:OnBoardingState)
    
}
class JaldiOnboardingInputView: UIView {
    
    @IBOutlet weak var inputViewTitleLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var onboardingTextField: UITextField!
    
    fileprivate var state: OnBoardingState = .phone
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
    func configureWith(user:JaldiUser,
                       onBoardingState:OnBoardingState ,
                       onboardingInputViewDelegat:JaldiOnboardingInputViewDelegate) {
        
        self.state = onBoardingState
        self.delegate = onboardingInputViewDelegat
        self.configureOnboardingTextFieldWith(user:user, onBoardingState:onBoardingState)
        self.configureTitle(onBoardingState: onBoardingState)
        self.configureNextButtonStateWith(user: user, onBoardingState: onBoardingState)
    }
    
    //MARK: Actions
    @IBAction func nextAction(_ sender: Any) {
        let canReturn  = self.isValid(inputString: onboardingTextField.text)
        if canReturn {
            delegate?.onboarding(inputView: self, didReturn: onboardingTextField, onboardingState: self.state)
        }
    }
    
    fileprivate func  configureOnboardingTextFieldWith(user:JaldiUser,
                                                       onBoardingState:OnBoardingState) {
        onboardingTextField.placeholder = OnBoardingPlaceholderText.onBoardingPlaceholderTextFor(onBoardingState: onBoardingState)
        switch onBoardingState {
        case .phone:
            onboardingTextField.text = user.phone
            onboardingTextField.keyboardType = .numberPad
            onboardingTextField.isSecureTextEntry = false
        case .confirmationCode:
            onboardingTextField.text = user.confirmationCode
            onboardingTextField.keyboardType = .default
            onboardingTextField.isSecureTextEntry = false
        case .password:
            onboardingTextField.text = user.password
            onboardingTextField.keyboardType = .default
            onboardingTextField.isSecureTextEntry = true
        case .email:
            onboardingTextField.text = user.email
            onboardingTextField.keyboardType = .emailAddress
            onboardingTextField.isSecureTextEntry = false
        
        }
    }
    fileprivate func  configureTitle(onBoardingState:OnBoardingState) {
        inputViewTitleLabel.text = OnBoardingStateTitle.onBoardingStateTitleFor(onBoardingState: onBoardingState)
    }
    
    fileprivate func  configureNextButtonStateWith(user:JaldiUser,
                                                   onBoardingState:OnBoardingState) {
        var enabled = false
        switch onBoardingState {
        case .phone:
           enabled =  self.isValid(inputString: user.phone )
        case .confirmationCode:
            enabled =  self.isValid(inputString: user.confirmationCode )
        case .password:
            enabled =  self.isValid(inputString: user.password )
        case .email:
            enabled =  self.isValid(inputString: user.email)
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
            return true
        case .confirmationCode:
            return true
        case .password:
            return true
        case .email:
            return JaldiValidator.isValidEmail(inputString:inputString)
        }
    }
   
}
//MARK: UITextFieldDelegate
extension JaldiOnboardingInputView: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
      delegate?.onboarding(inputView: self, didBeginEditing:textField, onboardingState:self.state )
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.onboarding(inputView: self, textFieldDidEndEditing: textField, onboardingState:self.state)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newValue = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? string
        self.checkValidationAndChangeStateIfNededFor(newValue: newValue)
      return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let canReturn  = self.isValid(inputString: textField.text)
        if canReturn {
         delegate?.onboarding(inputView: self, didReturn: textField, onboardingState: self.state)
         return true
        }
      return false
    }
    
    fileprivate func checkValidationAndChangeStateIfNededFor(newValue:String) {
       let isValid = self.isValid(inputString: newValue)
       self.setNextButtonState(enabled: isValid)
    }
}
