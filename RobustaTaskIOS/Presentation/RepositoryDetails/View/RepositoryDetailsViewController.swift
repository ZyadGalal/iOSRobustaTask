//
//  RepositoryDetailsViewController.swift
//  RobustaTaskIOS
//
//  Created by Zyad Galal on 26/03/2023.
//

import UIKit
import Combine

class RepositoryDetailsViewController: UIViewController {
    
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var ownerNameLabel: UILabel!
    @IBOutlet private weak var privateRepoLabel: UILabel!
    @IBOutlet private weak var repoNameLabel: UILabel!
    @IBOutlet private weak var ownerNameImageView: ImageDownloader!
    
    private let viewModel: RepositoryDetailsViewModelType
    private var cancellables = Set<AnyCancellable>()
    public init(viewModel: RepositoryDetailsViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: .main)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModelBindings()
    }
}

// MARK: Configuration
private extension RepositoryDetailsViewController {
    func setupViewModelBindings() {
        viewModel.repoDetailsPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] entity in self?.configUI(details: entity) }
            .store(in: &cancellables)
    }

    func configUI(details: RepositoriesEntity) {
        descriptionLabel.text = details.description
        ownerNameLabel.text = details.repositoryOwner
        privateRepoLabel.text = details.isPrivateRepo.description
        repoNameLabel.text = details.repositoryName
        ownerNameImageView.loadImage(urlString: details.ownerImageURL)
    }
}
