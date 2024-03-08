//
//  DetailsCell.swift
//  News
//
//  Created by Avito on 9/2/2024.
//

import Foundation
import UIKit



class DetailsCell: UICollectionViewCell {
    static let reuseIdentifier = "DetailsCell"

    // MARK: - UI Components

    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()


    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines = 0
        return label
    }()

    let authorLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()

    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    let contentLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()

    let articleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }

    private func setupUI() {
        contentView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false

        // Add labels and image view to the stack view
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(authorLabel)
        stackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(articleImageView)
        stackView.addArrangedSubview(contentLabel)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
        ])
    }

    

  

    // MARK: - Configuration

    func setViewData(with articleData: ArticleListViewData) {
        titleLabel.text = articleData.title
        authorLabel.text = "Author: \(articleData.author ?? "Unknown Author")"
        descriptionLabel.text = articleData.description
        if let urlString = articleData.urlToImage, let imageUrl = URL(string: urlString) {
            DispatchQueue.global().async {
                if let imageData = try? Data(contentsOf: imageUrl) {
                    DispatchQueue.main.async {
                        self.articleImageView.image = UIImage(data: imageData)
                    }
                }
            }
        }
        contentLabel.text = articleData.content

    }
}
