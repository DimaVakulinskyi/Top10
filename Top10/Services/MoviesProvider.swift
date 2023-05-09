//
//  Model.swift
//  Top10
//
//  Created by Dmytro Vakulinsky on 09.05.2023.
//

import Foundation
import UIKit

class MoviesProvider {
    
    private let imageDownloader = ImageDownloader()
    private let decoder = JSONDecoder()
    
    func fetchTopMovies(completion: (([Movie]) -> Void)?) {
        if let url = URL(string: "https://imdb-api.com/en/API/Top250Movies/k_qq6ilogf") {
            DispatchQueue.global(qos: .userInitiated).async {
                if let data = try? Data(contentsOf: url) {
                    if let movieResponse = try? self.decoder.decode(MovieResponse.self, from: data) {
                        let movies = Array(movieResponse.items.prefix(10))
                        DispatchQueue.main.async {
                            completion?(movies)
                        }
                    }
                }
            }
        }
    }
    
    func getImage(with identifier: String) async -> UIImage? {
        return await imageDownloader.getImage(with: identifier)
    }
    
}

