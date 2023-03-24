//
//  AllMoviesVC.swift
//  NetflixClone
//
//  Created by Ahmet Utlu on 6.03.2023.
//

import UIKit

enum MovieType {
    case popular
    case topRated
    case upComing
    case actedMovies
}

class AllMoviesVC: BaseVC {
    let viewModel = AllMoviesVM()
    
    private lazy var collectionView: BaseCollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.sectionInset = .init(top: 0, left: 10, bottom: 0, right: 10)
        
        let collectionView = BaseCollectionView(layout: layout,
                                                cells: [MovieListCollectionCell.self],
                                                showsHorizontalScrollIndicator: false,
                                                backgroundColor: .clear)
                                                        
        collectionView.delegate = viewModel.dataSource
        collectionView.dataSource = viewModel.dataSource
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func setupViews() {
        super.setupViews()
        view.addSubview(collectionView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide.snp.edges)
        }
    }
    
    convenience init(title: String, request: MovieType, model: [ActedMoviesModel]? = nil) {
        self.init()
        
        self.title = title
        self.viewModel.request = request
        
        switch request {
            
        case .popular:
            self.viewModel.getPopularMovies()
        case .topRated:
            self.viewModel.getTopRatedMovies()
        case .upComing:
            self.viewModel.getUpComing()
        case .actedMovies:
            guard let model = model else { return }
            self.viewModel.dataSource.actedMovies = model
        }
        
        self.viewModel.dataSource.movieType = request
    }
}

extension AllMoviesVC {
    override func observeViewModel() {
        super.observeViewModel()
        
        self.viewModel.subscribe { [weak self] state in
            guard let self = self else { return }
            
            switch state {
                
            case .networkSuccess:
                self.collectionView.reloadData()
            case .networkFailure(let message):
                RedirectManager.shared.showAlert(from: self, title: "Uyarı", message: message, firstButtonTitle: "Tamam")
            }
        }
    }
    
    override func observeDataSource() {
        super.observeDataSource()
        
        self.viewModel.dataSource.subscribe { [weak self] state in
            guard let self = self else { return }
            
            switch state {
              
            case .sendRequest:
                switch self.viewModel.request {
                case .popular: self.viewModel.getPopularMovies()
                case .topRated: self.viewModel.getTopRatedMovies()
                case .upComing: self.viewModel.getUpComing()
                default: break
                }
            case .navigateToDetail(let id):
                let vc = DetailVC(movieId: id)
                self.push(to: vc)
            }
        }
    }
}
