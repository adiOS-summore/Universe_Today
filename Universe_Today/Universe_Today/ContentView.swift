//
//  ContentView.swift
//  Universe_Today
//
//  Created by 원태영 on 2023/06/24.
//

import SwiftUI
import WidgetKit

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .onTapGesture {
            WidgetCenter.shared.reloadAllTimelines()
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
