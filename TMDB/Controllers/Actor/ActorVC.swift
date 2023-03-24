//
//  ActorVC.swift
//  NetflixClone
//
//  Created by Ahmet Utlu on 14.03.2023.
//

import UIKit

class ActorVC: BaseVC {
    let viewModel = ActorVM()
    
    private lazy var tableView: BaseTableView = {
        let tableView = BaseTableView(style: .grouped,
                                      cells: [BiographyTableCell.self,
                                              ActedMoviesTableCell.self,
                                              ImagesTableCell.self],
                                      showsVerticalScrollIndicator: false,
                                      separatorStyle: .none,
                                      backgroundColor: .black)
        
        tableView.delegate = viewModel.dataSource
        tableView.dataSource = viewModel.dataSource

        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func setupViews() {
        super.setupViews()
        view.addSubviews([tableView])
    }
    
    override func setupLayout() {
        super.setupLayout()
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide.snp.edges)
        }
    }
    
    convenience init(personId: Int) {
        self.init()
        self.viewModel.getPersonDetail(id: personId)
        self.viewModel.getActedMovies(id: personId)
        self.viewModel.getActorImages(id: personId)
    }
}

extension ActorVC {
    override func observeViewModel() {
        super.observeViewModel()
        
        self.viewModel.subscribe { [weak self] state in
            guard let self = self else { return }

            switch state {
                
            case .getDetailSuccess:
                self.title = self.viewModel.dataSource.name
                self.tableView.reloadSections(IndexSet(integer: 1), with: .none)
            case .networkFailure(let message):
                RedirectManager.shared.showAlert(from: self, title: "Uyarı", message: message, firstButtonTitle: "Tamam")
            case .getActedMoviesSuccess:
                self.tableView.reloadSections(IndexSet(integer: 2), with: .none)
            case .getImagesSuccess:
                self.tableView.reloadSections(IndexSet(integer: 0), with: .none)
            }
        }
    }
    
    override func observeDataSource() {
        super.observeViewModel()
        
        self.viewModel.dataSource.subscribe { [weak self] state in
            guard let self = self else { return }

            switch state {
            case .navigateToAll:
                let vc = AllMoviesVC(title: self.viewModel.dataSource.name ?? "", request: .actedMovies, model: self.viewModel.dataSource.allActedMovies)
                self.push(to: vc)
            case .navigateToDetail(let id):
                let vc = DetailVC(movieId: id)
                self.push(to: vc)
            }
        }
    }
}
