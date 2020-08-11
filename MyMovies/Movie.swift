//
//  Movie.swift
//  MyMovies
//
//  Created by Renan Luz on 11/08/20.
//  Copyright © 2020 FIAP. All rights reserved.
//

import Foundation

struct Movie: Codable {
    var title: String
    var categories: String
    var duration: String
    var rating: Double
    var summary: String
    var image: String
}


