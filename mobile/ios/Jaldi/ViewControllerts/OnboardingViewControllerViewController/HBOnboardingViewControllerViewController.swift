//
//  HBOnboardingViewControllerViewController.swift
//  Handy
//
//  Created by Grigori Jlavyan on 4/29/17.
//  Copyright © 2017 Handybook. All rights reserved.
//

import UIKit

class HBOnboardingViewControllerViewController: UIViewController {
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var titleLabel: UIView!
    @IBOutlet weak var introView: UIView!
    @IBOutlet weak var backButton: UIButton!
    
    
    @IBOutlet weak var emailInputView: JaldiOnboardingInputView!
    @IBOutlet weak var phoneInputView: JaldiOnboardingInputView!
    @IBOutlet weak var confirmationCodeInputView: JaldiOnboardingInputView!
    @IBOutlet weak var passwordInputView: JaldiOnboardingInputView!
    
    @IBOutlet weak var introViewTopConstraint: NSLayoutConstraint!
    
    
    @IBOutlet weak var emailInputViewHorizontalCenterConstraint: NSLayoutConstraint!
    @IBOutlet weak var phoneInputViewHorizontalCenterConstraint: NSLayoutConstraint!
    @IBOutlet weak var confirmationCodeInputViewHorizontalCenterConstraint: NSLayoutConstraint!
    @IBOutlet weak var passwordInputViewHorizontalCenterConstraint: NSLayoutConstraint!
    
    fileprivate let allStates: [OnBoardingState] = [OnBoardingState.phone,
                                                   OnBoardingState.confirmationCode,
                                                   OnBoardingState.email,
                                                   OnBoardingState.password]

    fileprivate var activeState: OnBoardingState = .phone
    fileprivate var currentUser: JaldiUser = JaldiUser()
    override func viewDidLoad() {
        super.viewDidLoad()

        self.addNotification()
        self.addRecognizer()
        self.configureInputVievs()
        self.configureWithActive(state: activeState, animated: false)
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
//        if self.activeState == .email {
//            self.activeState = .phone
//            phoneInputView.becomeActive()
//            
//        }
    }
    
    @IBAction func signInAction(_ sender: Any) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Login", bundle: nil)
        let signInViewController = storyboard.instantiateViewController(withIdentifier: "JaldiSignInViewController") as? JaldiSignInViewController
        self.present(signInViewController!, animated: true, completion: nil)
    }
    
    //MARK: Configuration
    private func configureInputVievs() {
        phoneInputView?.configureWith(user: currentUser, onBoardingState: .phone, onboardingInputViewDelegat: self)
        confirmationCodeInputView?.configureWith(user: currentUser, onBoardingState: .confirmationCode, onboardingInputViewDelegat: self)
        emailInputView?.configureWith(user: currentUser, onBoardingState: .email, onboardingInputViewDelegat: self)
        passwordInputView?.configureWith(user: currentUser, onBoardingState: .password, onboardingInputViewDelegat: self)
      
    }
    
    //MARK: GestureRecognizer
    private func addRecognizer(){
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(HBOnboardingViewControllerViewController.handleTap(gestureRecognizer:)))
        view.addGestureRecognizer(gestureRecognizer)
    }
    func handleTap(gestureRecognizer: UIGestureRecognizer) {
       phoneInputView?.resignActive()
    }

    //MARK: Notification
    private func addNotification(){
        NotificationCenter.default.addObserver(self, selector: #selector(HBOnboardingViewControllerViewController.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(HBOnboardingViewControllerViewController.keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    private func removeNotification(){
        NotificationCenter.default.removeObserver(self)
    }
    
    func keyboardWillShow(_ notification:Notification) {
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
    
    fileprivate func configureWithActive(state:OnBoardingState , animated:Bool){
        self.changeViewStatesFor(state: state)
        if animated{
            UIView.animate(withDuration: 0.35,
                           animations: { () -> Void in
                            self.view.layoutIfNeeded()
            },completion: { (finished) -> Void in})
        }
    }
    fileprivate func changeViewStatesFor(state:OnBoardingState){
        self.configureCenterConstraintsFor(state: state)
        backButton.isHidden = state == .phone
    }
    fileprivate func indexOf(state:OnBoardingState) -> Int?{
        return allStates.index(of: state)
    }
    
    fileprivate func configureCenterConstraintsFor(state:OnBoardingState) {
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
    
    
    fileprivate func inputViewFor(state:OnBoardingState) -> JaldiOnboardingInputView? {
        switch state {
        case .phone:
            return self.phoneInputView
        case .email:
            return self.emailInputView
        case .confirmationCode:
            return self.confirmationCodeInputView
        case .password:
            return self.phoneInputView
        }
    }
    fileprivate func horizontalCenterConstraint(state:OnBoardingState) -> NSLayoutConstraint? {
        switch state {
        case .phone:
            return phoneInputViewHorizontalCenterConstraint
        case .email:
            return self.emailInputViewHorizontalCenterConstraint
        case .confirmationCode:
            return self.confirmationCodeInputViewHorizontalCenterConstraint
        case .password:
            return self.passwordInputViewHorizontalCenterConstraint
        }
    }
}

//MARK: JaldiOnboardingInputViewDelegate
extension HBOnboardingViewControllerViewController: JaldiOnboardingInputViewDelegate{
    func onboarding(inputView:JaldiOnboardingInputView, didBeginEditing textField:UITextField, onboardingState:OnBoardingState) {
    }
    
    func onboarding(inputView:JaldiOnboardingInputView, textFieldDidEndEditing textField:UITextField, onboardingState:OnBoardingState) {
        switch onboardingState {
        case .phone:
            currentUser.phone = textField.text
        case .confirmationCode:
            currentUser.confirmationCode = textField.text
        case .email:
            currentUser.email = textField.text
        case .password:
            currentUser.password = textField.text
       }
    }
    
    func onboarding(inputView:JaldiOnboardingInputView, didReturn textField:UITextField, onboardingState:OnBoardingState) {
        switch onboardingState {
        case .phone:
            self.activeState = .confirmationCode
            confirmationCodeInputView.becomeActive()
            self.configureWithActive(state: self.activeState, animated: true)
        case .confirmationCode:
            self.activeState = .email
            emailInputView.becomeActive()
            self.configureWithActive(state: self.activeState, animated: true)
        case .email:
            self.activeState = .password
            passwordInputView.becomeActive()
            self.configureWithActive(state: self.activeState, animated: true)
        case .password:
            self.passwordInputView.resignActive()
            self.moveToNextScreen()
        }
    }
    fileprivate func moveToNextScreen() {
        if currentUser.canLoginAsGuest() {
            UserProfile.currentProfile.loginAsGuest(guest: currentUser)
        }else {
            let storyboard: UIStoryboard = UIStoryboard(name: "Login", bundle: nil)
            let notInYourAreaViewController = storyboard.instantiateViewController(withIdentifier: "JaldiNotInYourAreaViewController") as? JaldiNotInYourAreaViewController
            notInYourAreaViewController?.guest = self.currentUser
            self.navigationController?.pushViewController(notInYourAreaViewController!, animated: true)
        }
    }
    
}

extension HBOnboardingViewControllerViewController: JaldiPlacePickerDelegate {
    func placePicker(JaldiPlacePicker:JaldiPlacePicker, didSelect address:String) {
        currentUser.address = address
//    zipInputView?.configureWith(user: currentUser, onBoardingState: .zip, onboardingInputViewDelegat: self)
    }
}
