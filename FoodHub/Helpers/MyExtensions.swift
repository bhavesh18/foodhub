//
//  MyExtensions.swift
//  FoodHub
//
//  Created by Bhavesh Sharma on 13/03/21.
//

import UIKit

extension UISegmentedControl {

    func setTitleColor(_ color: UIColor, state: UIControl.State = .normal) {
        var attributes = self.titleTextAttributes(for: state) ?? [:]
        attributes[.foregroundColor] = color
        self.setTitleTextAttributes(attributes, for: state)
    }
    
}

extension Encodable{
    func getJsonString() -> String?{
        do{
            let jsonEncoder = JSONEncoder()
            let jsonData = try jsonEncoder.encode(self)
            if let json = String(data: jsonData, encoding: String.Encoding.utf8){
                return json
            }
        }catch{ }
        return nil
    }
}

extension String{
    func getObject<T: Decodable>(ofType type: T) -> T?{
        do{
            if let data = self.data(using: .utf8){
                let obj = try JSONDecoder().decode(T.self, from: data)
                return obj
            }
        }catch{
            
        }
        return nil
    }
    
    func isValidEmail() -> Bool {
            // here, `try!` will always succeed because the pattern is valid
            let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
            return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
        }
    
    func safelyLimitedTo(length n: Int)->String {
        if (self.count <= n) {
            return self
        }
        return String( Array(self).prefix(upTo: n) )
    }

    
}

extension UIView{

    @IBInspectable var cornerRadius: CGFloat {
        get{
            return layer.cornerRadius
        }
        set{
            self.layer.cornerRadius = newValue
            self.clipsToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
}

extension UIViewController{
    func showAlert(msg: String, handler: (()->())? = nil){
        let alert = UIAlertController(title: msg, message: "", preferredStyle: UIAlertController.Style.alert)

                // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default,handler: { (action) in
            handler?()
        }))

                // show the alert
                self.present(alert, animated: true, completion: nil)
    }

    func hideKeyboard(){
        self.view.endEditing(true)
    }
    
    func getTimestamp()->String {
        let timestamp = DateFormatter.localizedString(from: Date(), dateStyle: .medium, timeStyle: .short)
        return timestamp
    }
}


private var __maxLengths = [UITextField: Int]()

extension UITextField {
    @IBInspectable var maxLength: Int {
        get {
            guard let l = __maxLengths[self] else {
                return 150 // (global default-limit. or just, Int.max)
            }
            return l
        }
        set {
            __maxLengths[self] = newValue
            addTarget(self, action: #selector(fix), for: .editingChanged)
        }
    }
    
     @objc func fix(textField: UITextField) {
        let t = textField.text
        textField.text = t?.safelyLimitedTo(length: maxLength)
    }
    
}
