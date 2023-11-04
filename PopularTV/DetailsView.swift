//
//  DetailsView.swift
//  PopularTV
//
//  Created by Kovács Márk on 21/10/2023.
//

import SwiftUI

struct DetailsView: View {
    var tv: Result
    
    var body: some View {
        VStack {
            Text(tv.originalName ?? "")
                .font(.title)
            AsyncImage(url: TheMovieDbClient().getPosterUrl(posterPath: tv.posterPath ?? "")) { phase in
                phase.image?
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                }
        }
    }
}
