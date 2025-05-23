import Foundation
import FirebaseFirestore

struct Review: Identifiable, Codable {
    @DocumentID var id: String?
    let movieId: String
    let userId: String
    let userName: String
    let rating: Int
    let comment: String
    let timestamp: Date
}
