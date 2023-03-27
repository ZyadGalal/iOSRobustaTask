//
//  RepositoriesListRepoSpy.swift
//  RobustaTaskIOSTests
//
//  Created by Zyad Galal on 27/03/2023.
//

import Foundation
@testable import RobustaTaskIOS

class RepositoriesListRepoSpy: RepositoriesListRepoType {
    var repoListResultToBeReturn: (Result<[RobustaTaskIOS.RepositoriesEntity], Error>)!
    func getRepositories(completionHandler: @escaping (Result<[RobustaTaskIOS.RepositoriesEntity], Error>) -> Void) {
        completionHandler(repoListResultToBeReturn)
    }
}
