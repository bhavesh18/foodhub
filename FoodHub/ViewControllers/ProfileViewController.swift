//
//  ProfileViewController.swift
//  FoodHub
//
//  Created by Bhavesh Sharma on 13/03/21.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var img: UIImageView!
    
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var updateBtn: UIButton!
    @IBOutlet weak var logoutBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
    }
    
    func setupView(){
        img.layer.cornerRadius = 20
        updateBtn.layer.cornerRadius = 20
        logoutBtn.layer.cornerRadius = 20
        
        let ud = SessionManager.i.localData.currentUser
        nameTF.text = ud.name
        emailTF.text = ud.email
        phoneTF.text = ud.phone
    }
    
    
    //MARK:- IBOutlets
    
    @IBAction func update(_ sender: UIButton) {
    
    }
    
    @IBAction func logout(_ sender: UIButton) {
        SessionManager.i.localData.isLoggedIn = false
        SessionManager.i.save()
        self.view.window!.rootViewController?.dismiss(animated: true)
    }
    
}
