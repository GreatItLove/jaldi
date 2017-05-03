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
    @IBOutlet weak var introView: UIView!
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var zipInputView: JaldiOnboardingInputView!
    @IBOutlet weak var emailInputView: JaldiOnboardingInputView!
    
    @IBOutlet weak var introViewTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var zipInputViewHorizontalCenterConstraint: NSLayoutConstraint!
    @IBOutlet weak var emailInputViewHorizontalCenterConstraint: NSLayoutConstraint!
    fileprivate var activeState: OnBoardingState = .zip
    fileprivate var onboardingModel: JaldiOnboardingModel = JaldiOnboardingModel()
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
    //MARK: Actions
    @IBAction func backAction(_ sender: Any) {
        if self.activeState == .email {
            self.activeState = .zip
            zipInputView.becomeActive()
            self.configureWithActive(state: self.activeState, animated: true)
        }
    }
    
    @IBAction func signInAction(_ sender: Any) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Login", bundle: nil)
        let signInViewController = storyboard.instantiateViewController(withIdentifier: "JaldiSignInViewController") as? JaldiSignInViewController
        self.present(signInViewController!, animated: true, completion: nil)
    }
    
    //MARK: Configuration
    private func configureInputVievs() {
      zipInputView?.configureWith(onBoardingModel: onboardingModel, onBoardingState: .zip, onboardingInputViewDelegat: self)
      emailInputView?.configureWith(onBoardingModel: onboardingModel, onBoardingState: .email, onboardingInputViewDelegat: self)
    }
    
    //MARK: GestureRecognizer
    private func addRecognizer(){
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(HBOnboardingViewControllerViewController.handleTap(gestureRecognizer:)))
        view.addGestureRecognizer(gestureRecognizer)
    }
    func handleTap(gestureRecognizer: UIGestureRecognizer) {
       zipInputView?.resignActive()
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
        DispatchQueue.main.asyncAfter(deadline: .now() + 2 * duration, execute: {
            UIView.transition(with: self.introView!, duration: duration,
                              options: [.curveEaseIn, .transitionCrossDissolve], animations: {
                                self.introView.isHidden = true
            }, completion: {(finished) -> Void in })

        })
    }
    
    func keyboardWillHide(_ notification:Notification) {
        let info = (notification as NSNotification).userInfo!
        let animationDuration = (info[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue
    
        
        self.introViewTopConstraint.constant = 0
        UIView.animate(withDuration: animationDuration!, animations: { () -> Void in
            self.view.layoutIfNeeded()
        }, completion: { (finished) -> Void in
//            self.introView.isHidden = true
        })
        UIView.transition(with: introView!, duration: animationDuration!,
                          options: [.curveEaseOut, .transitionCrossDissolve], animations: {
                             self.introView.isHidden = self.activeState == .email
        }, completion: nil)
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
        switch state {
        case .zip:
            backButton.isHidden = true
            zipInputViewHorizontalCenterConstraint.constant = 0
            emailInputViewHorizontalCenterConstraint.constant = self.view.frame.size.width
        case .email:
            backButton.isHidden = false
            zipInputViewHorizontalCenterConstraint.constant = -self.view.frame.size.width
            emailInputViewHorizontalCenterConstraint.constant = 0
        }
    }

}

//MARK: JaldiOnboardingInputViewDelegate
extension HBOnboardingViewControllerViewController: JaldiOnboardingInputViewDelegate{
    func onboarding(inputView:JaldiOnboardingInputView, didBeginEditing textField:UITextField, onboardingState:OnBoardingState) {
    }
    
    func onboarding(inputView:JaldiOnboardingInputView, textFieldDidEndEditing textField:UITextField, onboardingState:OnBoardingState) {
        switch onboardingState {
        case .zip:
            onboardingModel.zip = textField.text
        case .email:
            onboardingModel.email = textField.text
       }
    }
    
    func onboarding(inputView:JaldiOnboardingInputView, didReturn textField:UITextField, onboardingState:OnBoardingState) {
        switch onboardingState {
        case .zip:
            self.activeState = .email
            emailInputView.becomeActive()
            self.configureWithActive(state: self.activeState, animated: true)
        case .email:
            self.emailInputView.resignActive()
            self.moveToNextScreen()
        }
    }
    fileprivate func moveToNextScreen() {
        if onboardingModel.canLoginAsGuest() {
            UserProfile.currentProfile.loginAsGuest(guest: onboardingModel)
        }else {
            let storyboard: UIStoryboard = UIStoryboard(name: "Login", bundle: nil)
            let notInYourAreaViewController = storyboard.instantiateViewController(withIdentifier: "JaldiNotInYourAreaViewController") as? JaldiNotInYourAreaViewController
            notInYourAreaViewController?.guest = self.onboardingModel
            self.navigationController?.pushViewController(notInYourAreaViewController!, animated: true)
        }
    }
}
