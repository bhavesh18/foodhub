//
//  LoginViewController.swift
//  FoodHub
//
//  Created by Bhavesh Sharma on 13/03/21.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var wallpaperIV: UIImageView!
    @IBOutlet weak var segment: UISegmentedControl!
    
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var confPasswordTF: UITextField!
    
    @IBOutlet weak var nameStackView: UIStackView!
    @IBOutlet weak var phoneStackView: UIStackView!
    @IBOutlet weak var confPassStackView: UIStackView!
    
    @IBOutlet weak var loginBtn: UIButton!
    
    //MARK:- variables
    var selectedSegment = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if(SessionManager.i.localData.isLoggedIn){
            goToHomeScreen()
        }
    }
    
    
    func setupView(){
        //setting up view layouts
        wallpaperIV.layer.cornerRadius = 30
        segment.setTitleColor(.white, state: .selected)
        confPassStackView.isHidden = true
        nameStackView.isHidden = true
        phoneStackView.isHidden = true
        loginBtn.layer.cornerRadius = 12
    }

    //resetting data to default state
    func resetData(){
        emailTF.text = ""
        passwordTF.text = ""
        phoneTF.text = ""
        confPasswordTF.text = ""
    }
    
    func goToHomeScreen(){
        SessionManager.i.save()
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    func isValidEntry() -> Bool{
        if(selectedSegment == 0){
            //login
            if(emailTF.text == ""){
                showAlert(msg: "Email is empty")
                return false
            }else if(!emailTF.text!.isValidEmail()){
                showAlert(msg: "Inavlid email format")
                return false
            }else if(passwordTF.text == ""){
                showAlert(msg: "Password is empty")
                return false
            }
        }else{
            //signup
            if(nameTF.text == ""){
                showAlert(msg: "Name is empty")
                return false
            }else if(emailTF.text == ""){
                showAlert(msg: "Email is empty")
                return false
            }else if(!emailTF.text!.isValidEmail()){
                showAlert(msg: "Inavlid email format")
                return false
            }else if(phoneTF.text == ""){
                showAlert(msg: "Phone is empty")
                return false
            }else if(passwordTF.text == ""){
                showAlert(msg: "Password is empty")
                return false
            }else if(confPasswordTF.text == ""){
                showAlert(msg: "Confirm Password is empty")
                return false
            }else if(passwordTF.text != confPasswordTF.text){
                showAlert(msg: "Password does not match")
                return false
            }
        }
        return true
    }
    
    //MARK:- IBActions
    
    @IBAction func onSegmentTap(_ sender: UISegmentedControl) {
        resetData()
        self.selectedSegment = sender.selectedSegmentIndex
        confPassStackView.isHidden = sender.selectedSegmentIndex == 0
        nameStackView.isHidden = sender.selectedSegmentIndex == 0
        phoneStackView.isHidden = sender.selectedSegmentIndex == 0
        loginBtn.setTitle(sender.selectedSegmentIndex == 0 ? "Login" : "Sign up", for: .normal)
    }
    
    @IBAction func onLoginTap(_ sender: UIButton) {
        
        let localData = SessionManager.i.localData
        if(self.selectedSegment == 0){
            //login
            if(isValidEntry() && localData.users.contains(where: ({$0.email == self.emailTF.text! && $0.password == self.passwordTF.text!}))){
                let userData = UserData()
                let matchedUser = localData.users.first(where: ({$0.email == emailTF.text!}))!
                userData.name = matchedUser.name
                userData.phone = matchedUser.phone
                userData.email = emailTF.text!
                userData.password = passwordTF.text!
                localData.currentUser = userData
                goToHomeScreen()
            }else{
                showAlert(msg: "Invalid Email or password.")
            }
        }else{
            //signup
            if(isValidEntry() && localData.users.contains(where: ({$0.email.lowercased() == self.emailTF.text!.lowercased()}))){
                showAlert(msg: "Email already exists.")
            }else{
                if(isValidEntry()){
                    let userData = UserData()
                    userData.name = self.nameTF.text!
                    userData.email = self.emailTF.text!
                    userData.phone = self.phoneTF.text!
                    userData.password = self.passwordTF.text!
                    localData.users.append(userData)
                    localData.currentUser = userData
                    goToHomeScreen()
                }
            }
        }
        
    }
    
}
