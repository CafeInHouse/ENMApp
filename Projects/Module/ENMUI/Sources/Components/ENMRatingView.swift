//
//  ENMRatingView.swift
//  ENMUI
//
//  Created by linsaeng on 8/16/25.
//

import SwiftUI

public struct ENMRatingView: View {
    
    public enum DisplayStyle {
        case compact
        case detailed
        case simple
    }
    
    let rating: Double
    let reviewCount: Int?
    let style: DisplayStyle
    let starColor: Color
    
    public init(
        rating: Double,
        reviewCount: Int? = nil,
        style: DisplayStyle = .detailed,
        starColor: Color = .yellow
    ) {
        self.rating = rating
        self.reviewCount = reviewCount
        self.style = style
        self.starColor = starColor
    }
    
    public var body: some View {
        _bodyView
    }
}

private extension ENMRatingView {
    
    @ViewBuilder
    var _bodyView: some View {
        switch style {
        case .compact:
            compactView
        case .detailed:
            detailedView
        case .simple:
            simpleView
        }
    }
    
    var compactView: some View {
        HStack(spacing: 2) {
            Image(systemName: "star.fill")
                .font(.caption2)
                .foregroundColor(starColor)
            
            Text(String(format: "%.1f", rating))
                .font(.caption2)
                .foregroundColor(.secondary)
        }
    }
    
    var detailedView: some View {
        HStack(spacing: 4) {
            Image(systemName: "star.fill")
                .font(.caption)
                .foregroundColor(starColor)
            
            Text(String(format: "%.1f", rating))
                .font(.caption)
                .foregroundColor(.secondary)
            
            if let reviewCount = reviewCount {
                Text("(\(reviewCount))")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
    }
    
    var simpleView: some View {
        HStack(spacing: 2) {
            ForEach(0..<5, id: \.self) { index in
                Image(systemName: starImage(for: index))
                    .font(.caption)
                    .foregroundColor(starColor)
            }
            
            if let reviewCount = reviewCount {
                Text("(\(reviewCount))")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .padding(.leading, 2)
            }
        }
    }
    
    func starImage(for index: Int) -> String {
        let filledStars = Int(rating)
        let hasHalfStar = rating - Double(filledStars) >= 0.5
        
        if index < filledStars {
            return "star.fill"
        } else if index == filledStars && hasHalfStar {
            return "star.leadinghalf.filled"
        } else {
            return "star"
        }
    }
}