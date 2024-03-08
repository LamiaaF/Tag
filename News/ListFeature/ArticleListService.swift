//
//  ArticleService.swift
//  News
//
//  Created by Avito on 24/1/2024.
//

import Foundation

struct ArticleResponse: Decodable {
    let articles: [ArticleEntity]
}

class ArticleListApiService: ArticleListService {
    private let apiKey = "1e720f9e9cd845bea37152f911eb5dd9" // Replace with your actual API key

    func fetchArticles(completion: @escaping (Result<[ArticleEntity], Error>) -> Void) {
        guard let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=\(apiKey)") else {
            // Handle invalid URL error
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                // Handle empty data error
                completion(.failure(NSError(domain: "Empty Data", code: 0, userInfo: nil)))
                return
            }

            do {
                let articlesResponse = try JSONDecoder().decode(ArticleResponse.self, from: data)
                completion(.success(articlesResponse.articles))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}







