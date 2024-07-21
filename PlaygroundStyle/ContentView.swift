//
//  ContentView.swift
//  PlaygroundStyle
//
//  Created by alfian on 21/07/24.
//

import SwiftUI

struct ContentView: View {
  @StateObject private var viewModel = PalleteViewModel(baseColor: .systemBlue)
  
  var body: some View {
    NavigationStack {
      ScrollView {
        VStack(spacing: 0) {
          ForEach(viewModel.colors) { color in
            NavigationLink {
              LuminanceView(viewModel: LuminanceViewModel(baseColor: color))
            } label: {
              ZStack {
                Rectangle()
                  .fill(Color(color))
                  .frame(height: 50)
                
                Text(color.toHexString() ??  "")
                  .foregroundColor(Color(viewModel.getForground(with: color)))
              }
            }
          }
        }
        .padding()
      }
      .navigationTitle(viewModel.colors.first?.toHexString() ?? "")
      .navigationBarTitleDisplayMode(.inline)
    }
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
