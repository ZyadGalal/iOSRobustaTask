//
//  RepositoryViewModel.swift
//  RobustaTaskIOS
//
//  Created by Zyad Galal on 26/03/2023.
//

import Foundation
import Combine

final class RepositoryDetailsViewModel {
    @Published var repoDetailsSubject: RepositoriesEntity

    init(repoDetails: RepositoriesEntity) {
        self.repoDetailsSubject = repoDetails
    }
}

extension RepositoryDetailsViewModel: RepositoryDetailsViewModelInput {}

extension RepositoryDetailsViewModel: RepositoryDetailsViewModelOutput {
    var repoDetailsPublisher: AnyPublisher<RepositoriesEntity, Never> {
        $repoDetailsSubject.eraseToAnyPublisher()
    }
}
