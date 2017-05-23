//
//  JaldiRegistrationViewController.swift
//  Handy
//
//  Created by Grigori Jlavyan on 4/29/17.
//  Copyright © 2017 Handybook. All rights reserved.
//

import UIKit

class JaldiRegistrationViewController: UIViewController {
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var titleLabel: UIView!
    @IBOutlet weak var introView: UIView!
    @IBOutlet weak var backButton: UIButton!
    
    
    @IBOutlet weak var emailInputView: JaldiOnboardingInputView!
    @IBOutlet weak var phoneInputView: JaldiOnboardingInputView!
    @IBOutlet weak var nameInputView: JaldiOnboardingInputView!
    @IBOutlet weak var confirmationCodeInputView: JaldiOnboardingInputView!
    @IBOutlet weak var passwordInputView: JaldiOnboardingInputView!
    @IBOutlet weak var confirmPasswordInputView: JaldiOnboardingInputView!
    
    @IBOutlet weak var introViewTopConstraint: NSLayoutConstraint!
    
    
    @IBOutlet weak var emailInputViewHorizontalCenterConstraint: NSLayoutConstraint!
    @IBOutlet weak var phoneInputViewHorizontalCenterConstraint: NSLayoutConstraint!
    @IBOutlet weak var nameInputViewHorizontalCenterConstraint: NSLayoutConstraint!
    @IBOutlet weak var confirmationCodeInputViewHorizontalCenterConstraint: NSLayoutConstraint!
    @IBOutlet weak var passwordInputViewHorizontalCenterConstraint: NSLayoutConstraint!
    @IBOutlet weak var confirmPasswordInputViewHorizontalCenterConstraint: NSLayoutConstraint!
    
    fileprivate let allStates: [RegistrationState] = [RegistrationState.phone,
                                                   RegistrationState.confirmationCode,
                                                   RegistrationState.name,
                                                   RegistrationState.email,
                                                   RegistrationState.password,
                                                   RegistrationState.confirmPassword]

    fileprivate var activeState: RegistrationState = .phone
    fileprivate var registrationModel: JaldiRegistration = JaldiRegistration()
    private var isKeyboardShown = false
    override func viewDidLoad() {
        super.viewDidLoad()

        self.addNotification()
        self.addRecognizer()
        self.configureInputVievs()
        self.configureWithActive(state: activeState, animated: false)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if self.activeState == .phone && isKeyboardShown == false {
         introView.isHidden = false
        }else{
          self.inputViewFor(state: self.activeState)?.becomeActive()
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Actionsq
    @IBAction func backAction(_ sender: Any) {
        guard let indexForState = self.indexOf(state: activeState),  indexForState > 0 else {
            return
        }
        self.activeState = allStates[(indexForState - 1)]
        let inputView = self.inputViewFor(state: self.activeState)
        inputView?.becomeActive()
        self.configureWithActive(state: self.activeState, animated: true)
    }
    
    @IBAction func signInAction(_ sender: Any) {
        self.inputViewFor(state: self.activeState)?.resignActive()
        let storyboard: UIStoryboard = UIStoryboard(name: "Login", bundle: nil)
        let signInViewController = storyboard.instantiateViewController(withIdentifier: "JaldiSignInViewController") as? JaldiSignInViewController
        let navController = UINavigationController(rootViewController: signInViewController!)
        navController.isNavigationBarHidden = true
        self.present(navController, animated: true, completion: nil)
    }
    
    //MARK: Configuration
    private func configureInputVievs() {
        for state in allStates{
            let inputView = self.inputViewFor(state: state)
            inputView?.configureWith(user: registrationModel, registrationState: state, onboardingInputViewDelegat: self)
        }
    }
    
    //MARK: GestureRecognizer
    private func addRecognizer(){
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(JaldiRegistrationViewController.handleTap(gestureRecognizer:)))
        view.addGestureRecognizer(gestureRecognizer)
    }
    func handleTap(gestureRecognizer: UIGestureRecognizer) {
       phoneInputView?.resignActive()
    }

    //MARK: Notification
    private func addNotification(){
        NotificationCenter.default.addObserver(self, selector: #selector(JaldiRegistrationViewController.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(JaldiRegistrationViewController.keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    private func removeNotification(){
        NotificationCenter.default.removeObserver(self)
    }
    
    func keyboardWillShow(_ notification:Notification) {
        isKeyboardShown = true
        let info = (notification as NSNotification).userInfo!
        let animationDuration = (info[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue

        self.introViewTopConstraint.constant = self.topView.frame.size.height - self.introView.frame.size.height
        UIView.animate(withDuration: animationDuration!, animations: { () -> Void in
            self.view.layoutIfNeeded()
        }, completion: { (finished) -> Void in
                    })
        let duration = animationDuration! / 3
        DispatchQueue.main.asyncAfter(deadline: .now() +  2 * duration, execute: {
            UIView.transition(with: self.introView!, duration:  duration,
                              options: [.curveEaseIn, .transitionCrossDissolve], animations: {
                                self.introView.isHidden = true
            }, completion: {(finished) -> Void in

            })
        })
    }
    
    func keyboardWillHide(_ notification:Notification) {
        isKeyboardShown = false
        let info = (notification as NSNotification).userInfo!
        let animationDuration = (info[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue
    
        self.introView.isHidden = self.activeState != .phone
        self.introViewTopConstraint.constant = 0
        UIView.animate(withDuration: animationDuration!, animations: { () -> Void in
            self.view.layoutIfNeeded()
        }, completion: { (finished) -> Void in
//            self.introView.isHidden = true
        })

    }
    //MARK: OnBoarding State
    
    deinit{
        removeNotification()
    }
    
    fileprivate func configureWithActive(state:RegistrationState , animated:Bool){
        self.changeViewStatesFor(state: state)
        if animated{
            UIView.animate(withDuration: 0.35,
                           animations: { () -> Void in
                            self.view.layoutIfNeeded()
            },completion: { (finished) -> Void in})
        }
    }
    fileprivate func changeViewStatesFor(state:RegistrationState){
        self.configureCenterConstraintsFor(state: state)
        backButton.isHidden = state == .phone
    }
    fileprivate func indexOf(state:RegistrationState) -> Int?{
        return allStates.index(of: state)
    }
    fileprivate func nextStateFor(state:RegistrationState) -> RegistrationState?{
        guard let index =  self.indexOf(state: state), index < allStates.count - 1 else {
            return nil
        }
        return allStates[(index + 1)]
    }

    
    fileprivate func configureCenterConstraintsFor(state:RegistrationState) {
        guard let indexForState = self.indexOf(state: state) else {
            return
        }
        for (indx, st ) in allStates.enumerated() {
            let horizontalCenterConstraint = self.horizontalCenterConstraint(state: st)
            let indexdistance = indx - indexForState
            switch indexdistance  {
            case _ where indexdistance < 0:
                horizontalCenterConstraint?.constant = -self.view.frame.size.width
            case _ where indexdistance == 0:
                horizontalCenterConstraint?.constant =  0
            default:
                horizontalCenterConstraint?.constant = self.view.frame.size.width
            }
        }
    }
    
    
    fileprivate func inputViewFor(state:RegistrationState) -> JaldiOnboardingInputView? {
        switch state {
        case .phone:
            return self.phoneInputView
        case .email:
            return self.emailInputView
        case .confirmationCode:
            return self.confirmationCodeInputView
        case .password:
            return self.passwordInputView
        case .name:
            return self.nameInputView
        case .confirmPassword:
            return self.confirmPasswordInputView
        }
    }
    fileprivate func horizontalCenterConstraint(state:RegistrationState) -> NSLayoutConstraint? {
        switch state {
        case .phone:
            return phoneInputViewHorizontalCenterConstraint
        case .email:
            return self.emailInputViewHorizontalCenterConstraint
        case .confirmationCode:
            return self.confirmationCodeInputViewHorizontalCenterConstraint
        case .password:
            return self.passwordInputViewHorizontalCenterConstraint
        case .name:
            return self.nameInputViewHorizontalCenterConstraint
        case .confirmPassword:
            return self.confirmPasswordInputViewHorizontalCenterConstraint
        }
    }
}

//MARK: JaldiOnboardingInputViewDelegate
extension JaldiRegistrationViewController: JaldiOnboardingInputViewDelegate{
    func onboarding(inputView:JaldiOnboardingInputView, didBeginEditing textField:UITextField, registrationState:RegistrationState) {
    }
    
    func onboarding(inputView:JaldiOnboardingInputView, textFieldDidEndEditing textField:UITextField, registrationState:RegistrationState) {
    
      self.changeRegitrationDetailsFor(textField: textField, registrationState: registrationState)
    }
    
    func onboarding(inputView:JaldiOnboardingInputView, didReturn textField:UITextField, registrationState:RegistrationState) {
        self.changeRegitrationDetailsFor(textField: textField, registrationState: registrationState)
        switch registrationState {
        case .phone:
            self.verifyPhoneAndMoveToNextScreen()
        case .confirmationCode:
            self.verifyConfirmationCodeAndMoveToNextScreen()
        case .name:
            self.moveToNextStateFor(state: registrationState)
        case .email:
           self.moveToNextStateFor(state: registrationState)
        case .password:
           self.moveToNextStateFor(state: registrationState)
        case .confirmPassword:
           self.moveToNextStateFor(state: registrationState)
        }
    }
    private func changeRegitrationDetailsFor(textField:UITextField, registrationState:RegistrationState) {
        switch registrationState {
        case .phone:
            registrationModel.phone = textField.text
        case .confirmationCode:
            registrationModel.confirmationCode = textField.text
        case .email:
            registrationModel.email = textField.text
        case .password:
            registrationModel.password = textField.text
        case .name:
            registrationModel.name = textField.text
        case .confirmPassword:
            registrationModel.confirmPassword = textField.text
        }
    }
    fileprivate func registerUser() {
       
        self.showHudWithMsg(message: nil)
        let task  = JaldiRegistrationTask(registrationModel: registrationModel)
        task.execute(in: NetworkDispatcher.defaultDispatcher(), taskCompletion: { [weak self] (value) in
            guard let user  = value else{
                return
            }
             self?.hideHud()
            UserProfile.currentProfile.loginAsGuest(guest: user)
            self?.moveToNextStateFor(state: .phone)
           
        }) {[weak self] (error, _) in
            self?.hideHud()
            if let error = error {
                if case NetworkErrors.networkMessage(error_: _, message: let message) = error {
                    self?.showAlertWith(title: NSLocalizedString("Error", comment: ""), message: message)
                }else{
                    self?.showAlertWith(title: NSLocalizedString("Error", comment: ""), message: NSLocalizedString("UnableToRegisterUserMessage", comment: ""))
                }
            }
            print(error ?? "Error")
        }
    }
    
    //MARK: Helper
    private func verifyPhoneAndMoveToNextScreen() {
        if registrationModel.isPhoneNumberVerified {
          self.moveToNextStateFor(state: .phone)
            return
        }
        guard let phone  = registrationModel.recipient else{
         return
        }
        self.showHudWithMsg(message: nil)
        let task  = JaldiSendVerificationTask(recipient: phone)
        task.execute(in: NetworkDispatcher.defaultDispatcher(), taskCompletion: { [weak self] (value) in
            guard let mobileVerification  = value else{
                return
            }
            self?.registrationModel.mobileVerification = mobileVerification
            self?.moveToNextStateFor(state: .phone)
            self?.hideHud()
            
        }) {[weak self] (error, _) in
            self?.hideHud()
            if let error = error {
                if case NetworkErrors.networkMessage(error_: _, message: let message) = error {
                    self?.showAlertWith(title: NSLocalizedString("Error", comment: ""), message: message)
                }else{
                  self?.showAlertWith(title: NSLocalizedString("Error", comment: ""), message: NSLocalizedString("PhoneIsNotVerifiedMessage", comment: ""))
                }
            }
        print(error ?? "Error")
        }
    }
    private func verifyConfirmationCodeAndMoveToNextScreen() {
        if registrationModel.isConfirmationCodeValid {
            self.moveToNextStateFor(state: .confirmationCode)
        }else{
        self.showAlertWith(title: NSLocalizedString("Error", comment: ""), message: NSLocalizedString("WrongVerificationCodeMessage", comment: ""))
        }
    }
    
    private func moveToNextStateFor(state:RegistrationState) {
        
        guard let index =  self.indexOf(state: state),index < allStates.count else {
            return
        }
        let isLastState = index == allStates.count - 1
        if isLastState {
            if registrationModel.isPasswordConfirmationValid {
                self.registerUser()
            }else{
                self.showAlertWith(title: nil, message: NSLocalizedString("PasswordConfirmationMustMatchPasswordMessage", comment: ""))
            }
        }else{
            let nextState  = allStates[index + 1]
            self.activeState = nextState
            let imputView  = self.inputViewFor(state: nextState)
            imputView?.becomeActive()
            self.configureWithActive(state: nextState, animated: true)
        }
    }
    
}

