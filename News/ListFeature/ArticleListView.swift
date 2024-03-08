//
//  ArticleListView.swift
//  News
//
//  Created by Avito on 30/1/2024.
//

// MARK: - Protocols
import Foundation
import UIKit

protocol ArticleListViewControllerDelegate: AnyObject {
    func didFetchArticles()
    func didSelectArticle(_ article: ArticleListViewData)
}

protocol ArticleListViewControllerFactory {
    func makeArticleListViewController(coordinatorDelegate: ArticleListViewControllerDelegate, interactor: ArticleListInteractor) -> ArticleListViewController
}

// MARK: - Concrete Implementation of the Factory

class DefaultArticleListViewControllerFactory: ArticleListViewControllerFactory {
    func makeArticleListViewController(coordinatorDelegate: ArticleListViewControllerDelegate, interactor: ArticleListInteractor) -> ArticleListViewController {
        let articles: [ArticleListViewData] = []
        let viewController = ArticleListViewController(articles: articles)
        viewController.coordinatorDelegate = coordinatorDelegate
        return viewController
    }
}

// MARK: - Service Protocol

protocol ArticleListService {
    func fetchArticles(completion: @escaping (Result<[ArticleEntity], Error>) -> Void)
}

// MARK: - ViewData

public struct ArticleListViewData {
    let title: String?
    let author: String?
    let description: String?
    let urlToImage: String?
    let content: String?
}

