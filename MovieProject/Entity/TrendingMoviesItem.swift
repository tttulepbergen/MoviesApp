import Foundation

struct TrendingTitleResponse: Codable {
    let results: [Title]
}

struct Title: Codable, Identifiable, Equatable {
    let id: Int
    let original_name: String?
    let original_title: String?
    let poster_path: String?
    let overview: String?
    let release_date: String?
    let vote_average: Double
    let genre_ids: [Int]

    var title: String {
        return original_title ?? original_name ?? "No Title"
    }

    var posterUrl: String {
        return "https://image.tmdb.org/t/p/w500\(poster_path ?? "")"
    }

    var description: String {
        return overview ?? "No Description Available"
    }

    var releaseDate: String {
        return release_date ?? "Unknown Release Date"
    }

    var rating: Double {
        return vote_average
    }
}
