//
//  ContentView.swift
//  TK2TextView
//
//  Created by Leo Tumwattana on 23/4/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        SortedTextView()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .preferredColorScheme(.light)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
