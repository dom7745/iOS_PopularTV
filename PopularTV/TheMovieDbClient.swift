//
//  TheMovieDbClient.swift
//  PopularTV
//
//  Created by Kovács Márk on 21/10/2023.
//

import Foundation

class TheMovieDbClient: ObservableObject {
    let baseURL = "https://api.themoviedb.org/3/"
    let imageBaseURL = "https://image.tmdb.org/t/p/w500"
    let apiKey = "2f5144cb4383086b3f61605f5db6fecf"
    
    @Published var tvs = PopularTVResponse()
    
    enum NetworkError: Error {
        case invalidURL
        case requestFaild(String)
    }
    
    func getPopularTVsAsync() async throws -> PopularTVResponse {
        guard let url = URL(string: "\(baseURL)tv/popular?api_key=\(apiKey)") else {
            throw NetworkError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkError.requestFaild("Invalid response")
        }
        
        return try JSONDecoder().decode(PopularTVResponse.self, from: data)
    }
    
    func getPosterUrl(posterPath: String) -> URL {
        return URL(string: "\(imageBaseURL)\(posterPath)")!
    }
}
