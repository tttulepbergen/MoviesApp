import Foundation
import Alamofire

struct Constants {
    static let API_KEY = "697d439ac993538da4e3e60b54e762cd"
    static let baseURL = "https://api.themoviedb.org"
    static let YoutubeAPI_KEY = "AIzaSyDqX8axTGeNpXRiISTGL7Tya7fjKJDYi4g"
    static let YoutubeBaseURL = "https://youtube.googleapis.com/youtube/v3/search"
}

enum APIError: Error {
    case failedToGetData
}

class APICaller {
    static let shared = APICaller()

    func getTrendingMovies(completion: @escaping (Result<[Title], Error>) -> Void) {
        let url = "\(Constants.baseURL)/3/trending/movie/day"
        let parameters: Parameters = ["api_key": Constants.API_KEY]

        AF.request(url, parameters: parameters)
            .validate()
            .responseDecodable(of: TrendingTitleResponse.self) { response in
                switch response.result {
                case .success(let data):
                    completion(.success(data.results))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }

    func search(with query: String, completion: @escaping (Result<[Title], Error>) -> Void) {
        guard let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            completion(.failure(APIError.failedToGetData))
            return
        }

        let url = "\(Constants.baseURL)/3/search/movie"
        let parameters: Parameters = [
            "api_key": Constants.API_KEY,
            "query": encodedQuery
        ]

        AF.request(url, parameters: parameters)
            .validate()
            .responseDecodable(of: TrendingTitleResponse.self) { response in
                switch response.result {
                case .success(let data):
                    completion(.success(data.results))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }

    func getMovie(with query: String, completion: @escaping (Result<VideoElement, Error>) -> Void) {
        guard let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            completion(.failure(APIError.failedToGetData))
            return
        }

        let parameters: Parameters = [
            "q": encodedQuery,
            "key": Constants.YoutubeAPI_KEY
        ]

        AF.request(Constants.YoutubeBaseURL, parameters: parameters)
            .validate()
            .responseDecodable(of: YoutubeSearchResponse.self) { response in
                switch response.result {
                case .success(let data):
                    if let firstVideo = data.items.first {
                        completion(.success(firstVideo))
                    } else {
                        completion(.failure(APIError.failedToGetData))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
