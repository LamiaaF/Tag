//
//  ArticleDetailViewController.swift
//  News
//
//  Created by Avito on 30/1/2024.
//
// ArticleDetailViewController.swift
// ArticleDetailViewController.swift

import Foundation
import UIKit

class DefaultArticleDetailViewControllerFactory: ArticleDetailViewControllerFactory {
    func makeArticleDetailViewController(articleData: ArticleDetailViewData) -> ArticleDetailView {
        return ArticleDetailViewController(articleData: articleData)
    }
}

// ArticleDetailViewController.swift


class ArticleDetailViewController: UIViewController, UICollectionViewDelegate {

    // MARK: - Properties

        private var viewModel: ArticleDetailViewData?
    
    internal lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 300, height: 500)

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.isUserInteractionEnabled = true
        collectionView.delegate = self

        collectionView.dataSource = self
        collectionView.register(ArticleDetailCell.self, forCellWithReuseIdentifier: ArticleDetailCell.reuseIdentifier)
        return collectionView
    }()
    // MARK: - Initialization

    init(articleData: ArticleDetailViewData) {
        self.viewModel = articleData
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - Lifecycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        if let viewModel = viewModel {
            displayArticleDetails(articleData: viewModel)

              print("ViewModel data: \(viewModel)")
          } else {
              print("ViewModel is nil")
          }
    }

    // MARK: - UI Setup

    private func setupCollectionView() {
  

        view.addSubview(collectionView)

            // Add constraints to pin the collectionView to the edges of the view
            NSLayoutConstraint.activate([
                collectionView.topAnchor.constraint(equalTo: view.topAnchor),
                collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        }
    }

// MARK: - UICollectionViewDataSource Extension

extension ArticleDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ArticleDetailCell.reuseIdentifier, for: indexPath) as? ArticleDetailCell else {
            fatalError("Unexpected cell type at indexPath \(indexPath)")
        }

        if let viewModel = viewModel {
            cell.configure(with: viewModel)
        }

        return cell
    }
}


// MARK: - ArticleDetailView Protocol

extension ArticleDetailViewController: ArticleDetailView {
    func displayArticleDetails(articleData: ArticleDetailViewData) {
        // Update UI elements with the provided data
        viewModel = articleData
        collectionView.reloadData()

        // Optionally, you can print the data to the console for debugging
        print("Displaying article details:", articleData)
    }
}

