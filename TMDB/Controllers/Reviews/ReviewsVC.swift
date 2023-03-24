//
//  ReviewsVC.swift
//  NetflixClone
//
//  Created by Ahmet Utlu on 13.03.2023.
//

import UIKit

class ReviewsVC: BaseVC {
    let viewModel = ReviewsVM()
    
    private lazy var tableView: BaseTableView = {
        let tableView = BaseTableView(cells: [ReviewsDetailTableCell.self],
                                      showsVerticalScrollIndicator: false,
                                      separatorStyle: .none,
                                      backgroundColor: .black)
        
        tableView.delegate = viewModel.dataSource
        tableView.dataSource = viewModel.dataSource

        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        title = "Reviews"
        view.backgroundColor = .black
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
    
    convenience init(movieId: Int) {
        self.init()
        self.viewModel.getMovieReviews(id: movieId)
    }
}

extension ReviewsVC {
    override func observeViewModel() {
        super.observeViewModel()
        
        self.viewModel.subscribe { [weak self] state in
            guard let self = self else { return }

            switch state {
                
            case .getReviewsSuccess:
                self.tableView.reloadData()
            case .networkFailure(let message):
                RedirectManager.shared.showAlert(from: self, title: "Uyarı", message: message, firstButtonTitle: "Tamam")
            }
        }
    }
}
