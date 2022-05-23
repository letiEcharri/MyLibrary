//
//  RatingView.swift
//  MyLibrary
//
//  Created by Leticia Echarri on 15/5/22.
//

import SwiftUI

struct RatingView: View {
    @Binding var rating: Double
    
    var body: some View {
        HStack {
            ForEach(1..<6) { position in
                Image(systemName: getImage(with: position))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 20, height: 20)
                    .foregroundStyle(getColor(with: position))
            }
        }
    }
    
    private func getImage(with position: Int) -> String {
        let floatPos = CGFloat(position)
        return floatPos == rating + 0.5 ? "star.leadinghalf.filled" : "star.fill"
    }
    
    private func getColor(with position: Int) -> Color {
        let floatPos = CGFloat(position)
        if floatPos == rating + 0.5 {
            return .yellow
        }
        return floatPos <= rating ? .yellow : .gray
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView(rating: .constant(2.5))
    }
}
