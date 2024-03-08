//
//  Entity.swift
//  News
//
//  Created by Avito on 7/2/2024.
//

import Foundation

struct ArticleEntity: Decodable {
    let source: Source
    let author: String?
    let title: String
    let description: String?
    let urlToImage: String? 
    let publishedAt: String?
    let content: String?

    struct Source: Decodable {
        let id: String?
        let name: String
    }
}

