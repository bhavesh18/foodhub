//
//  CartViewController.swift
//  FoodHub
//
//  Created by Bhavesh Sharma on 13/03/21.
//

import UIKit

class CartViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyCartLabel: UILabel!
    @IBOutlet weak var placeOrderBtn: UIButton!
    
    var cartList:[FoodData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView(){
        cartList = SessionManager.i.localData.cartList
        tableView.dataSource = self
        handleOrderBtnState()
    }
    
    func handleOrderBtnState(){
        if(cartList.isEmpty){
            placeOrderBtn.layer.opacity = 0.5
            placeOrderBtn.isEnabled = false
            emptyCartLabel.isHidden = false
        }else{
            placeOrderBtn.layer.opacity = 1
            placeOrderBtn.isEnabled = true
            emptyCartLabel.isHidden = true
        }
    }
    
    @IBAction func onCloseTap(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func placeOrder(_ sender: UIButton) {
        if let userIndex = SessionManager.i.getCurrentUserIndex(){
            var newList:[FoodData] = []
            self.cartList.forEach { (f) in
                f.date = getTimestamp()
                newList.append(f)
            }
            dump(newList)
            SessionManager.i.localData.users[userIndex].orderHistory.append(contentsOf: newList)
            SessionManager.i.localData.currentUser.orderHistory.append(contentsOf: newList)
            dump(SessionManager.i.localData.currentUser.orderHistory)
            SessionManager.i.localData.cartList = []
            SessionManager.i.save()
            showAlert(msg: "Order Successfull!!") {
                self.dismiss(animated: true)
            }
        }
    }
}

extension CartViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartCell", for: indexPath) as! CartCell
        cell.configure(data: cartList[indexPath.row], index: indexPath.row)
        cell.onRemove = { index in
            self.cartList.remove(at: index)
            SessionManager.i.localData.cartList = self.cartList
            SessionManager.i.save()
            self.handleOrderBtnState()
            self.tableView.reloadData()
        }
        return cell
    }
    
    
}
