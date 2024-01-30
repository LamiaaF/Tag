//
//  ArticleListCoordinator.swift
//  News
//
//  Created by Avito on 24/1/2024.

// ArticleListCoordinator.swift

// ArticleListCoordinator.swift

import Foundation
import UIKit

class ArticleListCoordinator: ArticleListDelegate {

    struct Dependencies {
        let articleListInteractor: ArticleListInteractor
        let articleListFormatter: ArticleListFormatter
        let articleService: ArticleListService
        let articleListViewController: ArticleListViewController
        let articleDetailFactory: ArticleDetailViewControllerFactory 
// New dependency
        var navigationController: UINavigationController?
    }

    let deps: Dependencies

    init(dependencies: Dependencies) {
        deps = dependencies
        deps.articleListViewController.delegate = self // Set the delegate
    }

    func start() {
        deps.articleListInteractor.fetchArticles() { [weak self] result in
            switch result {
            case .success:
                print("Articles successfully fetched and updated UI")

                // Update UI on the main thread
                DispatchQueue.main.async { [weak self] in
                    // Explicitly capture self to avoid the contextual type error
                    self?.reloadCollectionView()
                    self?.pushToNavigationController()
                }

            case .failure(let error):
                print("Error in ArticleListInteractor start: \(error.localizedDescription)")
            }
        }
    }

    func pushToNavigationController() {
        // Push the view controller to the navigation stack if there is a navigation controller
        if let navigationController = deps.navigationController {
            navigationController.pushViewController(deps.articleListViewController, animated: true)
        }
    }

    func reloadCollectionView() {
        // Reload data on the collectionView of the ArticleListViewController
        deps.articleListViewController.collectionView.reloadData()
    }

    // New method to show article detail
    func showArticleDetail(articleData: ArticleDetailViewData) {
        let detailViewController = deps.articleDetailFactory.makeArticleDetailViewController(articleData: articleData)
        deps.navigationController?.pushViewController(detailViewController as! UIViewController, animated: true)
    }


    // MARK: - ArticleListDelegate
    func didSelectArticle(articleData: ArticleDetailViewData) {
        showArticleDetail(articleData: articleData)
    }
}
