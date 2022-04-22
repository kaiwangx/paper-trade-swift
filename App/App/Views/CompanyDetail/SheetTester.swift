//
//  SheetTester.swift
//  App
//
//  Created by Kai Wang on 4/21/22.
//

import SwiftUI

struct SheetTester: View {
    @State private var isShowingSheet = false
    var body: some View {
        Button(action: {
            isShowingSheet.toggle()
        }) {
            Text("Show License Agreement")
        }
        .sheet(isPresented: $isShowingSheet) {
//            CompanyNewsSheet()
        }
    }
    

}

struct SheetTester_Previews: PreviewProvider {
    static var previews: some View {
        SheetTester()
    }
}
