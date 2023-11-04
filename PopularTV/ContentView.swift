//
//  ContentView.swift
//  PopularTV
//
//  Created by Kovács Márk on 21/10/2023.
//

import SwiftUI

struct ContentView: View {
    @State var tvs = PopularTVResponse()
    
    var body: some View {
        NavigationStack {
            List(tvs.results ?? [], id: \.id) { tv in
                NavigationLink {
                    DetailsView(tv: tv)
                } label: {
                    VStack(alignment: .leading) {
                        Text(tv.originalName ?? "")
                    }
                }
            } //list
            .onAppear() {
                Task {
                    do {
                        let data = try await TheMovieDbClient().getPopularTVsAsync()
                        self.tvs = data
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            } //onappear
        } //NavigationStack
    }
}

#Preview {
    ContentView()
}
