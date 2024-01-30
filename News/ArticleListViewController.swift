// ArticleListViewController.swift

import Foundation
import UIKit

class DefaultArticleListViewControllerFactory: ArticleListViewControllerFactory {

    let articleService: ArticleListService
    let articleInteractor: ArticleListInteractor
    let articleListFormatter: ArticleListFormatter

    init(articleService: ArticleListService, articleInteractor: ArticleListInteractor, articleListFormatter: ArticleListFormatter) {
        self.articleService = articleService
        self.articleInteractor = articleInteractor
        self.articleListFormatter = articleListFormatter
    }

    func makeArticleListViewController() -> ArticleListViewController {
        return ArticleListViewController(
            articleService: articleService,
            articleInteractor: articleInteractor,
            articleListFormatter: articleListFormatter
        )
    }
}

class ArticleListViewController: UIViewController {
    

    // MARK: - Properties

    private let articleService: ArticleListService
    private let articleInteractor: ArticleListInteractor
    private let articleListFormatter: ArticleListFormatter
    weak var delegate: ArticleListDelegate?

    private let headlinesLabel: UILabel = {
        let label = UILabel()
        label.text = "Top Headlines"
        label.backgroundColor = .systemBackground
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

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
        collectionView.register(ArticleCell.self, forCellWithReuseIdentifier: ArticleCell.reuseIdentifier)
        return collectionView
    }()

    // MARK: - Initialization

    init(articleService: ArticleListService, articleInteractor: ArticleListInteractor, articleListFormatter: ArticleListFormatter) {
        self.articleService = articleService
        self.articleInteractor = articleInteractor
        self.articleListFormatter = articleListFormatter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground

        print("View did load called")
        setupHeadlinesLabel()
        setupCollectionView()
        loadArticles()
    }

    // MARK: - UI Setup Extension

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

    // MARK: - Data Loading Extension

    private func loadArticles() {
        print("Loading articles...")
        articleInteractor.fetchArticles { [weak self] (result: Result<Void, Error>) in
            guard let self = self else { return }
            switch result {
            case .success:
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                    print("Articles loaded, collection view reloaded")
                }
            case .failure(let error):
                print("Error loading articles: \(error)")
            }
        }
    }
}

// MARK: - UICollectionViewDataSource Extension

extension ArticleListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return articleInteractor.numberOfArticles()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ArticleCell.reuseIdentifier, for: indexPath) as? ArticleCell else {
            fatalError("Unexpected cell type at indexPath \(indexPath)")
        }

        if let article = articleInteractor.article(at: indexPath.item) {
            let viewData = ArticleListViewData(
                title: article.title,
                author: article.author ?? "Unknown Author",
                description: article.description ?? "",
                urlToImage: article.urlToImage,
                content: article.content
            )
            cell.configure(with: viewData)
        }

        return cell
    }
}

// MARK: - UICollectionViewDelegate Extension

extension ArticleListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelectArticle(at: indexPath.item)
    }
    
}

extension ArticleListViewController: ArticleListViewControllerProtocol {
    func didSelectArticle(at index: Int) {
        guard let article = articleInteractor.article(at: index) else {
            return
        }

        let detailViewModel = ArticleDetailViewData(
            title: article.title,
            author: article.author,
            description: article.description,
            urlToImage: article.urlToImage,
            content: article.content
        )

        // Notify the coordinator to show the detail view
        delegate?.showArticleDetail(articleData: detailViewModel)
    }
}


