//
//  RepositoriesListUsecaseType.swift
//  RobustaTaskIOS
//
//  Created by Zyad Galal on 26/03/2023.
//

import Foundation

protocol RepositoriesListRepoType {
    func getRepositories(completionHandler: @escaping (Result<[RepositoriesEntity], Error>) -> Void)
}
