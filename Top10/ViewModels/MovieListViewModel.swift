//
//  MovieListViewModel.swift
//  Top10
//
//  Created by Dmytro Vakulinsky on 09.05.2023.
//

import Foundation
import UIKit

protocol MovieListViewModelDelegate: AnyObject {
    func didLoadData()
}

class MovieListViewModel {
    let title = "Top 10 Movies"
    var movies = [Movie]()
    weak var delegate: MovieListViewModelDelegate?
    
    private let moviesProvider = MoviesProvider()
    private let imageDownloader = ImageDownloader()
    
    func loadData() {
        moviesProvider.fetchTopMovies { [weak self] in
            guard let self else { return }
            movies = $0
            delegate?.didLoadData()
        }
    }
    
    func getImage(with identifier: String) async -> UIImage? {
        return await imageDownloader.getImage(with: identifier)
    }
}
