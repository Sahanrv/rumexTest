//
//  getMovieResponce.swift
//  RumexMovie
//
//  Created by Sahan Ravindu on 2021-02-14.
//

import Foundation


struct GetMovieResponce: Codable {
    let page: Int
    let results: [Movie]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
