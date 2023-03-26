//
//  RepositoriesListViewController.swift
//  RobustaTaskIOS
//
//  Created by Zyad Galal on 26/03/2023.
//

import UIKit
import Combine

class RepositoriesListViewController: UIViewController {

    @IBOutlet weak var repositoriesTableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!

    private var cancellables = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupViewBindings()
    }

}

// MARK: configurations
private extension RepositoriesListViewController {
    func setupTableView() {
        repositoriesTableView.register(RepositoryItemTableViewCell.self)
        repositoriesTableView.dataSource = self
        repositoriesTableView.delegate = self
    }
}

// MARK: private handlers

private extension RepositoriesListViewController {
    func setupViewBindings() {
        searchTextField.textPublisher
            .receive(on: DispatchQueue.main)
            .sink { text in }
            .store(in: &cancellables)
    }
}

extension RepositoriesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell() as RepositoryItemTableViewCell
        return cell
    }
}

extension RepositoriesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { }
}
