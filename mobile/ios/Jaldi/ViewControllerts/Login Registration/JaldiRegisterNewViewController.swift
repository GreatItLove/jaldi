//
//  JaldiRegisterNewViewController.swift
//  Jaldi
//
//  Created by Admin User on 7/17/17.
//  Copyright © 2017 Handybook. All rights reserved.
//

import UIKit

class JaldiRegisterNewViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var modelStackView: UIStackView!

    @IBOutlet weak var stackViewConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    @IBOutlet weak var finishButton: UIButton!
    
    var registrationModel : JaldiRegistration!
    var activeTextField : UITextField? = nil
    
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
    
    private func addNotification(){
        NotificationCenter.default.addObserver(self, selector: #selector(JaldiRegisterNewViewController.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(JaldiRegisterNewViewController.keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    private func configureRegisterButtonState(){
        self.finishButton.backgroundColor = AppColors.GrayColor
        self.finishButton.isEnabled = false
    }
    
    private func removeNotification(){
        NotificationCenter.default.removeObserver(self)
    }
    
    func keyboardWillShow(_ notification:Notification) {
        let info = (notification as NSNotification).userInfo!
        let animationDuration = (info[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue
        let keyboardSize = (info[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height
        let frame = view.convert((activeTextField?.frame.origin)!, from: activeTextField?.superview)
        let delta : CGFloat = 50.0
        if frame.y + delta <= self.view.frame.size.height - keyboardSize! {
            return
        }
        
        self.stackViewConstraint.constant = -100
        UIView.animate(withDuration: animationDuration!, animations: { () -> Void in
            //self.inputView?.isHidden = true
            self.view.layoutIfNeeded()
        }, completion: { (finished) -> Void in
        })
        
    }
    
    func keyboardWillHide(_ notification:Notification) {
        let info = (notification as NSNotification).userInfo!
        let animationDuration = (info[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue
        
        self.stackViewConstraint.constant = 0
        UIView.animate(withDuration: animationDuration!, animations: { () -> Void in
            self.view.layoutIfNeeded()
        }, completion: { (finished) -> Void in
        })
        
    }
    
    
    func handleTap(gestureRecognizer: UIGestureRecognizer){
        activeTextField?.resignFirstResponder()
    }

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        activeTextField = textField
        return true
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == self.emailTextField{
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
            finishButton.backgroundColor = AppColors.GreenColor
            finishButton.isEnabled = enabled
        } else {
            finishButton.backgroundColor = AppColors.GrayColor
            finishButton.isEnabled = enabled
        }
    }
    
    fileprivate func showSignInViewController(canDismiss: Bool, userName: String?){
        self.activeTextField?.resignFirstResponder()
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
    
    @IBAction func registerUser(_ sender: Any) {
        self.showHudWithMsg(message: nil)
        registrationModel.name = nameTextField.text
        registrationModel.email = emailTextField.text
        registrationModel.password = passwordTextField.text
        registrationModel.confirmPassword = confirmPasswordTextField.text
        
        let task  = JaldiRegistrationTask(registrationModel: registrationModel)
        task.execute(in: NetworkDispatcher.defaultDispatcher(), taskCompletion: { [weak self] (value) in
            self?.hideHud()
            guard let user  = value else{
                return
            }
            self?.showSignInViewController(canDismiss: false, userName: user.email)
            
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
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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
