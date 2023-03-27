//
//  RepositoryDetailsRouter.swift
//  RobustaTaskIOS
//
//  Created by Zyad Galal on 26/03/2023.
//

import UIKit.UIViewController

protocol RepositoryDetailsRouterProtocol { }
class RepositoryDetailsRouter: RepositoryDetailsRouterProtocol {
    static func createRepositoryDetails(entity: RepositoriesEntity) -> UIViewController {
        let viewModel = RepositoryDetailsViewModel(repoDetails: entity)
        return RepositoryDetailsViewController(viewModel: viewModel)
    }
}
