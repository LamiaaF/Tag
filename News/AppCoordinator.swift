//
//  AppCoordinator.swift
//  News
//
//  Created by Avito on 24/1/2024.
//

import Foundation
import UIKit

class AppCoordinator {
    let articleListCoordinator: ArticleListCoordinator

    init() {
        let articleListService = ArticleListApiService()
        let articleListFormatter = ArticleListFormatter()
        let articleInteractor = ArticleListInteractor(service: articleListService, formatter: articleListFormatter)

        let viewControllerFactory = DefaultArticleListViewControllerFactory(
            articleService: articleListService,
            articleInteractor: articleInteractor,
            articleListFormatter: articleListFormatter
        )

        let articleDetailFactory = DefaultArticleDetailViewControllerFactory()

        let articleListViewController = viewControllerFactory.makeArticleListViewController()

        let navigationController = UINavigationController()
        let dependencies = ArticleListCoordinator.Dependencies(
            articleListInteractor: articleInteractor,
            articleListFormatter: articleListFormatter,
            articleService: articleListService,
            articleListViewController: articleListViewController,
            articleDetailFactory: articleDetailFactory,
            navigationController: navigationController
        )

        articleListCoordinator = ArticleListCoordinator(dependencies: dependencies)
    }

    func start(window: UIWindow) {
        articleListCoordinator.start()
        window.rootViewController = articleListCoordinator.deps.navigationController
        window.makeKeyAndVisible()
    }
}


    
    


