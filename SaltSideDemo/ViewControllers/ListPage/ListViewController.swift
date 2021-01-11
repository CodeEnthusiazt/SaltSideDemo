//
//  ViewController.swift
//  SaltSideDemo
//
//  Created by Dinesh on 09/01/21.
//

import UIKit
import Combine

class ListViewController: UIViewController {

    /// ListTableView to show userlist
    @IBOutlet weak var listTableView: UITableView!
    /// ViewModel for list page
    var viewModel = ListViewModel()
    /// Activityview to show loader
    var activityView = UIActivityIndicatorView(style: .medium)
    /// Subscriptions are stored in dispose bag
    var disposeBag = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Register TableView Cell
        listTableView.register(UINib(nibName: AppConstants.TVIdentifier.listId, bundle: nil), forCellReuseIdentifier: AppConstants.TVIdentifier.listId)
        listTableView.delegate = viewModel.dataservices
        listTableView.dataSource = viewModel.dataservices
        // Adding loader to superview
        self.view.addSubview(activityView)
        activityView.center = self.view.center
        // Subscribing toggleInteraction
        viewModel.$toggleInteraction.sink { [unowned self] (toggle) in
             toggle ? self.activityView.stopAnimating() :                self.activityView.startAnimating()
        }.store(in: &disposeBag)
        // Subscribing to usermodel array
        viewModel.userListPublisher
            .filter{$0.count > 0}
            .sink { [unowned self] (res) in
                self.viewModel.dataservices.userList = res
                self.listTableView.reloadData()
            }.store(in: &disposeBag)
        // Subscribing to show alert for error cases
        viewModel.showAlert.sink { [unowned self] (content) in
            self.showAlert(AppConstants.CommonKeys.CommonAlertTitle, alertContent: content, actionTitle: AppConstants.CommonKeys.CommonAlertActionButtonTitle)
        }.store(in: &disposeBag)
        // Calling userlist from viewmodel
        viewModel.getUserList()
    }
}

extension UIViewController {
    /// Show Alert - extension for viewcontroller
    /// - Parameters:
    ///   - alertTitle: Title of the alert
    ///   - alertContent: Content shown in the alert
    ///   - actionTitle: User Action title - OK or Cancel
    func showAlert(_ alertTitle: String, alertContent: String, actionTitle: String) {
        let alert = UIAlertController(title: alertTitle, message: alertContent, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: actionTitle, style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

