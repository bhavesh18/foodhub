//
//  FoodDetailViewController.swift
//  FoodHub
//
//  Created by Bhavesh Sharma on 13/03/21.
//

import UIKit

class FoodDetailViewController: UIViewController {

    var foodData: FoodData!
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var calories: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var detail: UILabel!
    
    @IBOutlet weak var quantity: UILabel!
    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var cartBtn: UIButton!
    
    var totalQuantity: Int = 0
    var totalAmount: Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    func setupView(){
        backView.layer.cornerRadius = 25
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        backView.addGestureRecognizer(tap)
        backView.isUserInteractionEnabled = true
        img.image = UIImage(named: foodData.img)
        name.text = foodData.name
        calories.text = foodData.calogries + " calories"
        detail.text = foodData.detail
        price.text = "$\(foodData.price)"
        quantity.text = foodData.name + " (x\(totalQuantity))"
        totalPrice.text = "$"+String(totalAmount)
        cartBtn.isEnabled = false
        cartBtn.layer.opacity = 0.5
        cartBtn.layer.cornerRadius = 12
    }
    
    @objc func handleTap(){
        dismiss(animated: true)
    }
    
    //MARK:- IBActions
    @IBAction func onStepperTap(_ sender: UIStepper) {
        cartBtn.isEnabled = sender.value > 0
        cartBtn.layer.opacity = sender.value > 0 ? 1.0 : 0.5
        totalQuantity = Int(sender.value)
        quantity.text = foodData.name + "(x\(totalQuantity))"
        totalAmount = Double(totalQuantity)*foodData.price
        totalPrice.text = "$"+String(totalAmount)
    }
    
    @IBAction func addToCart(_ sender: UIButton) {
        
        dismiss(animated: true)
    }
    
}
