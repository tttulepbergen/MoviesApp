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
    let movieTitle: String
    let userName: String
    
    @State private var rating = 3
    @State private var comment = ""

    var body: some View {
        VStack {
            // Movie Title
            Text(movieTitle.uppercased())
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(.top)
            
            // Reviews List
            List {
                ForEach(viewModel.reviews) { review in
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Text(review.userName)
                                .font(.headline)
                                .foregroundColor(.white)
                            
                            Spacer()
                            
                            // Rating Stars
                            HStack(spacing: 2) {
                                ForEach(1...5, id: \.self) { star in
                                    Image(systemName: star <= review.rating ? "star.fill" : "star")
                                        .foregroundColor(star <= review.rating ? .yellow : .gray)
                                }
                            }
                        }
                        
                        Text(review.comment)
                            .font(.body)
                            .foregroundColor(.white.opacity(0.9))
                        
                        Text(review.timestamp, style: .date)
                            .font(.caption)
                            .foregroundColor(.gray)
                        
                        // Delete Button for Current User's Review
                        if Auth.auth().currentUser?.uid == review.userId {
                            Button(action: {
                                viewModel.deleteReview(review)
                            }) {
                                Text("Delete")
                                    .foregroundColor(.red)
                                    .font(.caption)
                            }
                        }
                    }
                    .padding(.vertical, 8)
                    .listRowBackground(Color.black)
                }
                .onDelete { indexSet in
                    guard let currentUserId = Auth.auth().currentUser?.uid else { return }
                    let myReviews = viewModel.reviews.filter { $0.userId == currentUserId }
                    indexSet.map { myReviews[$0] }.forEach(viewModel.deleteReview)
                }
            }
            .listStyle(PlainListStyle())
            
            // Add Review Section
            Divider()
                .background(Color.gray)
                .padding(.vertical)
            
            VStack(spacing: 12) {
                HStack {
                    Text("Your rating:")
                        .foregroundColor(.white)
                    Spacer()
                    // Custom Stars
                    HStack(spacing: 2) {
                        ForEach(1...5, id: \.self) { star in
                            Image(systemName: star <= rating ? "star.fill" : "star")
                                .foregroundColor(star <= rating ? .yellow : .gray)
                                .onTapGesture {
                                    rating = star // Update rating when a star is tapped
                                }
                        }
                    }
                }
                
                TextField("Write your review", text: $comment)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .colorScheme(.dark)
                
                Button("SUBMIT REVIEW") {
                    viewModel.addReview(
                        movieId: String(movieId),
                        rating: rating,
                        comment: comment,
                        userName: userName
                    )
                    comment = ""
                }
                .disabled(comment.isEmpty)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            .padding()
        }
        .colorScheme(.dark)
        .background(Color.black.edgesIgnoringSafeArea(.all))
        .onAppear {
            viewModel.fetchReviews(for: String(movieId))
        }
        .navigationTitle("REVIEWS")
        .navigationBarTitleDisplayMode(.inline)
    }
}
