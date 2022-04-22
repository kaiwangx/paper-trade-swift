//
//  CompanyNewsSheet.swift
//  App
//
//  Created by Kai Wang on 4/21/22.
//

import SwiftUI

struct CompanyNewsSheet: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var selectedNewsItemVM: SelectedNewsItemVM

    var body: some View {
        if selectedNewsItemVM.selectedNewsItem != nil {
            VStack(alignment: .leading) {
                HStack {
                    Spacer()

                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundColor(.black)
                    }
                    
                }
                .padding(.vertical)
                
                Text(selectedNewsItemVM.selectedNewsItem!.source)
                    .font(.title)
                    .fontWeight(.semibold)
                
                Text(selectedNewsItemVM.selectedNewsItem!.publishDate, style: .date)
                    .foregroundColor(.secondary)
                
                Divider()
                
                Text(selectedNewsItemVM.selectedNewsItem!.headline)
                    .font(.title3)
                    .fontWeight(.semibold)
                
                Text(selectedNewsItemVM.selectedNewsItem!.summary)
                    .font(.body)
                
                HStack {
                    Text("For more details click")
                        .foregroundColor(.secondary)
                    Link("here", destination: URL(string: selectedNewsItemVM.selectedNewsItem!.url)!)
                }
                .font(.callout)
                
                HStack {
                    
                    Link(destination: selectedNewsItemVM.selectedNewsItem!.twitterShareLink){
                        Image("twitter-circle-fill")
                            .resizable()
                            .foregroundColor(Color(red: 8/255, green: 160/255, blue: 233/255))
                            .frame(width: 50, height: 50)
                    }
                    Link(destination: selectedNewsItemVM.selectedNewsItem!.facebookShareLink){
                        Image("facebook-circle-fill")
                            .resizable()
                            .foregroundColor(Color(red: 24/255, green: 119/255, blue: 242/255))
                            .frame(width: 50, height: 50)
                    }
                    
                }
                
                Spacer()
            }
            .padding(.horizontal)
        }
    }
}

//struct CompanyNewsSheet_Previews: PreviewProvider {
//    static var previews: some View {
//        CompanyNewsSheet(newsItem: NewsItem(category: "company", datetime: 1631221522, headline: "Arrival Might Be Worth A Speculative Look Here", id: 70429020, image: "https://static.seekingalpha.com/cdn/s3/uploads/getty_images/1249145859/medium_image_1249145859.jpg", related: "MSFT", source: "SeekingAlpha", summary: "Arrival moves closer to production, with more demos and test trials occurring as microfactories in Rock Hill and Bicester move closer towards completion.", url: "https://finnhub.io/api/news?id=ac5479a596494cf4d13a62b1459f5dc391485c5872a3f3b9e85420a13cc4d4c4"))
//    }
//}

