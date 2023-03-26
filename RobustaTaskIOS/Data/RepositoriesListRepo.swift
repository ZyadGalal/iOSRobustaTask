//
//  RepositoriesListUsecase.swift
//  RobustaTaskIOS
//
//  Created by Zyad Galal on 26/03/2023.
//

import Foundation

class RepositoriesListRepo {
    func makeEntity(model: [RepositoriesModel]) -> [RepositoriesEntity] {
        return model.map { model in
            RepositoriesEntity(repositoryName: model.fullName ?? "",
                               repositoryOwner: model.owner?.login ?? "",
                               ownerImageURL: model.owner?.avatarURL ?? "",
                               isPrivateRepo: model.privateRepo ?? false,
                               description: model.description ?? "")
        }
    }
}

extension RepositoriesListRepo: RepositoriesListRepoType {
    func getRepositories(completionHandler: @escaping (Result<[RepositoriesEntity], Error>) -> Void) {
        APIClient.performRequest(model: [RepositoriesModel].self, url: .repositoryList) {[weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                completionHandler(.success(self.makeEntity(model: response)))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}
