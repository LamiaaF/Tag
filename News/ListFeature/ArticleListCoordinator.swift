//
//  ArticleListCoordinator.swift
//  News
//
//  Created by Avito on 9/2/2024.
//


import Foundation
import UIKit


class ArticleListCoordinator: NSObject, ArticleListViewControllerDelegate {
  
    weak var coordinatorDelegate: ArticleListViewControllerDelegate?
    
    let articleListInteractor: ArticleListInteractor
    let articleListViewController: ArticleListViewController
    var navigationController: UINavigationController?
    
    init(
        articleListInteractor: ArticleListInteractor,
        articleListViewController: ArticleListViewController,
        navigationController: UINavigationController?
    ) {
        self.articleListInteractor = articleListInteractor
        self.articleListViewController = articleListViewController
        self.navigationController = navigationController
        
        // Call super.init last
        super.init()
        
        // Set the coordinatorDelegate of the ArticleListViewController to self
        self.articleListViewController.coordinatorDelegate = self
    }
    
    func start() {
        articleListInteractor.fetchArticles() { [weak self] result in
            switch result {
            case .success(let articles):
                print("Articles successfully fetched:", articles)
                
                // Update UI on the main thread
                DispatchQueue.main.async { [weak self] in
                    // Update the articles in the view controller
                    self?.articleListViewController.updateArticles(with: articles)
                    
                    // Call the delegate method after updating the articles
                    self?.didFetchArticles()
                    
                    // Push the view controller
                    self?.pushToNavigationController()
                }
                
            case .failure(let error):
                print("Error fetching articles:", error)
            }
        }
    }
    
    func pushToNavigationController() {
        // Check if navigationController is set before pushing the view controller
        if let navigationController = navigationController {
            navigationController.pushViewController(articleListViewController, animated: true)
        }
    }
    
    func didFetchArticles() {
        // Check if coordinatorDelegate is set before calling its methods
        coordinatorDelegate?.didFetchArticles()
    }
    func didSelectArticle(_ article: ArticleListViewData) {
        // Create ArticleDetailsViewController with selected article
        let detailsViewController = ArticleDetailsViewController(articleDetails: article)

        // Push the details view controller
        navigationController?.pushViewController(detailsViewController, animated: true)
    }

 
  
}

