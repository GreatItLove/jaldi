//
//  JaldiSignInViewController.swift
//  Jaldi
//
//  Created by Grigori Jlavyan on 5/1/17.
//  Copyright © 2017 Handybook. All rights reserved.
//

import UIKit

class JaldiSignInViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var dismissButton: UIButton!

    @IBOutlet weak var signInButtonBottomConstraint: NSLayoutConstraint!
    
    var canDismiss = true
    var userName:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addRecognizer()
        self.addNotification()
        self.configureTextFields()
        dismissButton.isHidden = !canDismiss
        emailTextField.text = userName
    }

    //MARK: Actions
    @IBAction func closeAction(_ sender: Any) {
        self.dismiss(animated: true) {
        }
    }
    
    @IBAction func signInAction(_ sender: Any) {
        guard let userName = emailTextField.text, let password = passwordTextField.text  else {
            return
        }
        let isValidMail = JaldiValidator.isValidEmail(inputString: userName)
        if !isValidMail {
            self.showAlertWith(title: nil, message: NSLocalizedString("ForgotPasswordInvalidEmailMessage", comment: ""))
            return
        }
        
        self.showHudWithMsg(message: nil)
        let task  = JaldiLoginTask(user: userName, password: password)
        task.execute(in: NetworkDispatcher.defaultDispatcher(), taskCompletion: { (value) in
            self.hideHud()
            self.view.endEditing(true)
            self.getProfile()
//            UserProfile.currentProfile.loginAsGuest(guest: user)
        }) { (error, _) in
            self.hideHud()
            print(error ?? "Error")
        }
    }

    @IBAction func forgotPasswordAction(_ sender: Any) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Login", bundle: nil)
        let forgotPasswordViewController = storyboard.instantiateViewController(withIdentifier: "JaldiForgotPasswordViewController") as? JaldiForgotPasswordViewController
        self.navigationController?.pushViewController(forgotPasswordViewController!, animated: true)
    }

    private func getProfile() {
        let task  = JaldiGetProfileTask()
        task.execute(in: NetworkDispatcher.defaultDispatcher(), taskCompletion: { (user) in
            guard let user = user else{
              return
            }
            user.password = self.passwordTextField.text
            UserProfile.currentProfile.loginAsGuest(guest: user)

        }) { (error, _) in
            print(error ?? "Error")
        }
    }
    
    //MARK: Configurations
    private func configureTextFields() {
      emailTextField.placeholder = "Email"
      emailTextField.keyboardType = .emailAddress
      passwordTextField.placeholder = "Password"
    }
    //MARK: GestureRecognizer
    private func addRecognizer(){
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(JaldiSignInViewController.handleTap(gestureRecognizer:)))
        view.addGestureRecognizer(gestureRecognizer)
    }
    func handleTap(gestureRecognizer: UIGestureRecognizer) {
        self.emailTextField.resignFirstResponder()
        self.passwordTextField.resignFirstResponder()
    }
    
    //MARK: Notification
    private func addNotification(){
        NotificationCenter.default.addObserver(self, selector: #selector(JaldiSignInViewController.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(JaldiSignInViewController.keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
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
        
        self.signInButtonBottomConstraint.constant = height
    
        UIView.animate(withDuration: animationDuration!, animations: { () -> Void in
            self.view.layoutIfNeeded()
        }, completion: { (finished) -> Void in
            
        })
    }
    
    func keyboardWillHide(_ notification:Notification) {
        let info = (notification as NSNotification).userInfo!
        let animationDuration = (info[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue
        
         self.signInButtonBottomConstraint.constant = 0
        UIView.animate(withDuration: animationDuration!, animations: { () -> Void in
            self.view.layoutIfNeeded()
        }, completion: { (finished) -> Void in
        })
    }
    
    deinit{
        removeNotification()
    }

}
