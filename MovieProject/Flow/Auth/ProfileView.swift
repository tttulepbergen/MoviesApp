//
//  MovieProjectApp.swift
//  MovieProject
//
//  Created by Polina Stelmakh on 09.05.2025.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct ProfileView: View {
    let userName: String
    let userEmail: String
    let memberSince: String
    let userID: String
    @Binding var isLoggedIn: Bool
    @EnvironmentObject var favoritesViewModel: FavoritesViewModel
    @StateObject private var reviewViewModel = ReviewViewModel()
    
    @State private var selectedSegment = 0
    @State private var showAllReviews = false
    @State private var movieTitles: [String: String] = [:]
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 8) {
                    // Profile Header
                    Spacer().frame(height: 8)
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .frame(width: 80, height: 80)
                        .foregroundColor(.white.opacity(0.9))
                        .shadow(radius: 8)
                    
                    Text(userName.isEmpty ? "Your Name" : userName)
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text(userEmail.isEmpty ? "your@email.com" : userEmail)
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.8))
                    
                    HStack(spacing: 16) {
                        VStack {
                            Text("User ID")
                                .font(.caption)
                                .foregroundColor(.white.opacity(0.7))
                            Text(userID)
                                .font(.footnote)
                                .foregroundColor(.white)
                                .bold()
                        }
                        
                        VStack {
                            Text("Member since")
                                .font(.caption)
                                .foregroundColor(.white.opacity(0.7))
                            Text(memberSince)
                                .font(.footnote)
                                .foregroundColor(.white)
                                .bold()
                        }
                    }
                    
                    Divider()
                        .background(Color.white.opacity(0.3))
                        .padding(.horizontal)
                    
                    // Segmented Control
                    Picker("Options", selection: $selectedSegment) {
                        Text("Favorites").tag(0)
                        Text("Reviews").tag(1)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.horizontal)
                    
                    if selectedSegment == 1 {
                        Toggle("Show all reviews", isOn: $showAllReviews)
                            .padding(.horizontal)
                            .foregroundColor(.white)
                    }
                    
                    // Content
                    if selectedSegment == 0 {
                        // Favorites List
                        if favoritesViewModel.favoriteMovies.isEmpty {
                            Text("No favorites yet")
                                .foregroundColor(.white)
                                .padding()
                        } else {
                            List {
                                ForEach(favoritesViewModel.favoriteMovies) { movie in
                                    NavigationLink(destination: MovieDetailsView(movie: movie)) {
                                        MovieRow(movie: movie)
                                    }
                                    .listRowBackground(Color.black)
                                }
                                .onDelete(perform: deleteFavorite)
                            }
                            .listStyle(PlainListStyle())
                        }
                    } else {
                        // Reviews List
                        if filteredReviews.isEmpty {
                            Text(showAllReviews ? "No reviews available" : "You haven't written any reviews yet")
                                .foregroundColor(.white)
                                .padding()
                        } else {
                            List {
                                ForEach(filteredReviews) { review in
                                    ReviewRow(review: review, movieTitle: movieTitles[review.movieId] ?? "Unknown Movie")
                                        .listRowBackground(Color.black)
                                        .swipeActions {
                                            if review.userId == Auth.auth().currentUser?.uid {
                                                Button(role: .destructive) {
                                                    reviewViewModel.deleteReview(review)
                                                } label: {
                                                    Label("Delete", systemImage: "trash")
                                                }
                                            }
                                        }
                                }
                            }
                            .listStyle(PlainListStyle())
                        }
                    }
                    
                    Spacer()
                    
                    // Logout Button
                    Button(action: logout) {
                        Text("Logout")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding(.horizontal)
                    }
                    .padding(.bottom, 16)
                }
            }
            .navigationTitle("Profile")
            .navigationBarHidden(true)
            .onAppear {
                if (Auth.auth().currentUser?.uid) != nil {
                    reviewViewModel.fetchAllReviews()
                    loadMovieTitles()
                }
            }
        }.colorScheme(.dark)
    }
    
    private var filteredReviews: [Review] {
        if showAllReviews {
            return reviewViewModel.reviews
        } else {
            return reviewViewModel.reviews.filter { $0.userId == Auth.auth().currentUser?.uid }
        }
    }
    
    private func deleteFavorite(at offsets: IndexSet) {
        favoritesViewModel.favoriteMovies.remove(atOffsets: offsets)
    }
    
    private func logout() {
        do {
            try Auth.auth().signOut()
            isLoggedIn = false
        } catch {
            print("Error signing out: \(error.localizedDescription)")
        }
    }
    
    private func loadMovieTitles() {
        let movieIds = Set(reviewViewModel.reviews.map { $0.movieId })
        
        for movieId in movieIds {
            // Здесь можно реализовать загрузку названий фильмов из:
            // 1. Локального кеша
            // 2. Firestore
            // 3. API TMDB
            
            // Пример временной реализации:
            movieTitles[movieId] = "Movie \(movieId)"
        }
    }
}

struct ReviewRow: View {
    let review: Review
    let movieTitle: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(review.userName)
                    .font(.headline)
                    .foregroundColor(.white)
                
                Spacer()
                
                HStack(spacing: 2) {
                    ForEach(1...5, id: \.self) { star in
                        Image(systemName: star <= review.rating ? "star.fill" : "star")
                            .foregroundColor(star <= review.rating ? .yellow : .gray)
                    }
                }
            }
            
            Text(movieTitle.uppercased())
                .font(.subheadline)
                .foregroundColor(.gray)
            
            Text(review.comment)
                .font(.body)
                .foregroundColor(.white.opacity(0.9))
            
            Text(review.timestamp, style: .date)
                .font(.caption)
                .foregroundColor(.gray)
        }
        .padding(.vertical, 8)
    }
}
