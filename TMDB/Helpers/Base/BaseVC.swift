//
//  BaseVC.swift
//  NetflixClone
//
//  Created by Ahmet Utlu on 1.03.2023.
//

import UIKit

class BaseVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupLayout()
        observeViewModel()
        observeDataSource()
        setBackNavigationItem()
        hideNavBar()
        hideKeyboardWhenTappedAround()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavBar()
    }
}

extension BaseVC {
    @objc func setupViews() {}
    
    @objc func setupLayout() {}
    
    @objc func observeViewModel() {}

    @objc func observeDataSource() {}
}

//MARK: Helper Funcs
extension BaseVC {
    
    func push(to: BaseVC, completionHandler: (() -> Void)? = nil, animated: Bool = true) {
        navigationController?.pushViewController(to, animated: animated)
        completionHandler?()
    }
    
    func setViewController(as vc: UIViewController) {
        navigationController?.setViewControllers([vc], animated: true)
    }
    
    func setBackNavigationItem() {
        let backItem = UIImage(systemName: "chevron.backward")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        self.navigationController?.navigationBar.backIndicatorImage = backItem
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = backItem
    }
    
    func setNavBar() {
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.isTranslucent = false
    }
    
    func hideNavBar() {
        navigationController?.isNavigationBarHidden = true
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
