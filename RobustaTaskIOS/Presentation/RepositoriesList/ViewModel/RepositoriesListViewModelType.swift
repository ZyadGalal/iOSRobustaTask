//
//  RepositoriesListViewModelType.swift
//  RobustaTaskIOS
//
//  Created by Zyad Galal on 26/03/2023.
//

import Foundation
import Combine

typealias RepositoriesListViewModelType = RepositoriesListViewModelInput & RepositoriesListViewModelOutput

protocol RepositoriesListViewModelInput {
    func viewDidLoad()
    func searchTextUpdated(with text: String)
    func didSelectRepo(at index: Int)
}

protocol RepositoriesListViewModelOutput {
    var repositoriesRepoPublisher: AnyPublisher<Void, Error> { get }
    func getRepositoriesCount() -> Int
    func getRepositoryItem(at index: Int) -> RepositoriesEntity
}
