//
//  JaldiForgotPasswordViewController.swift
//  Jaldi
//
//  Created by Grigori Jlavyan on 5/22/17.
//  Copyright © 2017 Handybook. All rights reserved.
//

import UIKit

class JaldiForgotPasswordViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var sendButtonBottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addRecognizer()
        self.addNotification()
        self.configureTextFields()
    }
    
    //MARK: Actions
    @IBAction func backeAction(_ sender: Any) {
       self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func sendForgotPasswordAction(_ sender: Any) {
      self.handleForgotPassword()
    }
    
    //MARK: Configurations
    private func configureTextFields() {
        emailTextField.placeholder = "Email"
        
    }
    //MARK: GestureRecognizer
    private func addRecognizer(){
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(JaldiForgotPasswordViewController.handleTap(gestureRecognizer:)))
        view.addGestureRecognizer(gestureRecognizer)
    }
    func handleTap(gestureRecognizer: UIGestureRecognizer) {
        self.emailTextField.resignFirstResponder()
    }
    
    //MARK: Notification
    private func addNotification(){
        NotificationCenter.default.addObserver(self, selector: #selector(JaldiForgotPasswordViewController.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(JaldiForgotPasswordViewController.keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    private func removeNotification(){
        NotificationCenter.default.removeObserver(self)
    }
    
    func keyboardWillShow(_ notification:Notification) {
        let info = (notification as NSNotification).userInfo!
        
        let kbFrame = info[UIKeyboardFrameEndUserInfoKey]
        let animationDuration = (info[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue
        let keyboardFrame = (kbFrame as? NSValue)?.cgRectValue
        let height = keyboardFrame!.size.height
        
        self.sendButtonBottomConstraint.constant = height
        
        UIView.animate(withDuration: animationDuration!, animations: { () -> Void in
            self.view.layoutIfNeeded()
        }, completion: { (finished) -> Void in
            
        })
    }
    
    func keyboardWillHide(_ notification:Notification) {
        let info = (notification as NSNotification).userInfo!
        let animationDuration = (info[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue
        
        self.sendButtonBottomConstraint.constant = 0
        UIView.animate(withDuration: animationDuration!, animations: { () -> Void in
            self.view.layoutIfNeeded()
        }, completion: { (finished) -> Void in
        })
    }
    //MARK: Handle Sending Forgot Password
    private func handleForgotPassword() {
        guard let userName = emailTextField.text  else {
            return
        }
        let isValidMail = JaldiValidator.isValidEmail(inputString: userName)
        if !isValidMail {
          self.showAlertWith(title: nil, message: NSLocalizedString("ForgotPasswordInvalidEmailMessage", comment: ""))
            return
        }
        let task  = JaldiForgotTask(email: userName)
        task.execute(in: NetworkDispatcher.defaultDispatcher(), taskCompletion: { (value) in
            self.navigationController?.popViewController(animated: true)
        }) { (error, _) in
            print(error ?? "Error")
            self.showAlertWith(title: nil, message: NSLocalizedString("TryAgainMessage", comment: ""))
        }
    }
    
    deinit{
        removeNotification()
    }
    
}
