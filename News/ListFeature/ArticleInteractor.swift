//
// ArticleListInteractor.swift
//  News
//
//  Created by Avito on 9/2/2024.
//


import Foundation

class ArticleListInteractor {
    private let service: ArticleListService
    private let formatter: ArticleListFormatter
    private var articlesViewData: [ArticleListViewData] = []

    init(service: ArticleListService, formatter: ArticleListFormatter) {
        self.service = service
        self.formatter = formatter
    }

    // MARK: - Public Methods

    func fetchArticles(completion: @escaping (Result<[ArticleListViewData], Error>) -> Void) {
        // Fetch articles
        service.fetchArticles { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let articles):
                // Update the UI with the fetched articles
                print("Fetched articles successfully:", articles)

                // Convert ArticleEntity to ArticleListViewData using formatter
                let viewData = self.formatter.format(articles: articles)

                // Call the completion with the formatted view data
                completion(.success(viewData))

            case .failure(let error):
                // Call the completion with the error
                print("Error fetching articles:", error)
                completion(.failure(error))
            }
        }
    }

    func article(at index: Int) -> ArticleListViewData? {
        guard index >= 0, index < articlesViewData.count else {
            return nil
        }
        return articlesViewData[index]
    }
}

