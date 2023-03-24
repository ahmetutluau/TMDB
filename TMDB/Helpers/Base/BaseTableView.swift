//
//  BaseTableView.swift
//  NetflixClone
//
//  Created by Ahmet Utlu on 1.03.2023.
//

import UIKit

class BaseTableView: UITableView {
    
    convenience init(style: Style = .plain,
                     cells: [BaseTableViewCell.Type],
                     showsVerticalScrollIndicator: Bool = true,
                     separatorStyle: UITableViewCell.SeparatorStyle = .singleLine,
                     separatorColor: UIColor? = .gray,
                     separatorInset: UIEdgeInsets = .zero,
                     scrollIndicatorInsets: UIEdgeInsets = .zero,
                     backgroundColor: UIColor? = .white) {
        self.init(frame: .zero, style: style)
        
        self.separatorStyle = separatorStyle
        self.separatorColor = separatorColor
        self.separatorInset = separatorInset
        self.scrollIndicatorInsets = scrollIndicatorInsets
        self.showsVerticalScrollIndicator = showsVerticalScrollIndicator
        self.backgroundColor = backgroundColor
        
        for cell in cells {
            register(cell, forCellReuseIdentifier: cell.reuseIdentifier)
        }
    }
}


