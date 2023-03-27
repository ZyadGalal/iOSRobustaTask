//
//  RepositoriesListViewController.swift
//  RobustaTaskIOS
//
//  Created by Zyad Galal on 26/03/2023.
//

import UIKit
import Combine

final class RepositoriesListViewController: UIViewController {

    @IBOutlet private weak var repositoriesTableView: UITableView!
    @IBOutlet private weak var searchTextField: UITextField!

    private var cancellables = Set<AnyCancellable>()
    private let viewModel: RepositoriesListViewModelType

    public init(viewModel: RepositoriesListViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: .main)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
        setupViewBindings()
        setupViewModelBindings()
        viewModel.viewDidLoad()
    }

}

// MARK: configurations
private extension RepositoriesListViewController {
    func setupUI() {
        searchTextField.placeholder = "search here ..."
    }

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
            .sink { [weak self] text in
                self?.viewModel.searchTextUpdated(with: text)
            }
            .store(in: &cancellables)
    }

    func setupViewModelBindings() {
        viewModel.repositoriesRepoPublisher
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print(error)
                case .finished:
                    print("completed")
                }
            } receiveValue: { [weak self] () in
                self?.repositoriesTableView.reloadData()
            }
            .store(in: &cancellables)
    }
}

extension RepositoriesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getRepositoriesCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell() as RepositoryItemTableViewCell
        let entity = viewModel.getRepositoryItem(at: indexPath.row)
        cell.config(entity: entity)
        return cell
    }
}

extension RepositoriesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRepo(at: indexPath.row)
    }
}
