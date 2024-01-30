// ArticleListInteractor.swift

import Foundation

import Foundation

class ArticleListInteractor {
    private let service: ArticleListService
    private let formatter: ArticleListFormatter
    private var articlesViewData: [ArticleListViewData] = []

    init(service: ArticleListService, formatter: ArticleListFormatter) {
        self.service = service
        self.formatter = formatter
    }

    func fetchArticles(completion: @escaping (Result<Void, Error>) -> Void) {
        // Fetch articles
        service.fetchArticles { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let articles):
                // Update the UI with the fetched articles
                print("Fetched articles successfully:", articles)
                
                // Assuming articles is an array of ArticleEntity
                self.articlesViewData = articles.map { article in
                    ArticleListViewData(
                        title: article.title,
                        author: article.author ?? "Unknown Author",
                        description: article.description ?? "",
                        urlToImage: article.urlToImage,
                        content: article.content 
                    )
                }

                // Call the completion with success
                completion(.success(()))

            case .failure(let error):
                // Call the completion with the error
                print("Error fetching articles:", error)
                completion(.failure(error))
            }
        }
    }

    
    func numberOfArticles() -> Int {
            return articlesViewData.count
        }

    func article(at index: Int) -> ArticleListViewData? {
        guard index >= 0, index < articlesViewData.count else {
            return nil
        }
        return articlesViewData[index]
    }


    
}
