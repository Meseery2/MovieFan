//
//  PaginationViewModel.swift
//  MovieFan
//
//  Created by Mohammed ELMeseery on 6/20/20.
//  Copyright © 2020 Mohammed ELMeseery. All rights reserved.
//

import Foundation

class PaginationViewModel<T> {
    
    private(set) var pageSize: Int = 10
    private(set) var page: Int = 1
    private(set) var isLoading: Bool = false
    private var hasMore: Bool = true
    private(set) var data: [T] = []
    private(set) var total: Int = 0
    
    private var maxData: Int = -1
    
    init(pageSize: Int) {
        self.pageSize = pageSize
    }
    
    func reset() {
        isLoading = false
        hasMore = true
        page = 1
        total = 0
        data.removeAll()
    }
    
    func canLoadNow(index: Int) -> Bool {
        return (index == total - 2) && !isLoading && hasMore
    }
    
    func start() {
        isLoading = true
    }
    
    func stop() {
        isLoading = false
    }
    
    func success(objects: [T]) {
        data.append(contentsOf: objects)
        total = data.count
        page = page + 1
        hasMore = objects.count == pageSize
        isLoading = false
    }
    
    func failed() {
        isLoading = false
    }
}
