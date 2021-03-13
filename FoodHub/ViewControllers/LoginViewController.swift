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
    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var confPasswordTF: UITextField!
    
    @IBOutlet weak var nameStackView: UIStackView!
    @IBOutlet weak var confPassStackView: UIStackView!
    
    @IBOutlet weak var loginBtn: UIButton!
    
    //MARK:- variables
    var selectedSegment = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        
    }
    
    func setupView(){
        
        wallpaperIV.layer.cornerRadius = 30
        segment.setTitleColor(.white, state: .selected)
        confPassStackView.isHidden = true
        nameStackView.isHidden = true
        loginBtn.layer.cornerRadius = 12
    }

    func resetData(){
        emailTF.text = ""
        passwordTF.text = ""
        confPasswordTF.text = ""
    }
    
    //MARK:- IBActions
    
    @IBAction func onSegmentTap(_ sender: UISegmentedControl) {
        resetData()
        self.selectedSegment = sender.selectedSegmentIndex
        confPassStackView.isHidden = sender.selectedSegmentIndex == 0
        nameStackView.isHidden = sender.selectedSegmentIndex == 0
        loginBtn.setTitle(sender.selectedSegmentIndex == 0 ? "Login" : "Sign up", for: .normal)
    }
    
    @IBAction func onLoginTap(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
}
