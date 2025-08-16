//
//  ENMChipView.swift
//  ENMUI
//
//  Created by linsaeng on 8/16/25.
//

import SwiftUI

public struct ENMChipView: View {
    
    public enum ChipStyle {
        case primary
        case secondary
        case success
        case warning
        case info
        case custom(color: Color)
        
        var backgroundColor: Color {
            switch self {
            case .primary:
                return Color.blue.opacity(0.1)
            case .secondary:
                return Color.gray.opacity(0.1)
            case .success:
                return Color.green.opacity(0.1)
            case .warning:
                return Color.orange.opacity(0.1)
            case .info:
                return Color.purple.opacity(0.1)
            case .custom(let color):
                return color.opacity(0.1)
            }
        }
        
        var foregroundColor: Color {
            switch self {
            case .primary:
                return .blue
            case .secondary:
                return .gray
            case .success:
                return .green
            case .warning:
                return .orange
            case .info:
                return .purple
            case .custom(let color):
                return color
            }
        }
    }
    
    let text: String
    let style: ChipStyle
    
    public init(
        _ text: String,
        style: ChipStyle = .primary
    ) {
        self.text = text
        self.style = style
    }
    
    public var body: some View {
        Text(text)
            .font(.caption2)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(style.backgroundColor)
            .foregroundColor(style.foregroundColor)
            .clipShape(Capsule())
    }
}

public struct ENMChipGroup: View {
    let items: [String]
    let style: ENMChipView.ChipStyle
    let spacing: CGFloat
    
    public init(
        items: [String],
        style: ENMChipView.ChipStyle = .primary,
        spacing: CGFloat = 6
    ) {
        self.items = items
        self.style = style
        self.spacing = spacing
    }
    
    public var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: spacing) {
                ForEach(items, id: \.self) { item in
                    ENMChipView(item, style: style)
                }
            }
            .padding(.horizontal, 1)
        }
    }
}
