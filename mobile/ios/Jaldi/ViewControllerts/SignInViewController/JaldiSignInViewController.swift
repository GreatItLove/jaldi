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

    @IBOutlet weak var signInButtonBottomConstraint: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addRecognizer()
        self.addNotification()
        self.configureTextFields()
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
        
        let task  = JaldiLoginTask(user: userName, password: password)
        task.execute(in: NetworkDispatcher.defaultDispatcher(), taskCompletion: { (value) in
            let user  = JaldiUser.emptyUser()
            user.email = userName
            user.password = password
//            UserProfile.currentProfile.loginAsGuest(guest: user)
        }) { (error, _) in
            print(error ?? "Error")
        }
    }

    @IBAction func forgotPasswordAction(_ sender: Any) {
        self.handleForgotPassword()
//        self.getProfile()
//        self.sendVerification()
    }
    private func handleForgotPassword() {
        let task  = JaldiForgotTask(email: "sedrak.dalaloyan@yandex.ru")
        task.execute(in: NetworkDispatcher.defaultDispatcher(), taskCompletion: { (value) in
            
        }) { (error, _) in
            print(error ?? "Error")
        }
    }
    
    private func getProfile() {
        let task  = JaldGetProfileTask()
        task.execute(in: NetworkDispatcher.defaultDispatcher(), taskCompletion: { (value) in
            
        }) { (error, _) in
            print(error ?? "Error")
        }
    }
    
    //MARK: Configurations
    private func configureTextFields() {
      emailTextField.placeholder = "Email"
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
