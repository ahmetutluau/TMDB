//
//  ReviewsDS.swift
//  NetflixClone
//
//  Created by Ahmet Utlu on 13.03.2023.
//

import Foundation
import UIKit

enum ReviewsDSStateChange: StateChange {
    
}

class ReviewsDS: StatefulDS<ReviewsDSStateChange> {
    var reviews = [ReviewsModel]()
}

extension ReviewsDS: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        reviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ReviewsDetailTableCell.reuseIdentifier, for: indexPath) as! ReviewsDetailTableCell
        cell.setCell(model: reviews[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
