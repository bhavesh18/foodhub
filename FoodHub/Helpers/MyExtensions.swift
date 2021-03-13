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


