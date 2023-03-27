//
//  RepositoriesListRouter.swift
//  RobustaTaskIOS
//
//  Created by Zyad Galal on 26/03/2023.
//

import UIKit.UIViewController

protocol RepositoriesListRouterProtocol {
    func showRepoDetails(entity: RepositoriesEntity)
}

final class RepositoriesListRouter: RepositoriesListRouterProtocol {
    weak var controller: UIViewController?

    static func createRepositoriesList() -> UIViewController {
        let repo = RepositoriesListRepo()
        let router = RepositoriesListRouter()
        let viewModel = RepositoriesListViewModel(repo: repo, router: router)
        let viewController = RepositoriesListViewController(viewModel: viewModel)
        router.controller = viewController
        return viewController
    }

    func showRepoDetails(entity: RepositoriesEntity) {
        let viewController = RepositoryDetailsRouter.createRepositoryDetails(entity: entity)
        controller?.navigationController?.pushViewController(viewController, animated: true)
    }
}
