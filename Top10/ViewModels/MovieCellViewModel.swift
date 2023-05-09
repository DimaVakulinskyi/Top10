//
//  CellViewModel .swift
//  Top10
//
//  Created by Dmytro Vakulinsky on 09.05.2023.
//

import Foundation
import UIKit

protocol MovieCellViewModelDelegate: AnyObject {
    func didLoad(image: UIImage?)
}

class MovieCellViewModel {
    var movieTitle: String {
        movie.title
    }
    
    var ratingText: String {
        "IMDb Rating: \(movie.imDbRating)"
    }
    
    weak var delegate: MovieCellViewModelDelegate?
    
    private let movie: Movie
    private var imageLoadTask: Task<Void, Error>?
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    func loadData() {
        imageLoadTask = Task { @MainActor [weak self] in
            guard let self else {
                self?.delegate?.didLoad(image: nil)
                return
            }
            let image = await ImageDownloader.shared.getImage(with: movie.image)
            delegate?.didLoad(image: image)
        }
    }
    
    func cancelDataLoad() {
        imageLoadTask?.cancel()
        imageLoadTask = nil
    }
}
