//
//  RepositoriesListRouterSpy.swift
//  RobustaTaskIOSTests
//
//  Created by Zyad Galal on 27/03/2023.
//

import UIKit
@testable import RobustaTaskIOS

class RepositoriesListRouterSpy: RepositoriesListRouterProtocol {
    var showRepoDetailsCallCount = 0
    func createRepositoriesList() -> UIViewController {
        return UIViewController()
    }

    func showRepoDetails(entity: RobustaTaskIOS.RepositoriesEntity) {
        showRepoDetailsCallCount += 1
    }
}
