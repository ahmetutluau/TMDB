//
//  DetailVCViewController.swift
//  NetflixClone
//
//  Created by Ahmet Utlu on 2.03.2023.
//

import UIKit
import SafariServices

class DetailVC: BaseVC {
    
    let viewModel = DetailVM()
    
    private lazy var backdropImageView: BaseImageView = {
        let view = BaseImageView(image: nil,
                                 contentMode: .scaleAspectFill,
                                 backgroundColor: .clear)
        
        view.layer.cornerRadius = CGFloat.dHeight * (10/812)
        view.clipsToBounds = true
        view.layer.opacity = 0.3
        
        return view
    }()
        
    private lazy var tableView: BaseTableView = {
        let tableview = BaseTableView(style: .grouped,
                                      cells: [MovieInfoCell.self,
                                              OverViewCell.self,
                                              TrailersTableCell.self,
                                              CastTableCell.self,
                                              SimilarMoviesCell.self,
                                              ReviewsCell.self],
                                      showsVerticalScrollIndicator: false,
                                      separatorStyle: .none,
                                      backgroundColor: .clear)
        
        tableview.delegate = viewModel.dataSource
        tableview.dataSource = viewModel.dataSource

        return tableview
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .black
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isTranslucent = true
    }
    
    override func setupViews() {
        super.setupViews()
        
        view.addSubviews([backdropImageView,
                         tableView])
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        backdropImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(CGFloat.dHeight * 590/1500)
        }
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    convenience init(movieId: Int) {
        self.init()
        self.viewModel.getMovieDetail(id: movieId)
        self.viewModel.getSimilarMovies(id: movieId)
        self.viewModel.getCredits(id: movieId)
        self.viewModel.getTrailers(id: movieId)
    }
}


extension DetailVC {
    override func observeViewModel() {
        super.observeViewModel()
        
        self.viewModel.subscribe { [weak self] state in
            guard let self = self else { return }
            
            switch state {
                
            case .getDetailSuccess:
                if let image = self.viewModel.dataSource.movie?.backdropPath {
                    ImageRequest.setImg(image: self.backdropImageView, imgLink: "http://image.tmdb.org/t/p/w500\(image)")
                }
                self.tableView.reloadSections(IndexSet(integersIn: 0...1), with: .none)
            case .networkFailure(let message):
                RedirectManager.shared.showAlert(from: self, title: "Uyarı", message: message, firstButtonTitle: "Tamam")
            case .getSimilarSuccess:
                self.tableView.reloadSections(IndexSet(integer: 4), with: .none)
            case .getCreditsSuccess:
                self.tableView.reloadSections(IndexSet(integer: 3), with: .none)
            case .getTrailersSuccess:
                self.tableView.reloadSections(IndexSet(integer: 2), with: .none)
            }
        }
    }
    
    override func observeDataSource() {
        super.observeDataSource()
        
        self.viewModel.dataSource.subscribe { [weak self] state in
            guard let self = self else { return }
            
            switch state {
                
            case .pushVC(let url):
                guard let URL = URL(string: url) else { return }
                if UIApplication.shared.canOpenURL(URL) {
                    DispatchQueue.main.async {
                        let vc = WebViewVC()
                        vc.urlString = url
                        self.present(vc, animated: true)
                    }
                } else {
                    RedirectManager.shared.showAlert(from: self, title: "Uyarı", message: "Webview can't open.", firstButtonTitle: "Tamam")
                }
                
            case .navigateToDetail(let id):
                let vc = DetailVC(movieId: id)
                self.push(to: vc)
            case .navigateToReviews(let id):
                let vc = ReviewsVC(movieId: id)
                self.push(to: vc)
            case .navigateToCastDetail(let id):
                let vc = ActorVC(personId: id)
                self.push(to: vc)
            }
        }
    }
}

