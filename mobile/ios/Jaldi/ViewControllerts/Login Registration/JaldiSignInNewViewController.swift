//
//  JaldiSignInNewViewController.swift
//  Jaldi
//
//  Created by Admin User on 7/18/17.
//  Copyright © 2017 Handybook. All rights reserved.
//

import UIKit

class JaldiSignInNewViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signInButton: UIButton!
    
    var canDismiss = true
    var userName : String?
    
    var activeTextField : UITextField? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.addRecognizer()
        self.configureRegisterButtonState()
        
       // emailTextField.text = userName
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
    
    private func configureRegisterButtonState(){
        self.signInButton.backgroundColor = AppColors.GrayColor
        self.signInButton.isEnabled = false
    }
    
    private func removeNotification(){
        NotificationCenter.default.removeObserver(self)
    }
    
    private func getProfile() {
        let task = JaldiGetProfileTask()
        task.execute(in: NetworkDispatcher.defaultDispatcher(), taskCompletion: { (user) in
            guard let user = user else {
                return
            }
            user.password = self.passwordTextField.text
            
            UserProfile.currentProfile.loginAsGuest(guest: user)
        }) { (error, _) in
            print(error ?? "Error")
        }
    }
    
    func handleTap(gestureRecognizer: UIGestureRecognizer){
        activeTextField?.resignFirstResponder()
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        activeTextField = textField
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == emailTextField{
            let newValue = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? string
            self.checkValidationAndChangeStateIfNeedFor(newValue: newValue)
        }
        return true
    }
    
    fileprivate func checkValidationAndChangeStateIfNeedFor(newValue: String) {
        let canReturn = JaldiValidator.isValidEmail(inputString: newValue)
        self.setRegisterButtonState(enabled: canReturn)
    }
    
    fileprivate func setRegisterButtonState(enabled: Bool){
        if enabled {
            signInButton.backgroundColor = AppColors.GreenColor
            signInButton.isEnabled = enabled
        } else {
            signInButton.backgroundColor = AppColors.GrayColor
            signInButton.isEnabled = enabled
        }
    }
    
    @IBAction func signInAction(_ sender: Any) {
        guard let userName = emailTextField.text, let password = passwordTextField.text else {
            return
        }
        
        self.showHudWithMsg(message: nil)
        let task = JaldiLoginTask(user: userName, password: password)
        task.execute(in: NetworkDispatcher.defaultDispatcher(), taskCompletion: { (value) in
            self.hideHud()
            self.view.endEditing(true)
            self.getProfile()
        }) { (error, _) in
            self.hideHud()
            print(error ?? "Error")
        }
    }
    
    @IBAction func registerAction(_ sender: Any) {
        self.dismiss(animated: true) {
        }
    }
    
    
    
    deinit{
        removeNotification()
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
