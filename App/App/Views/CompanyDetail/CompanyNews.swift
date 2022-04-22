//
//  CompanyNews.swift
//  App
//
//  Created by Kai Wang on 4/20/22.
//

import SwiftUI
import Kingfisher

struct CompanyNews: View {
    @EnvironmentObject var companyDetailVM: CompanyDetailVM
    @State private var isShowingSheet = false
    @StateObject var selectedNewsItemVM = SelectedNewsItemVM()
    
    var body: some View {
        VStack {
            HStack{
                Text("News")
                    .font(.title)
                    .padding(.bottom, 5)
                Spacer()
            }
        
            if self.companyDetailVM.newsList != nil && self.companyDetailVM.newsList!.count >= 1{
            
                VStack(alignment: .leading){
                    KFImage(URL(string: self.companyDetailVM.newsList![0].image))
                        .resizable()
                        .frame(height: 200)
                        .cornerRadius(15)

                    Text("**\(self.companyDetailVM.newsList![0].source)**  \(self.companyDetailVM.newsList![0].timeSincePublished)")
                        .font(.callout)
                        .foregroundColor(.secondary)
                        .padding(.vertical, 1)

                    Text("**\(self.companyDetailVM.newsList![0].headline)**")
                        .fixedSize(horizontal: false, vertical: true)
                }
                .onTapGesture {
                    toggleNewsSheet(self.companyDetailVM.newsList![0])
                }
           
                Divider()
                
                if self.companyDetailVM.newsList!.count >= 2 {
                    ForEach(self.companyDetailVM.newsList![1..<min(20, self.companyDetailVM.newsList!.count)]) {newItem in
                        VStack(alignment: .leading) {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text("**\(newItem.source)**  \(newItem.timeSincePublished)")
                                        .font(.callout)
                                        .foregroundColor(.secondary)
                                        .padding(.vertical, 0.5)

                                    Text("**\(newItem.headline)**")
                                        .lineLimit(3)
                                }
                                Spacer()
                                VStack(alignment: .leading){
                                    KFImage(URL(string: newItem.image))
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width:80, height: 80)
                                        .cornerRadius(15)
                                }
                            }
                            .frame(height: 100)
                        }
                        .onTapGesture {
                            toggleNewsSheet(newItem)
                        }
                    }
                }
            }
        }
        .sheet(isPresented: $isShowingSheet) {
            CompanyNewsSheet()
                .environmentObject(selectedNewsItemVM)
        }
    }
    
    func toggleNewsSheet(_ newsItem: NewsItem) {
        self.selectedNewsItemVM.selectNews(anotherNewsItem: newsItem)
        self.isShowingSheet = true
        
    }
}
