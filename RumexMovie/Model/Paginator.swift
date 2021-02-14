//
//  Paginator.swift
//  RumexMovie
//
//  Created by Sahan Ravindu on 2021-02-14.
//

import Foundation

public struct Paginator: Codable {

    public var currentPage: Int?
    public var lastPage: Int?
    public var perPage: Int?

    public init(currentPage: Int?, lastPage: Int?, perPage: Int?) {
        self.currentPage = currentPage
        self.lastPage = lastPage
        self.perPage = perPage
    }

    public enum CodingKeys: String, CodingKey {
        case currentPage = "page"
        case lastPage = "total_pages"
        case perPage = "total_results"
    }


}
