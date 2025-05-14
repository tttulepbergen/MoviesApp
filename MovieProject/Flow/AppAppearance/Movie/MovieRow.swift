import SwiftUI
import Kingfisher

let genres = [
    Genre(id: 28, name: "Action"),
    Genre(id: 12, name: "Adventure"),
    Genre(id: 16, name: "Animation"),
    Genre(id: 35, name: "Comedy"),
    Genre(id: 80, name: "Crime"),
    Genre(id: 99, name: "Documentary"),
    Genre(id: 18, name: "Drama"),
    Genre(id: 10751, name: "Family"),
    Genre(id: 14, name: "Fantasy"),
    Genre(id: 36, name: "History"),
    Genre(id: 27, name: "Horror"),
    Genre(id: 10402, name: "Music"),
    Genre(id: 9648, name: "Mystery"),
    Genre(id: 10749, name: "Romance"),
    Genre(id: 878, name: "Science Fiction"),
    Genre(id: 10770, name: "TV Movie"),
    Genre(id: 53, name: "Thriller"),
    Genre(id: 10752, name: "War"),
    Genre(id: 37, name: "Western")
]

struct Genre {
    let id: Int
    let name: String
}

struct MovieRow: View {
    let movie: Title
    
    private var shortDescription: String {
        let desc = movie.overview ?? "No description available."
        if let endIndex = desc.firstIndex(of: ".") {
            return String(desc[..<endIndex]) + "."
        }
        return desc
    }
    
    private var genreText: String {
        movie.genre_ids.compactMap { genreId in
            genres.first { $0.id == genreId }?.name
        }.joined(separator: ", ")
    }
    
    private var primaryTitle: String {
        movie.title
    }
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            KFImage(URL(string: "https://image.tmdb.org/t/p/w500\(movie.poster_path ?? "")"))
                .placeholder {
                    Image(systemName: "photo.artframe")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.gray)
                }
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 150)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .shadow(radius: 4)
            
            VStack(alignment: .leading, spacing: 8) {
                Text(primaryTitle)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                
                if !genreText.isEmpty {
                    Text(genreText)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .lineLimit(1)
                }
                
                Text(shortDescription)
                    .font(.footnote)
                    .foregroundColor(.white.opacity(0.8))
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
            }
            
            Spacer()
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 16)
    }
}
