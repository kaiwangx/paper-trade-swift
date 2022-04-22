//
//  Price.swift
//  App
//
//  Created by Kai Wang on 4/20/22.
//

import SwiftUI

struct Price: View {
    @EnvironmentObject var companyDetailVM: CompanyDetailVM
    
    var body: some View {
        HStack {
            Text("$\(self.companyDetailVM.price!.current, specifier: "%.2f")")
                .font(.largeTitle)
                .fontWeight(.semibold)
            Group {
                self.companyDetailVM.price!.trend.img
                Text("$\(self.companyDetailVM.price!.change, specifier: "%.2f") (\(self.companyDetailVM.price!.percentageChange, specifier: "%.2f")%)")
            }
                .font(.title2)
                .foregroundColor(self.companyDetailVM.price!.trend.color)
            Spacer()
        }
    }
}

struct Price_Previews: PreviewProvider {
    static var previews: some View {
        Price()
    }
}
