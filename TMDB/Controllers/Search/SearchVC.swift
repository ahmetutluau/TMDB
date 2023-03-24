//
//  SearchVC.swift
//  NetflixClone
//
//  Created by Ahmet Utlu on 5.03.2023.
//

import UIKit

class SearchVC: BaseVC {
    
    let viewModel = SearchVM()
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar(frame: .zero)
        
        searchBar.delegate = self
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "Search movie"
        searchBar.tintColor = .white
        searchBar.searchTextField.textColor = .white
        
        return searchBar
    }()
    
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

        navigationController?.setNavigationBarHidden(false, animated: true)
        title = "Search movies"
        view.backgroundColor = .black
    }

    override func setupViews() {
        super.setupViews()
        view.addSubviews([searchBar,
                         collectionView])
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.trailing.equalToSuperview().offset(-CGFloat.dWidth * (10/375))
            make.leading.equalToSuperview().offset(CGFloat.dWidth * (10/375))
            make.height.equalTo(CGFloat.dHeight * (40/812))
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(CGFloat.dHeight * (20/812))
            make.trailing.bottom.leading.equalToSuperview()
        }
    }

}

extension SearchVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.viewModel.searchMovies(text: searchText)
    }
}

extension SearchVC {
    override func observeViewModel() {
        super.observeViewModel()
        
        self.viewModel.subscribe { [weak self] state in
            guard let self = self else { return }
            
            switch state {
                
            case .searchMoviesSuccess:
                self.collectionView.reloadData()
                self.collectionView.setContentOffset(.zero, animated: false)
            case .networkFailure(let message):
                RedirectManager.shared.showAlert(from: self, title: "Uyarı", message: message, firstButtonTitle: "Tamam")            }
        }
    }
    
    override func observeDataSource() {
        super.observeDataSource()
        
        self.viewModel.dataSource.subscribe { [weak self] state in
            guard let self = self else { return }
            
            switch state {
            case .pushToDetail(let id):
                let vc = DetailVC(movieId: id)
                self.push(to: vc)
            }
        }
    }
}
