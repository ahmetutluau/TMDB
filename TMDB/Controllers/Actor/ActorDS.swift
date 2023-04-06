//
//  ActorDS.swift
//  NetflixClone
//
//  Created by Ahmet Utlu on 14.03.2023.
//

import UIKit

enum ActorDSStateChange: StateChange {
    case navigateToAll
    case navigateToDetail(Int)
}

class ActorDS: StatefulDS<ActorDSStateChange> {
    var biography: String?
    var name: String?
    var actedMovies = [ActedMoviesModel]()
    var allActedMovies = [ActedMoviesModel]()
    var photos = [Profile]()
    var movies = [MoviesModel]()
    
    
}

extension ActorDS: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: ImagesTableCell.reuseIdentifier, for: indexPath) as! ImagesTableCell
            cell.setCell(images: photos)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: BiographyTableCell.reuseIdentifier, for: indexPath) as! BiographyTableCell
            cell.setupCell(bio: biography ?? "Biography Couldn't Found")
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: ActedMoviesTableCell.reuseIdentifier, for: indexPath) as! ActedMoviesTableCell
            cell.setCell(movies: actedMovies)
            cell.delegate = self
            return cell
        default: return BaseTableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 1: return UITableView.automaticDimension
        case 2: return CGFloat.dHeight * 350/1500
        case 0: return CGFloat.dHeight * 650/1500
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 1,2: return CGFloat.dHeight * 40/1500
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let frame: CGRect = tableView.frame
        let headerView: UIView = UIView(frame: CGRectMake(0, 0, frame.size.height, frame.size.width))
        headerView.backgroundColor = .clear
        
        let sectionLabel = UILabel(frame: .zero)
        switch section {
        case 1:
            sectionLabel.text = "Biography"
        case 2:
            sectionLabel.text = "Acting"
        default:
            break
        }
        sectionLabel.font = .systemFont(ofSize: 18, weight: .bold)
        sectionLabel.textColor = .white
        
        headerView.addSubviews([sectionLabel])
        
        sectionLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(CGFloat.dWidth * 20/735)
            make.bottom.equalToSuperview()
        }
        
        return headerView
    }
}

extension ActorDS: ActedMoviesCellProtocol {
    func navigateToDetail(id: Int) {
        self.emit(.navigateToDetail(id))
    }
    
    func navigateToAll() {
        self.emit(.navigateToAll)
    }
}
