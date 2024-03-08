//
//  ArticleFormatter.swift
//  News
//
//  Created by Avito on 24/1/2024.
//
import Foundation

class ArticleListFormatter {
    func format(articles: [ArticleEntity]) -> [ArticleListViewData] {
        return articles.map { article in
            return ArticleListViewData(
                title: article.title,
                author: article.author, 
                description: article.description ?? "",
                urlToImage: article.urlToImage,
                content: article.content
            )
        }
    }
}


