//
//  ArticleListView.swift
//  News
//
//  Created by Avito on 30/1/2024.
//

import Foundation
import UIKit

// MARK: - Prtocols
protocol ArticleListViewControllerProtocol {
    var collectionView: UICollectionView { get }
}

// Protocol for the factory
protocol ArticleListViewControllerFactory {
    func makeArticleListViewController() -> ArticleListViewController
}



// MARK: - ViewData
public struct ArticleListViewData {
    let title: String?
    let author: String?
    let description: String?
    let urlToImage: String?
    let content:String?
}

