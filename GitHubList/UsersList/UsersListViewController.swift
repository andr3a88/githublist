//
//  UsersListViewController.swift
//  GitHubList
//
//  Created by Andrea Stevanato on 13/05/2017.
//  Copyright © 2017 Andrea Stevanato. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class UsersListViewController: UIViewController, UITableViewDelegate {
    
    // MARK: IBOutlets
    
    @IBOutlet var tableView: UITableView!
    
    // MARK: Properties
    
    let disposeBag = DisposeBag()
    
    var viewModel: UsersListViewModelType!
    
    // MARK: Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure(viewModel: viewModel)
    }
    
    func configure(viewModel: UsersListViewModelType) {
        
        viewModel.rx_title
            .drive(rx.title)
            .addDisposableTo(disposeBag)
        
        viewModel.rx_usersFetched
            .bind(to: tableView.rx.items(cellIdentifier: "UserCell")) { (tableView, user, cell) in
                cell.textLabel?.text = user.username
                cell.detailTextLabel?.text = user.avatarUrl
            }
            .addDisposableTo(disposeBag)
        
        tableView.rx
            .modelSelected(User.self)
            .subscribe(onNext:  { user in
                self.viewModel.toUserDetail(user: user)
            })
            .disposed(by: disposeBag)
        
        tableView.rx.itemSelected
            .subscribe(onNext: { [unowned self] (indexPath) in
                self.tableView.cellForRow(at: indexPath)?.isSelected = false
            })
            .addDisposableTo(disposeBag)
    }
}
