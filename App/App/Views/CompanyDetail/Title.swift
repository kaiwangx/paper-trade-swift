//
//  Title.swift
//  App
//
//  Created by Kai Wang on 4/20/22.
//

import SwiftUI
import Kingfisher

struct Title: View {
    @EnvironmentObject var companyDetailVM: CompanyDetailVM
    var body: some View {
        HStack {
            Text(self.companyDetailVM.description!.name)
                .foregroundColor(.secondary)
            Spacer()
            KFImage(URL(string: self.companyDetailVM.description!.logo))
                .resizable()
                .frame(width: 50, height: 50)
        }
    }
}

struct Title_Previews: PreviewProvider {
    static var previews: some View {
        Title()
    }
}
