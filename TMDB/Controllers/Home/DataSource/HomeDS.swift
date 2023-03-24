//
//  HomeDS.swift
//  NetflixClone
//
//  Created by Ahmet Utlu on 1.03.2023.
//

import UIKit

enum HomeDSStateChange: StateChange {
    case pushToDetail(Int)
    case getAll(Int)
    
}

class HomeDS: StatefulDS<HomeDSStateChange> {
    var popularMovies = [MoviesModel]()
    var topRatedMovies = [MoviesModel]()
    var nowPlayingMovies = [MoviesModel]()
    var upComingMovies = [MoviesModel]()
    let sections = HomeSections.allCases
    
    @objc private func getAll(sender: UIButton) {
        self.emit(.getAll(sender.tag))
    }
}

extension HomeDS: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].rawValue
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableCell.reuseIdentifier, for: indexPath) as! HomeTableCell
        
        cell.delegate = self
        
        switch indexPath.section {
        case 0:
            cell.setCell(movies: popularMovies, section: 0)
        case 1:
            cell.setCell(movies: topRatedMovies, section: 1)
        case 2:
            cell.setCell(movies: nowPlayingMovies, section: 2)
        case 3:
            cell.setCell(movies: upComingMovies, section: 3)
        default:
            break
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat.dHeight * (380/1500)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        CGFloat.dHeight * 50/1500
    }
        
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let frame: CGRect = tableView.frame
        let headerView: UIView = UIView(frame: CGRectMake(0, 0, frame.size.height, frame.size.width))
        headerView.backgroundColor = .clear
        
        let allButton = UIButton(frame: .zero)
        allButton.backgroundColor = .white
        allButton.layer.cornerRadius = CGFloat.dWidth * 20/735
        allButton.setTitle("All", for: .normal)
        allButton.titleLabel?.font = .systemFont(ofSize: 12, weight: .bold)
        allButton.setTitleColor(.black, for: .normal)
        allButton.addTarget(self, action: #selector(getAll), for: .touchUpInside)
        
        let sectionLabel = UILabel(frame: .zero)
        sectionLabel.text = sections[section].rawValue
        sectionLabel.textColor = .white
        sectionLabel.font = .systemFont(ofSize: 18, weight: .bold)
        
        headerView.addSubviews([allButton,sectionLabel])
        
        allButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-CGFloat.dWidth * 20/735)
            make.height.equalTo(CGFloat.dHeight * 50/1500)
            make.width.equalTo(CGFloat.dWidth * 80/735)
        }
        
        sectionLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(CGFloat.dWidth * 20/735)
        }
        
        allButton.isHidden = section == 2
        allButton.tag = section
        
        return headerView
    }
}

extension HomeDS: HomeTableCellProtocol {
    func pushToDetail(id: Int) {
        self.emit(.pushToDetail(id))
    }
}
