//
//  RepositoryDetailsViewModelType.swift
//  RobustaTaskIOS
//
//  Created by Zyad Galal on 26/03/2023.
//

import Foundation
import Combine

typealias RepositoryDetailsViewModelType = RepositoryDetailsViewModelInput & RepositoryDetailsViewModelOutput

protocol RepositoryDetailsViewModelInput { }

protocol RepositoryDetailsViewModelOutput {
    var repoDetailsPublisher: AnyPublisher<RepositoriesEntity, Never> { get }
}
