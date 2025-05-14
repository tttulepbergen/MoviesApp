import Foundation
import Alamofire

struct Constants {
    static let API_KEY = "697d439ac993538da4e3e60b54e762cd"
    static let baseURL = "https://api.themoviedb.org"
    static let YoutubeAPI_KEY = "AIzaSyDqX8axTGeNpXRiISTGL7Tya7fjKJDYi4g"
    static let YoutubeBaseURL = "https://youtube.googleapis.com/youtube/v3/search?"
}

enum APIError: Error {
    case failedTogetData
}

class APICaller {
    static let shared = APICaller()
 
    func getTrendingMovies(completion: @escaping (Result<[Title], Error>) -> Void) {
        let url = "\(Constants.baseURL)/3/trending/movie/day?api_key=\(Constants.API_KEY)"
        
        AF.request(url).responseDecodable(of: TrendingTitleResponse.self) { response in
            switch response.result {
            case .success(let result):
                completion(.success(result.results))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func search(with query: String, completion: @escaping (Result<[Title], Error>) -> Void) {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        let url = "\(Constants.baseURL)/3/search/movie?api_key=\(Constants.API_KEY)&query=\(query)"
        
        AF.request(url).responseDecodable(of: TrendingTitleResponse.self) { response in
            switch response.result {
            case .success(let result):
                completion(.success(result.results))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func getMovie(with query: String, completion: @escaping (Result<VideoElement, Error>) -> Void) {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        let url = "\(Constants.YoutubeBaseURL)q=\(query)&key=\(Constants.YoutubeAPI_KEY)&type=video&part=snippet"
        
        AF.request(url).responseDecodable(of: YoutubeSearchResponse.self) { response in
            switch response.result {
            case .success(let result):
                if let firstVideo = result.items.first {
                    completion(.success(firstVideo))
                } else {
                    completion(.failure(APIError.failedTogetData))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func getTopTVShows(completion: @escaping (Result<[Title], Error>) -> Void) {
        let url = "\(Constants.baseURL)/3/tv/top_rated?api_key=\(Constants.API_KEY)"
        
        AF.request(url).responseDecodable(of: TrendingTitleResponse.self) { response in
            switch response.result {
            case .success(let result):
                completion(.success(result.results))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func getOngoingTVShows(completion: @escaping (Result<[Title], Error>) -> Void) {
        let url = "\(Constants.baseURL)/3/tv/on_the_air?api_key=\(Constants.API_KEY)"
        
        AF.request(url).responseDecodable(of: TrendingTitleResponse.self) { response in
            switch response.result {
            case .success(let result):
                completion(.success(result.results))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
        func getPopularMovies(completion: @escaping (Result<[Title], Error>) -> Void) {
            let url = "\(Constants.baseURL)/3/movie/popular"
            let parameters: Parameters = ["api_key": Constants.API_KEY]
    
            AF.request(url, parameters: parameters).validate().responseDecodable(of: TrendingTitleResponse.self) { response in
                switch response.result {
                case .success(let results):
                    completion(.success(results.results))
                case .failure:
                    completion(.failure(APIError.failedTogetData))
                }
            }
        }
    
        func getUpcomingMovies(completion: @escaping (Result<[Title], Error>) -> Void) {
            let url = "\(Constants.baseURL)/3/movie/upcoming"
            let parameters: Parameters = ["api_key": Constants.API_KEY]
    
            AF.request(url, parameters: parameters).validate().responseDecodable(of: TrendingTitleResponse.self) { response in
                switch response.result {
                case .success(let results):
                    completion(.success(results.results))
                case .failure:
                    completion(.failure(APIError.failedTogetData))
                }
            }
        }
}
