
import UIKit

// MARK: - Структура для JSON
struct NewsRespond: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}

struct Article: Codable {
    let source: Source
    let author: String?
    let title: String?
    let url: String?
    let urlToImage: String?

    enum CodingKeys: String, CodingKey {
        case source, author, title, url, urlToImage
    }
}

struct Source: Codable {
    let id: String?
    let name: String
}
