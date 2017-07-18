//
//  JaldiRegistrationNewViewController.swift
//  Jaldi
//
//  Created by Admin User on 7/17/17.
//  Copyright © 2017 Handybook. All rights reserved.
//

import UIKit

class JaldiRegistrationNewViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var introView: UIView!

    @IBOutlet weak var introViewTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    
    fileprivate var registrationModel : JaldiRegistration = JaldiRegistration()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addRecognizer()
        self.addNotification()
        self.configureRegisterButtonState()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func addRecognizer(){
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(JaldiRegistrationNewViewController.handleTap(gestureRecognizer:)))
        view.addGestureRecognizer(gestureRecognizer)
    }
    
    func handleTap(gestureRecognizer: UIGestureRecognizer){
        phoneNumberTextField.resignFirstResponder()
    }
    
    private func addNotification(){
        NotificationCenter.default.addObserver(self, selector: #selector(JaldiRegistrationNewViewController.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(JaldiRegistrationNewViewController.keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    private func configureRegisterButtonState(){
        self.registerButton.backgroundColor = AppColors.GrayColor
        self.registerButton.isEnabled = false
    }
    
    private func removeNotification(){
        NotificationCenter.default.removeObserver(self)
    }
    
    func keyboardWillShow(_ notification:Notification) {
        let info = (notification as NSNotification).userInfo!
        let animationDuration = (info[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue
        
        self.introViewTopConstraint.constant = -100
        UIView.animate(withDuration: animationDuration!, animations: { () -> Void in
            self.inputView?.isHidden = true
            self.view.layoutIfNeeded()
        }, completion: { (finished) -> Void in
        })
        
        let duration = animationDuration! / 3
        DispatchQueue.main.asyncAfter(deadline: .now() + 2 * duration, execute: {
            UIView.transition(with: self.introView!, duration: duration, options: [.curveEaseIn, .transitionCrossDissolve], animations: {
                self.introView.isHidden = true
            }, completion: { (finished) in
                
            })
        })
        
    }
    
    func keyboardWillHide(_ notification:Notification) {
        let info = (notification as NSNotification).userInfo!
        let animationDuration = (info[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue
        
        self.introViewTopConstraint.constant = 0
        UIView.animate(withDuration: animationDuration!, animations: { () -> Void in
            self.view.layoutIfNeeded()
        }, completion: { (finished) -> Void in
        })
        
        let duration = animationDuration! / 3
        DispatchQueue.main.asyncAfter(deadline: .now() + 2 * duration, execute: {
            UIView.transition(with: self.introView!, duration: duration, options: [.curveEaseIn, .transitionCrossDissolve], animations: {
                self.introView.isHidden = false
            }, completion: { (finished) in
                
            })
        })
    }
    //MARK: OnBoarding State
    
    deinit{
        removeNotification()
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if ((textField.text?.characters.count)! > 13 && string.characters.count > 0){
            return false
        }
        if string.characters.count == 0 {
            if let text = textField.text as NSString?{
                let strippedNumber = text.replacingOccurrences(of: "[^0-9,+]", with: "", options: NSString.CompareOptions.regularExpression, range: NSMakeRange(0, text.length)) as NSString
                if strippedNumber.length <= 4{
                    return false
                }
            }
            let newValue = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? string
            self.checkValidationAndChangeStateIfNeedFor(newValue: newValue)
            return true
            
        }
        if JaldiValidator.isNumeric(inputString: string){
            let newValue = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? string
            textField.text = JaldiValidator.correct(phoneNumber: newValue)
            self.checkValidationAndChangeStateIfNeedFor(newValue: textField.text!)
        }
        return false
    }
    
    fileprivate func checkValidationAndChangeStateIfNeedFor(newValue: String) {
        let isValid = JaldiValidator.isValid(phone: newValue)
        self.setRegisterButtonState(enabled: isValid)
    }
    
    fileprivate func setRegisterButtonState(enabled: Bool){
        if enabled {
            registerButton.backgroundColor = AppColors.GreenColor
            registerButton.isEnabled = enabled
        } else {
            registerButton.backgroundColor = AppColors.GrayColor
            registerButton.isEnabled = enabled
        }
    }
    
    fileprivate func showSignInViewController(canDismiss: Bool, userName: String?){
        self.phoneNumberTextField?.resignFirstResponder()
        let storyboard : UIStoryboard = UIStoryboard(name: "Login", bundle: nil)
        let signInNewViewController = storyboard.instantiateViewController(withIdentifier: "JaldiSignInNewViewController") as? JaldiSignInNewViewController
        signInNewViewController?.canDismiss = canDismiss
        signInNewViewController?.userName = userName
        let navController = UINavigationController(rootViewController: signInNewViewController!)
        navController.isNavigationBarHidden = true
        self.present(navController, animated: true, completion: nil)
    }
        
    fileprivate func showConfirmationNewViewController(canDismiss: Bool, userName: String?){
        let storyboard : UIStoryboard = UIStoryboard(name: "Login", bundle: nil)
        let confirmationNewViewController = storyboard.instantiateViewController(withIdentifier: "JaldiConfirmationNewViewController") as? JaldiConfirmationNewViewController
        confirmationNewViewController?.canDismiss = canDismiss
        confirmationNewViewController?.userName = userName
        confirmationNewViewController?.registrationModel = registrationModel
        self.navigationController?.pushViewController(confirmationNewViewController!, animated: true)
    }
    
    @IBAction func signInAction(_ sender : Any ){
        self.showSignInViewController(canDismiss: true, userName: nil)
    }
    
    @IBAction func verifyPhoneAndMoveToNextScreen(_ sender: Any) {
        guard let phone = registrationModel.recipient else {
            return
        }
//        self.showConfirmationNewViewController(canDismiss: true, userName: nil)
//        return
        self.showHudWithMsg(message: nil)
        let task = JaldiSendVerificationTask(recipient: phone)
        task.execute(in: NetworkDispatcher.defaultDispatcher(), taskCompletion: { [weak self] (value) in
            guard let mobileVerification = value else {
                return
            }
            self?.registrationModel.mobileVerification = mobileVerification
            self?.showConfirmationNewViewController(canDismiss: true, userName: nil)
            self?.hideHud()
        }) { [weak self] (error, _) in
            self?.hideHud()
            if let error = error {
                if case NetworkErrors.networkMessage(error_: _, message: let message) = error {
                    self?.showAlertWith(title: NSLocalizedString("Error", comment: ""), message: message)
                } else {
                    self?.showAlertWith(title: NSLocalizedString("Error", comment: ""), message: NSLocalizedString("PhoneIsNotVerifiedMessage", comment: ""))
                }
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
