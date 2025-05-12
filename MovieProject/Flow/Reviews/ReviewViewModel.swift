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
    
    func fetchAllReviews() {
        db.collection("reviews")
            .order(by: "timestamp", descending: true)
            .addSnapshotListener { [weak self] snapshot, error in
                if let error = error {
                    print("Error fetching reviews: \(error.localizedDescription)")
                    return
                }
                
                guard let documents = snapshot?.documents else {
                    print("No documents")
                    return
                }
                
                self?.reviews = documents.compactMap { document in
                    do {
                        var review = try document.data(as: Review.self)
                        review.id = document.documentID
                        return review
                    } catch {
                        print("Error decoding review: \(error)")
                        return nil
                    }
                }
            }
    }
    
    
    func fetchReviews(for movieId: String) {
        db.collection("reviews")
            .whereField("movieId", isEqualTo: movieId)
            .order(by: "timestamp", descending: true)
            .addSnapshotListener { snapshot, error in
                if let error = error {
                    print("Error fetching reviews: \(error.localizedDescription)")
                    return
                }
                
                self.reviews = snapshot?.documents.compactMap { document in
                    try? document.data(as: Review.self)
                } ?? []
            }
    }

    func addReview(movieId: String, rating: Int, comment: String, userName: String) {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        
        let review = Review(
            id: nil,
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
            print("Error adding review: \(error.localizedDescription)")
        }
    }

    func deleteReview(_ review: Review) {
        guard let reviewId = review.id,
              let currentUserId = Auth.auth().currentUser?.uid,
              review.userId == currentUserId else {
            print("Cannot delete - not your review or not authenticated")
            return
        }
        
        db.collection("reviews").document(reviewId).delete { error in
            if let error = error {
                print("Error deleting review: \(error.localizedDescription)")
            }
        }
    }
}
