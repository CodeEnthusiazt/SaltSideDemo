//
//  ViewController.swift
//  SaltSideDemo
//
//  Created by Dinesh on 09/01/21.
//

import UIKit
import Combine

class ListViewController: UIViewController {

    @IBOutlet weak var listTableView: UITableView!
    var viewModel = ListViewModel()
    var activityView = UIActivityIndicatorView(style: .medium)
    var disposeBag = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        listTableView.register(UINib(nibName: AppConstants.TVIdentifier.listId, bundle: nil), forCellReuseIdentifier: AppConstants.TVIdentifier.listId)
        listTableView.delegate = viewModel.dataservices
        listTableView.dataSource = viewModel.dataservices
        self.view.addSubview(activityView)
        activityView.center = self.view.center
        
        viewModel.$toggleInteraction.sink { [unowned self] (toggle) in
             toggle ? self.activityView.stopAnimating() :                self.activityView.startAnimating()
        }.store(in: &disposeBag)
        viewModel.userListPublisher
            .filter{$0.count > 0}
            .sink { [unowned self] (res) in
                self.viewModel.dataservices.userList = res
                self.listTableView.reloadData()
            }.store(in: &disposeBag)
        viewModel.getUserList()
    }
}

