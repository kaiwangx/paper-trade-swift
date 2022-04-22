//
//  Spinner.swift
//  App
//
//  Created by Kai Wang on 4/20/22.
//

import SwiftUI

struct Spinner: View {
    var body: some View {
        ProgressView("Fetching Data...")
    }
}

struct Spinner_Previews: PreviewProvider {
    static var previews: some View {
        Spinner()
    }
}
