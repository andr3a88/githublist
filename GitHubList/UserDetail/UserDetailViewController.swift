//
//  UserDetailViewController.swift
//  GitHubList
//
//  Created by Andrea Stevanato on 13/05/2017.
//  Copyright © 2017 Andrea Stevanato. All rights reserved.
//

import RxSwift
import RxCocoa

class UserDetailViewController: UIViewController {
    
    // MARK: Properties
    
    let disposeBag = DisposeBag()
    
    var viewModel: UserDetailViewModelType!
    
    // MARK: Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure(viewModel: viewModel)
    }
    
    func configure(viewModel: UserDetailViewModelType) {
        viewModel.rx_title
            .drive(rx.title)
            .addDisposableTo(disposeBag)
    }
}
