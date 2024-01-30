//
//  ArticleDetailView.swift
//  News
//
//  Created by Avito on 30/1/2024.
//

import Foundation
import UIKit

// MARK: - ArticleDetailViewData

struct ArticleDetailViewData {
    let title: String?
    let author: String?
    let description: String?
    let urlToImage: String?
    let content: String?
}

// MARK: - ArticleDetailView Protocol

protocol ArticleDetailView: AnyObject {
    func displayArticleDetails(articleData: ArticleDetailViewData)
}

// MARK: - ArticleListDelegate Protocol

protocol ArticleListDelegate: AnyObject {
    func didSelectArticle(articleData: ArticleDetailViewData)
    func showArticleDetail(articleData: ArticleDetailViewData)

}

// MARK: - ArticleDetailViewControllerFactory Protocol

protocol ArticleDetailViewControllerFactory {
    func makeArticleDetailViewController(articleData: ArticleDetailViewData) -> ArticleDetailView
}
