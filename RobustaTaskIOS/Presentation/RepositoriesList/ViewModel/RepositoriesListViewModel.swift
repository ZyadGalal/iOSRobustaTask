//
//  RepositoriesListViewModel.swift
//  RobustaTaskIOS
//
//  Created by Zyad Galal on 26/03/2023.
//

import Foundation
import Combine

final class RepositoriesListViewModel {
    private let repo: RepositoriesListRepoType
    private var router: RepositoriesListRouterProtocol?
    private let repositoriesRepoSubject = CurrentValueSubject<Void, Error>(())
    private var repositories = [RepositoriesEntity]()
    private var filteredRepositories = [RepositoriesEntity]()

    init(repo: RepositoriesListRepoType, router: RepositoriesListRouterProtocol) {
        self.repo = repo
        self.router = router
    }
}

extension RepositoriesListViewModel: RepositoriesListViewModelInput {
    func viewDidLoad() {
        repo.getRepositories {[weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let entity):
                self.repositories = entity
                self.filteredRepositories = entity
                self.repositoriesRepoSubject.send(())
            case .failure(let error):
                self.repositoriesRepoSubject.send(completion: .failure(error))
            }
        }
    }

    func searchTextUpdated(with text: String) {
        if text.count < 2 {
            filteredRepositories = repositories
        } else {
            filteredRepositories = repositories.filter {
                $0.repositoryName.lowercased().contains(text.lowercased())
            }
        }
        repositoriesRepoSubject.send(())
    }

    func didSelectRepo(at index: Int) {
        let entity = filteredRepositories[index]
        router?.showRepoDetails(entity: entity)
    }
}

extension RepositoriesListViewModel: RepositoriesListViewModelOutput {
    var repositoriesRepoPublisher: AnyPublisher<Void, Error> {
        repositoriesRepoSubject.eraseToAnyPublisher()
    }

    func getRepositoriesCount() -> Int {
        return filteredRepositories.count
    }
    
    func getRepositoryItem(at index: Int) -> RepositoriesEntity {
        return filteredRepositories[index]
    }
}
