//
//  MovieResponse.swift
//  Top10
//
//  Created by Dmytro Vakulinsky on 09.05.2023.
//

import Foundation

struct Movie: Codable {
    let title: String
    let image: String
    let imDbRating: String
}

struct MovieResponse: Codable {
    let items: [Movie]
}
