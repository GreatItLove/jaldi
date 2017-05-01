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
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK: Actions
    @IBAction func backAction(_ sender: Any) {
    }
    
    @IBAction func signInAction(_ sender: Any) {
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
        NotificationCenter.default.addObserver(self, selector: #selector(HBOnboardingViewControllerViewController.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(HBOnboardingViewControllerViewController.keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    private func removeNotification(){
        NotificationCenter.default.removeObserver(self)
    }
    
    func keyboardWillShow(_ notification:Notification) {
        let info = (notification as NSNotification).userInfo!
        let animationDuration = (info[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue
        UIView.animate(withDuration: animationDuration!, animations: { () -> Void in
            self.introViewTopConstraint.constant = self.topView.frame.size.height - self.introView.frame.size.height
            
        }, completion: { (finished) -> Void in
            self.introView.isHidden = true
        })
    }
    
    func keyboardWillHide(_ notification:Notification) {
        let info = (notification as NSNotification).userInfo!
        let animationDuration = (info[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue
        
        UIView.animate(withDuration: animationDuration!, animations: { () -> Void in
            self.introViewTopConstraint.constant = 0
        }, completion: { (finished) -> Void in
            if self.activeState == .zip {
             self.introView.isHidden = false
            }else{
             self.introView.isHidden = true
            }
        })
    }
    //MARK: OnBoarding State
    
    deinit{
        removeNotification()
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
        
    }
}
