//
//  ArticleListViewController.swift
//  News
//
//  Created by Avito on 9/2/2024.
//

import UIKit

class ArticleListViewController: UIViewController, UICollectionViewDelegate {

    // MARK: - Properties

    public var articles: [ArticleListViewData] = []
    
    weak var coordinatorDelegate: ArticleListViewControllerDelegate?

    private let headlinesLabel: UILabel = {
        let label = UILabel()
        label.text = "Top Headlines"
        label.backgroundColor = .systemBackground
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 300, height: 500)

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.isUserInteractionEnabled = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ArticleCell.self, forCellWithReuseIdentifier: ArticleCell.reuseIdentifier)
        return collectionView
    }()

    // MARK: - Initialization

    init(articles: [ArticleListViewData]) {
        self.articles = articles
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        coordinatorDelegate?.didFetchArticles()
    }

    // MARK: - UI Setup

    private func setupUI() {
        view.backgroundColor = .systemBackground
        setupHeadlinesLabel()
        setupCollectionView()
    }

    private func setupHeadlinesLabel() {
        view.addSubview(headlinesLabel)
        NSLayoutConstraint.activate([
            headlinesLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            headlinesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            headlinesLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
        ])
    }

    private func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.backgroundColor = .clear

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: headlinesLabel.bottomAnchor, constant: 0),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
        ])
    }

    // MARK: - Data Update

    func updateArticles(with articles: [ArticleListViewData]) {
        self.articles = articles
        collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDataSource

extension ArticleListViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return articles.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ArticleCell.reuseIdentifier, for: indexPath) as! ArticleCell

        let article = articles[indexPath.item]
        cell.setViewData(with: article)

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedArticle = articles[indexPath.item]
        coordinatorDelegate?.didSelectArticle(selectedArticle)
    }

}

// MARK: - ArticleListViewControllerDelegate

extension ArticleListViewController: ArticleListViewControllerDelegate {
    func didFetchArticles() {
        updateArticles(with: articles)
    }
    func didSelectArticle(_ article: ArticleListViewData) {
        // Create ArticleDetailsViewController with selected article
        let detailsViewController = ArticleDetailsViewController(articleDetails: article)

        // Push the details view controller
        navigationController?.pushViewController(detailsViewController, animated: true)
    }
}
