//
//  SelectedNewsItemVM.swift
//  App
//
//  Created by Kai Wang on 4/21/22.
//

import Foundation

class SelectedNewsItemVM: ObservableObject {
    @Published var selectedNewsItem: NewsItem?
    
    func selectNews(anotherNewsItem: NewsItem) {
        self.selectedNewsItem = anotherNewsItem
    }
}
