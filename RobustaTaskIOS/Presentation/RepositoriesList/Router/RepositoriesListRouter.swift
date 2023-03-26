//
//  RepositoriesListRouter.swift
//  RobustaTaskIOS
//
//  Created by Zyad Galal on 26/03/2023.
//

import UIKit.UIViewController

protocol RepositoriesListRouterProtocol {
    func createRepositoriesList() -> UIViewController
    func showRepoDetails(entity: RepositoriesEntity)
}

class RepositoriesListRouter: RepositoriesListRouterProtocol {
    unowned var controller: UIViewController?

    func createRepositoriesList() -> UIViewController {
        let repo = RepositoriesListRepo()
        let viewModel = RepositoriesListViewModel(repo: repo, router: self)
        return RepositoriesListViewController(viewModel: viewModel)
    }

    func showRepoDetails(entity: RepositoriesEntity) {
        let detailsRouter = RepositoryDetailsRouter()
        let viewController = detailsRouter.createRepositoryDetails(entity: entity)
        controller?.navigationController?.pushViewController(viewController, animated: true)
    }
}
