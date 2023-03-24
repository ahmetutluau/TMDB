//
//  DetailDS.swift
//  NetflixClone
//
//  Created by Ahmet Utlu on 8.03.2023.
//

import UIKit

enum DetailDSStateChange: StateChange {
    case pushVC(String)
    case navigateToDetail(Int)
    case navigateToReviews(Int)
    case navigateToCastDetail(Int)
}

class DetailDS: StatefulDS<DetailDSStateChange> {
    var movie: DetailResponseModel?
    var trailers = [TrailerModel]()
    var cast = [Cast]()
    var similarMovies = [MoviesModel]()
    let sections = DetailSections.allCases
}

extension DetailDS: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section{
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: MovieInfoCell.reuseIdentifier, for: indexPath) as! MovieInfoCell
            if let movie = movie {
                cell.setupCell(movie: movie)
            }
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: OverViewCell.reuseIdentifier, for: indexPath) as! OverViewCell
            if let movie = movie {
                cell.setupCell(movie: movie)
            }
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: TrailersTableCell.reuseIdentifier, for: indexPath) as! TrailersTableCell
            cell.setupCell(trailers: trailers)
            cell.delegate = self
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: CastTableCell.reuseIdentifier, for: indexPath) as! CastTableCell
            cell.setupCell(cast: cast)
            cell.delegate = self
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: SimilarMoviesCell.reuseIdentifier, for: indexPath) as! SimilarMoviesCell
            cell.setupCell(movies: similarMovies)
            cell.delegate = self
            return cell
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: ReviewsCell.reuseIdentifier, for: indexPath) as! ReviewsCell
            if let movie = movie {
                cell.setCell(id: movie.id)
            }
            cell.delegate = self
            return cell
        default:
            return BaseTableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0: return CGFloat.dHeight * 160/1500
        case 5: return 0
        default: return CGFloat.dHeight * 40/1500
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0: return CGFloat.dHeight * 500/1500
        case 1: return UITableView.automaticDimension
        case 2: return CGFloat.dHeight * 290/1500
        case 3: return CGFloat.dHeight * 360/1500
        case 4: return CGFloat.dHeight * 350/1500
        case 5: return CGFloat.dHeight * 200/1500
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let frame: CGRect = tableView.frame
        let headerView: UIView = UIView(frame: CGRectMake(0, 0, frame.size.height, frame.size.width))
        headerView.backgroundColor = .clear
        
        let sectionLabel = UILabel(frame: .zero)
        switch section {
        case 0:
            sectionLabel.text = movie?.title
            sectionLabel.font = .systemFont(ofSize: 22, weight: .bold)
        default:
            sectionLabel.text = sections[section].rawValue
            sectionLabel.font = .systemFont(ofSize: 18, weight: .bold)
        }
        sectionLabel.textColor = .white
        
        headerView.addSubviews([sectionLabel])
        
        sectionLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(CGFloat.dWidth * 20/735)
            make.bottom.equalToSuperview()
        }
        
        return headerView
    }
}

extension DetailDS: TrailersTableCellProtocol, SimilarMoviesCellProtocol, ReviewsCellProtocol, CastTableCellProtocol {
    func navigateToCastDetail(id: Int) {
        self.emit(.navigateToCastDetail(id))
    }
    
    func navigateToReviews(id: Int) {
        self.emit(.navigateToReviews(id))
    }
    
    func navigateToDetail(id: Int) {
        self.emit(.navigateToDetail(id))
    }
    
    func pushVC(url: String) {
        self.emit(.pushVC(url))
    }
}
