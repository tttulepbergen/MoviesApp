import SwiftUI
import Kingfisher
import WebKit
import FirebaseAuth

struct MovieDetailsView: View {
    var movie: Title
    @State private var trailerState: TrailerState = .loading
    @EnvironmentObject var favoritesViewModel: FavoritesViewModel
    @State private var showHeartOverlay = false
    
    let userName = Auth.auth().currentUser?.displayName ?? "Anonymous"
    
    enum TrailerState {
        case loading
        case loaded(String)
        case error(String)
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Header with poster and basic info
                HStack(alignment: .top, spacing: 16) {
                    KFImage(URL(string: movie.posterUrl))
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: UIScreen.main.bounds.width * 0.4, height: 250)
                        .clipped()
                        .cornerRadius(12)
                        .shadow(radius: 5)
                    
                    VStack(alignment: .leading, spacing: 12) {
                        Text(movie.title)
                            .font(.title2)
                            .bold()
                            .foregroundColor(.white)
                            .lineLimit(2)
                        
                        HStack {
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                            Text(String(format: "%.1f", movie.vote_average))
                                .foregroundColor(.white)
                        }
                        
                        Text("Released: \(movie.releaseDate)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        
                        let genreNames = movie.genre_ids.compactMap { genreId in
                            genres.first { $0.id == genreId }?.name
                        }
                        if !genreNames.isEmpty {
                            Text(genreNames.joined(separator: ", "))
                                .font(.subheadline)
                                .foregroundColor(.gray)
                                .lineLimit(2)
                        }
                    }
                }
                .padding(.horizontal)
                
                // Trailer Section
                VStack(alignment: .leading, spacing: 12) {
                    Text("Trailer")
                        .font(.title3)
                        .bold()
                        .foregroundColor(.white)
                        .padding(.horizontal)
                    
                    Group {
                        switch trailerState {
                        case .loading:
                            ProgressView("Loading trailer...")
                                .frame(height: 200)
                                .frame(maxWidth: .infinity)
                                .foregroundColor(.white)
                        case .loaded(let url):
                            WebView(url: url)
                                .frame(height: 200)
                                .cornerRadius(12)
                        case .error(let message):
                            VStack(spacing: 8) {
                                Image(systemName: "exclamationmark.triangle")
                                    .font(.largeTitle)
                                    .foregroundColor(.red)
                                Text("Trailer not available")
                                    .foregroundColor(.white)
                                Text(message)
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                            .frame(height: 200)
                            .frame(maxWidth: .infinity)
                        }
                    }
                    .padding(.horizontal)
                }
                
                // Overview Section
                VStack(alignment: .leading, spacing: 12) {
                    Text("Overview")
                        .font(.title3)
                        .bold()
                        .foregroundColor(.white)
                    
                    Text(movie.description)
                        .font(.body)
                        .foregroundColor(.white.opacity(0.9))
                        .lineSpacing(4)
                }
                .padding(.horizontal)
                
                // Action Buttons
                VStack(spacing: 16) {
                    Button(action: toggleFavorite) {
                        HStack {
                            Image(systemName: favoritesViewModel.isFavorite(movie) ? "heart.fill" : "heart")
                                .foregroundColor(favoritesViewModel.isFavorite(movie) ? .red : .white)
                            Text(favoritesViewModel.isFavorite(movie) ? "Remove from Favorites" : "Add to Favorites")
                                .foregroundColor(.white)
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.red.opacity(0.2))
                        .cornerRadius(12)
                    }
                    
                    NavigationLink(destination: ReviewView(movieId: movie.id, userName: userName)) {
                        HStack {
                            Image(systemName: "text.bubble")
                                .foregroundColor(.white)
                            Text("View & Write Reviews")
                                .foregroundColor(.white)
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.red.opacity(0.2))
                        .cornerRadius(12)
                    }
                }
                .padding(.horizontal)
                .padding(.top, 8)
            }
            .padding(.vertical)
        }
        .background(Color.black.edgesIgnoringSafeArea(.all))
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            loadTrailer()
        }
        .overlay(
            Group {
                if showHeartOverlay {
                    Image(systemName: "heart.fill")
                        .resizable()
                        .frame(width: 80, height: 80)
                        .foregroundColor(.red)
                        .opacity(0.8)
                        .transition(.scale)
                }
            }
        )
    }
    
    private func loadTrailer() {
        trailerState = .loading
        let searchQuery = "\(movie.title) trailer \(movie.releaseDate.prefix(4))"
        
        APICaller.shared.getMovie(with: searchQuery) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let video):
                    if !video.id.videoId.isEmpty {
                        let url = "https://www.youtube.com/embed/\(video.id.videoId)"
                        trailerState = .loaded(url)
                    } else {
                        trailerState = .error("No trailer found")
                    }
                case .failure(let error):
                    trailerState = .error(error.localizedDescription)
                }
            }
        }
    }
    
    private func toggleFavorite() {
        if favoritesViewModel.isFavorite(movie) {
            favoritesViewModel.removeFavorite(movie)
        } else {
            favoritesViewModel.addFavorite(movie)
        }
        withAnimation(.spring()) {
            showHeartOverlay = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            withAnimation {
                showHeartOverlay = false
            }
        }
    }
}

// MARK: - Extensions for Color Analysis
extension UIImage {
    var averageColor: UIColor? {
        guard let inputImage = CIImage(image: self) else { return nil }
        let extentVector = CIVector(x: inputImage.extent.origin.x,
                                    y: inputImage.extent.origin.y,
                                    z: inputImage.extent.size.width,
                                    w: inputImage.extent.size.height)

        guard let filter = CIFilter(name: "CIAreaAverage",
                                    parameters: [kCIInputImageKey: inputImage,
                                                 kCIInputExtentKey: extentVector]),
              let outputImage = filter.outputImage else { return nil }

        var bitmap = [UInt8](repeating: 0, count: 4)
        let context = CIContext(options: [.workingColorSpace: kCFNull as Any])
        context.render(outputImage,
                       toBitmap: &bitmap,
                       rowBytes: 4,
                       bounds: CGRect(x: 0, y: 0, width: 1, height: 1),
                       format: .RGBA8,
                       colorSpace: nil)

        return UIColor(red: CGFloat(bitmap[0]) / 255,
                       green: CGFloat(bitmap[1]) / 255,
                       blue: CGFloat(bitmap[2]) / 255,
                       alpha: CGFloat(bitmap[3]) / 255)
    }
}

extension UIColor {
    func darker(by percentage: CGFloat = 30.0) -> UIColor? {
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        if self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            return UIColor(red: max(red - percentage / 100, 0.0),
                           green: max(green - percentage / 100, 0.0),
                           blue: max(blue - percentage / 100, 0.0),
                           alpha: alpha)
        }
        return nil
    }
}
