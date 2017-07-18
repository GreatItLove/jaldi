//
//  JaldiConfirmationNewViewController.swift
//  Jaldi
//
//  Created by Admin User on 7/17/17.
//  Copyright © 2017 Handybook. All rights reserved.
//

import UIKit

class JaldiConfirmationNewViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var introView: UIView!
    
    @IBOutlet weak var introViewTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var confirmationCodeTextField: UITextField!
    @IBOutlet weak var confirmButton: UIButton!
    
    var registrationModel : JaldiRegistration!
    
    var canDismiss = true
    var userName : String?
    
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
        confirmationCodeTextField.resignFirstResponder()
    }
    
    private func addNotification(){
        NotificationCenter.default.addObserver(self, selector: #selector(JaldiConfirmationNewViewController.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(JaldiConfirmationNewViewController.keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    private func configureRegisterButtonState(){
        self.confirmButton.backgroundColor = AppColors.GrayColor
        self.confirmButton.isEnabled = false
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
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newValue = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? string
        self.checkValidationAndChangeStateIfNeedFor(newValue: newValue)
        return true
    }
    //MARK: OnBoarding State
    
    deinit{
        removeNotification()
    }
    
    fileprivate func checkValidationAndChangeStateIfNeedFor(newValue: String) {
        self.setRegisterButtonState(enabled: true)
    }
    
    fileprivate func setRegisterButtonState(enabled: Bool){
        if enabled {
            confirmButton.backgroundColor = AppColors.GreenColor
            confirmButton.isEnabled = enabled
        } else {
            confirmButton.backgroundColor = AppColors.GrayColor
            confirmButton.isEnabled = enabled
        }
    }
    
    fileprivate func showConfirmationNewViewController(canDismiss: Bool, userName: String?){
        let storyboard : UIStoryboard = UIStoryboard(name: "Login", bundle: nil)
        let registerNewViewController = storyboard.instantiateViewController(withIdentifier: "JaldiRegisterNewViewController") as? JaldiRegisterNewViewController
        registerNewViewController?.canDismiss = canDismiss
        registerNewViewController?.userName = userName
        registerNewViewController?.registrationModel = registrationModel
        self.navigationController?.pushViewController(registerNewViewController!, animated: true)
    }
    
    fileprivate func showSignInViewController(canDismiss: Bool, userName: String?){
        self.confirmationCodeTextField?.resignFirstResponder()
        let storyboard : UIStoryboard = UIStoryboard(name: "Login", bundle: nil)
        let signInNewViewController = storyboard.instantiateViewController(withIdentifier: "JaldiSignInNewViewController") as? JaldiSignInNewViewController
        signInNewViewController?.canDismiss = canDismiss
        signInNewViewController?.userName = userName
        let navController = UINavigationController(rootViewController: signInNewViewController!)
        navController.isNavigationBarHidden = true
        self.present(navController, animated: true, completion: nil)
    }
    
    @IBAction func signInAction(_ sender : Any ){
        self.showSignInViewController(canDismiss: true, userName: nil)
    }
    
    @IBAction func verifyConfirmationCodeAndMoveToNextScreen(_ sender: Any) {
        registrationModel.confirmationCode = confirmationCodeTextField.text
        if registrationModel.isConfirmationCodeValid {
            self.showConfirmationNewViewController(canDismiss: true, userName: nil)
            
        } else {
            self.showAlertWith(title: NSLocalizedString("Error", comment: ""), message: NSLocalizedString("WrongVerificationCodeMessage", comment: ""))
        }
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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
