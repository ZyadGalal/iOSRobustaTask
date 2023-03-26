//
//  RepositoriesListViewModel.swift
//  RobustaTaskIOS
//
//  Created by Zyad Galal on 26/03/2023.
//

import Foundation
import Combine

class RepositoriesListViewModel {
    private let repo: RepositoriesListRepoType
    private let repositoriesRepoSubject = CurrentValueSubject<Void, Error>(())
    private var repositories = [RepositoriesEntity]()
    init(repo: RepositoriesListRepoType) {
        self.repo = repo
    }
}

extension RepositoriesListViewModel: RepositoriesListViewModelInput {
    func viewDidLoad() {
        repo.getRepositories {[weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let entity):
                self.repositories = entity
                self.repositoriesRepoSubject.send(())
            case .failure(let error):
                self.repositoriesRepoSubject.send(completion: .failure(error))
            }
        }
    }

    func searchTextUpdated(with text: String) {
        print(text)
    }
}

extension RepositoriesListViewModel: RepositoriesListViewModelOutput {
    var repositoriesRepoPublisher: AnyPublisher<Void, Error> {
        repositoriesRepoSubject.eraseToAnyPublisher()
    }

    func getRepositoriesCount() -> Int {
        return repositories.count
    }
    
    func getRepositoryItem(at index: Int) -> RepositoriesEntity {
        return repositories[index]
    }
}
