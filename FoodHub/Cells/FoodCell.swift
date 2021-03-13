//
//  FoodCell.swift
//  FoodHub
//
//  Created by Bhavesh Sharma on 13/03/21.
//

import Foundation
import UIKit

class FoodCell: UITableViewCell{
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var calogries: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var cellView: UIView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        img.image = nil
    }
    
    
    func configure(data: FoodData){
        cellView.clipsToBounds = true
        cellView.layer.cornerRadius = 12
        img.image = UIImage(named: data.img)
        name.text = data.name
        calogries.text = data.calogries + " Calories"
        price.text = "$\(data.price)"
    }
    
}
