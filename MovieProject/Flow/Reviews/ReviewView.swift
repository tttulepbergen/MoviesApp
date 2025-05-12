//
//  ReviewView.swift
//  MovieProject
//
//  Created by Aisha Suanbekova Bakytjankyzy on 11.05.2025.
//

import SwiftUI
import FirebaseAuth

struct ReviewView: View {
    @StateObject var viewModel = ReviewViewModel()
    let movieId: Int
    let userName: String
    
    @State private var rating = 3
    @State private var comment = ""
    @State private var showRatingPicker = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Write Review Section
                VStack(alignment: .leading, spacing: 16) {
                    Text("Write a Review")
                        .font(.title3)
                        .bold()
                        .foregroundColor(.white)
                    
                    // Rating Picker
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Your Rating")
                            .foregroundColor(.white.opacity(0.8))
                        
                        HStack(spacing: 12) {
                            ForEach(1...5, id: \.self) { index in
                                Image(systemName: index <= rating ? "star.fill" : "star")
                                    .foregroundColor(index <= rating ? .yellow : .gray)
                                    .font(.title2)
                                    .onTapGesture {
                                        rating = index
                                    }
                            }
                        }
                    }
                    
                    // Comment Field
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Your Review")
                            .foregroundColor(.white.opacity(0.8))
                        
                        TextEditor(text: $comment)
                            .frame(height: 100)
                            .padding(8)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(8)
                            .foregroundColor(.white)
                    }
                    
                    Button(action: {
                        viewModel.addReview(movieId: String(movieId), rating: rating, comment: comment, userName: userName)
                        comment = ""
                        rating = 3
                    }) {
                        Text("Submit Review")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.red.opacity(0.2))
                            .cornerRadius(12)
                    }
                    .disabled(comment.isEmpty)
                    .opacity(comment.isEmpty ? 0.6 : 1)
                }
                .padding()
                .background(Color.black.opacity(0.3))
                .cornerRadius(16)
                .padding(.horizontal)
                
                // Reviews List
                VStack(alignment: .leading, spacing: 16) {
                    Text("User Reviews")
                        .font(.title3)
                        .bold()
                        .foregroundColor(.white)
                        .padding(.horizontal)
                    
                    if viewModel.reviews.isEmpty {
                        VStack(spacing: 12) {
                            Image(systemName: "text.bubble")
                                .font(.system(size: 40))
                                .foregroundColor(.gray)
                            Text("No reviews yet")
                                .foregroundColor(.gray)
                            Text("Be the first to review!")
                                .foregroundColor(.gray.opacity(0.8))
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 40)
                    } else {
                        ForEach(viewModel.reviews) { review in
                            ReviewCard(review: review) {
                                viewModel.deleteReview(review)
                            }
                        }
                    }
                }
            }
            .padding(.vertical)
        }
        .background(Color.black.edgesIgnoringSafeArea(.all))
        .navigationTitle("Reviews")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.fetchReviews(for: String(movieId))
        }
    }
}

struct ReviewCard: View {
    let review: Review
    let onDelete: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(review.userName)
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    HStack {
                        ForEach(1...5, id: \.self) { index in
                            Image(systemName: index <= review.rating ? "star.fill" : "star")
                                .foregroundColor(index <= review.rating ? .yellow : .gray)
                                .font(.caption)
                        }
                    }
                }
                
                Spacer()
                
                Text(review.timestamp, style: .date)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            Text(review.comment)
                .font(.body)
                .foregroundColor(.white.opacity(0.9))
                //.lineSpacing(4)
            
            if Auth.auth().currentUser?.uid == review.userId {
                Button(action: onDelete) {
                    Text("Delete")
                        .foregroundColor(.red)
                        .font(.caption)
                }
            }
        }
        .padding()
        .background(Color.black.opacity(0.3))
        .cornerRadius(12)
        .padding(.horizontal)
    }
}
