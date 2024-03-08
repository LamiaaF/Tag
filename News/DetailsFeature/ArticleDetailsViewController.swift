//
//  ArticleDetailsViewController.swift
//  News
//
//  Created by Avito on 8/3/2024.
//

import Foundation
import UIKit

class ArticleDetailsViewController: UIViewController {

    public var articleDetails: ArticleListViewData
    

    
    // MARK: - UI Components

    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemBackground
        collectionView.register(DetailsCell.self, forCellWithReuseIdentifier: DetailsCell.reuseIdentifier)
        return collectionView
    }()

    // MARK: - Initialization

    init(articleDetails: ArticleListViewData) {
        self.articleDetails = articleDetails
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        updateUI()
    }

    // MARK: - UI Setup

    private func setupUI() {
        view.backgroundColor = .systemBackground
        setupCollectionView()
    }

    private func setupCollectionView() {
        view.addSubview(collectionView)

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])

        collectionView.delegate = self
        collectionView.dataSource = self
    }

    // MARK: - Data Update

    private func updateUI() {
        collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDataSource

// MARK: - UICollectionViewDataSource

extension ArticleDetailsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1 // Assuming you only have one article details to display
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailsCell.reuseIdentifier, for: indexPath) as! DetailsCell

        // Remove the conditional binding, as articleDetails is not optional
        cell.setViewData(with: articleDetails)

        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension ArticleDetailsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 500) // Adjust height as needed
    }
}
