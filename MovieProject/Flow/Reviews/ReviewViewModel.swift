//
//  ReviewViewModel.swift
//  MovieProject
//
//  Created by Aisha Suanbekova Bakytjankyzy on 11.05.2025.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class ReviewViewModel: ObservableObject {
    @Published var reviews: [Review] = []
    private var db = Firestore.firestore()
    
    func fetchReviews(for movieId: String) {
        db.collection("reviews")
            .whereField("movieId", isEqualTo: movieId)
            .order(by: "timestamp", descending: true)
            .addSnapshotListener { snapshot, error in
                if let error = error {
                    print("Error fetching reviews: \(error)")
                    return
                }
                self.reviews = snapshot?.documents.compactMap {
                    try? $0.data(as: Review.self)
                } ?? []
            }
    }

    func addReview(movieId: String, rating: Int, comment: String, userName: String) {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        
        let review = Review(
            movieId: movieId,
            userId: userId,
            userName: userName,
            rating: rating,
            comment: comment,
            timestamp: Date()
        )
        
        do {
            _ = try db.collection("reviews").addDocument(from: review)
        } catch {
            print("Failed to add review: \(error)")
        }
    }

    func deleteReview(_ review: Review) {
        guard let id = review.id else { return }
        db.collection("reviews").document(id).delete()
    }

    func updateReview(_ review: Review, newComment: String, newRating: Int) {
        guard let id = review.id else { return }
        db.collection("reviews").document(id).updateData([
            "comment": newComment,
            "rating": newRating,
            "timestamp": Date()
        ])
    }
}
