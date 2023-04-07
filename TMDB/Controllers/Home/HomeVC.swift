//
//  HomeVC.swift
//  NetflixClone
//
//  Created by Ahmet Utlu on 1.03.2023.
//

import UIKit

class HomeVC: BaseVC {
    
    let viewModel = HomeVM()
    
    private lazy var navLeftButton: ProfileButton = {
        let button = ProfileButton(profileImage: UIImage(systemName: "person.fill"))
        
        button.addTarget(self, action: #selector(tappedNavLeftButton), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var tableView: BaseTableView = {
        let tableview = BaseTableView(style: .grouped,
                                      cells: [HomeTableCell.self],
                                      showsVerticalScrollIndicator: false,
                                      separatorStyle: .none,
                                      backgroundColor: .black)
        
        tableview.delegate = viewModel.dataSource
        tableview.dataSource = viewModel.dataSource

        return tableview
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
        viewModel.getPopularMovies()
        viewModel.getUpComing()
        viewModel.getNowPlaying()
        viewModel.getTopRatedMovies()
    }
    
    func setup() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        view.backgroundColor = .black
        title = "Home"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass")?.withTintColor(.white, renderingMode: .alwaysOriginal), style: .plain, target: self, action: #selector(tappedSearchIcon))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: navLeftButton)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let link = Defs.shared.defsUserModel?.avatar {
            ImageRequest.setImg(image: navLeftButton.profileImageView, imgLink: "http://image.tmdb.org/t/p/w500\(link)")
        }
    }
    
    override func setupViews() {
        super.setupViews()
        
        view.addSubview(tableView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    @objc private func tappedSearchIcon() {
        self.push(to: SearchVC())
    }
    
    @objc private func tappedNavLeftButton() {
        let vc = ProfileVC()
        self.push(to: vc)
    }
}

extension HomeVC {
    override func observeViewModel() {
        super.observeViewModel()
        
        viewModel.subscribe { [weak self] state in
            guard let self = self else { return }
            
            switch state {
                
            case .getPopularSuccess:
                self.tableView.reloadSections(IndexSet(integer: 0), with: .none)
            case .networkFailure(let message):
                RedirectManager.shared.showAlert(from: self, title: "Uyarı", message: message, firstButtonTitle: "Tamam")
            case .getTopRatedSuccess:
                self.tableView.reloadSections(IndexSet(integer: 1), with: .none)
            case .getNowPlayingSuccess:
                self.tableView.reloadSections(IndexSet(integer: 2), with: .none)
            case .getUpComingSuccess:
                self.tableView.reloadSections(IndexSet(integer: 3), with: .none)
            }
        }
    }
    
    override func observeDataSource() {
        super.observeDataSource()
        
        viewModel.dataSource.subscribe { [weak self] state in
            guard let self = self else { return }
            
            switch state {
                
            case .pushToDetail(let id):
                let vc = DetailVC(movieId: id)
                self.push(to: vc)
            case .getAll(let section):
                switch section {
                case 0: self.push(to: AllMoviesVC(title: "Popular", request: .popular))
                case 1: self.push(to: AllMoviesVC(title: "Top rated", request: .topRated))
                case 3: self.push(to: AllMoviesVC(title: "Upcoming", request: .upComing))
                default: break
                }
            }
        }
    }
}
