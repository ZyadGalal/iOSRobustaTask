//
//  RepositoryViewModel.swift
//  RobustaTaskIOS
//
//  Created by Zyad Galal on 26/03/2023.
//

import Foundation
import Combine

class RepositoryDetailsViewModel {
    @Published var repoDetailsSubject: RepositoriesEntity

    init(repoDetailsSubject: RepositoriesEntity) {
        self.repoDetailsSubject = repoDetailsSubject
    }
}

extension RepositoryDetailsViewModel: RepositoryDetailsViewModelInput {}

extension RepositoryDetailsViewModel: RepositoryDetailsViewModelOutput {
    var repoDetailsPublisher: AnyPublisher<RepositoriesEntity, Never> {
        $repoDetailsSubject.eraseToAnyPublisher()
    }
}
