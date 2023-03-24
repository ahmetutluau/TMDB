//
//  Date+Ext.swift
//  NetflixClone
//
//  Created by Ahmet Utlu on 21.03.2023.
//

import UIKit

extension Date {
    func toString(withFormat format: String = "dd/MM/yyyy") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let dateString = dateFormatter.string(from: self)
        return dateString
    }
}
