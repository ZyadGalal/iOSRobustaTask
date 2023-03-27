//
//  RepositoryItemTableViewCell.swift
//  RobustaTaskIOS
//
//  Created by Zyad Galal on 26/03/2023.
//

import UIKit

final class RepositoryItemTableViewCell: UITableViewCell {
    @IBOutlet private weak var repositoryOwnerNameLabel: UILabel!
    @IBOutlet private weak var repositoryNameLabel: UILabel!
    @IBOutlet private weak var repositoryImageView: ImageDownloader!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func config(entity: RepositoriesEntity) {
        repositoryOwnerNameLabel.text = entity.repositoryOwner
        repositoryNameLabel.text = entity.repositoryName
        repositoryImageView.loadImage(urlString: entity.ownerImageURL)
    }
    
}
