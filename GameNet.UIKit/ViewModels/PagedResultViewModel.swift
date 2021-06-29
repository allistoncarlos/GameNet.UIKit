//
//  PagedResultViewModel.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 29/06/21.
//

import Foundation

struct PagedResultViewModel<T> {
    var count: Int
    var totalCount: Int
    var page: Int?
    var pageSize: Int?
    var search: String?
    var result: [T]
    
    var totalPages: Int
}
