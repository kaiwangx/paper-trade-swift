//
//  Today.swift
//  App
//
//  Created by Kai Wang on 5/1/22.
//

import SwiftUI

struct Today: View {
    var body: some View {
        Section {
            Text(Date(), style: .date)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color.gray)
        }
    }
}

struct Today_Previews: PreviewProvider {
    static var previews: some View {
        Today()
    }
}
