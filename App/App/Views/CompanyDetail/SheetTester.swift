//
//  SheetTester.swift
//  App
//
//  Created by Kai Wang on 4/21/22.
//

import SwiftUI

struct Sheet1: View {
    @Environment(\.dismiss) private var dismiss
    @State var text: String = "Text"
    
    var body: some View {
        
        Text(self.text)
        if self.text == "Modified Text" {
            Button {
                dismiss()
            } label: {
                Text("Close sheet")
            }
        } else {
            Button {
                self.text = "Modified Text"
            } label: {
                Text("Modify Text")
            }
        }
    }
}


struct SheetTester: View {
    @State private var isShowingSheet1 = false
    
    var body: some View {
        Button(action: {
            isShowingSheet1.toggle()
        }) {
            Text("Show Sheet1")
        }
        .sheet(isPresented: $isShowingSheet1) {
            TradeCompleteSheet(companyName: "TSLA", numOfShares: "2", type: "sold")
        }
    }
    
//    var body: some View {
//        Button(action: {
//            isShowingSheet1.toggle()
//        }) {
//            Text("Show Sheet1")
//        }
//        .sheet(isPresented: $isShowingSheet1) {
//            Text("Sheet1")
//            Button {
//                isShowingSheet1.toggle()
//                isShowingSheet2.toggle()
//            } label: {
//                Text("Show Sheet2")
//            }
//        }
//        .sheet(isPresented: $isShowingSheet2) {
//            Text("Sheet2")
//        }
//    }
}

struct SheetTester_Previews: PreviewProvider {
    static var previews: some View {
        SheetTester()
    }
}
