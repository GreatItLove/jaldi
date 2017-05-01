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
    
    fileprivate var state: OnBoardingState = .zip
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
    func configureWith(onBoardingModel:JaldiOnboardingModel,
                       onBoardingState:OnBoardingState ,
                       onboardingInputViewDelegat:JaldiOnboardingInputViewDelegate) {
        
        self.state = onBoardingState
        self.delegate = onboardingInputViewDelegat
        self.configureOnboardingTextFieldWith(onBoardingModel:onBoardingModel, onBoardingState:onBoardingState)
        self.configureNextButtonStateWith(onBoardingModel: onBoardingModel, onBoardingState: onBoardingState)
    }
    
    //MARK: Actions
    @IBAction func nextAction(_ sender: Any) {
        let canReturn  = self.isValid(inputString: onboardingTextField.text)
        if canReturn {
            delegate?.onboarding(inputView: self, didReturn: onboardingTextField, onboardingState: self.state)
        }
    }
  
    fileprivate func  configureOnboardingTextFieldWith(onBoardingModel:JaldiOnboardingModel,
                                                       onBoardingState:OnBoardingState) {
        onboardingTextField.placeholder = OnBoardingPlaceholderText.onBoardingPlaceholderTextFor(onBoardingState: onBoardingState)
        switch onBoardingState {
        case .zip:
            onboardingTextField.text = onBoardingModel.zip
        case .email:
            onboardingTextField.text = onBoardingModel.email
            
        }
    }
    
    fileprivate func  configureNextButtonStateWith(onBoardingModel:JaldiOnboardingModel,
                                                   onBoardingState:OnBoardingState) {
        var enabled = false
        switch onBoardingState {
        case .zip:
           enabled =  self.isValid(inputString: onBoardingModel.zip )
        case .email:
            enabled =  self.isValid(inputString: onBoardingModel.email)
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
        case .zip:
           return inputString.characters.count >= 3
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
        delegate?.onboarding(inputView: self, didBeginEditing: textField, onboardingState:self.state)
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
