//
//  AppCoordinator.swift
//  News
//
//  Created by Avito on 24/1/2024.
//
import Foundation
import UIKit

class AppCoordinator: NSObject {
    var window: UIWindow?
    var navigationController: UINavigationController
    var articleListCoordinator: ArticleListCoordinator?

    init?(window: UIWindow?) {
        self.window = window
        self.navigationController = UINavigationController()
        
        // Create the necessary dependencies for ArticleListInteractor
        let articleListService = ArticleListApiService()
        let articleListFormatter = ArticleListFormatter()
        let articleInteractor = ArticleListInteractor(service: articleListService, formatter: articleListFormatter)
        
        // Create the necessary dependencies for ArticleListViewController
        let articleListViewController = ArticleListViewController(articles: [])
        
        // Initialize ArticleListCoordinator
        self.articleListCoordinator = ArticleListCoordinator(
            articleListInteractor: articleInteractor,
            articleListViewController: articleListViewController,
            navigationController: self.navigationController
        )
    }
        func start(window: UIWindow) {
            articleListCoordinator?.start()
            window.rootViewController = articleListCoordinator?.navigationController
            window.makeKeyAndVisible()
        }
    }



