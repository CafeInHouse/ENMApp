//
//  ENMCardView.swift
//  ENMUI
//
//  Created by linsaeng on 8/16/25.
//

import SwiftUI

public struct ENMCardView<Content: View>: View {
    
    public enum CardStyle {
        case elevated
        case outlined
        case filled
    }
    
    let content: Content
    let style: CardStyle
    let padding: CGFloat
    let cornerRadius: CGFloat
    
    public init(
        style: CardStyle = .elevated,
        padding: CGFloat = 12,
        cornerRadius: CGFloat = 16,
        @ViewBuilder content: () -> Content
    ) {
        self.style = style
        self.padding = padding
        self.cornerRadius = cornerRadius
        self.content = content()
    }
    
    public var body: some View {
        _bodyView
    }
}

private extension ENMCardView {
    
    @ViewBuilder
    var _bodyView: some View {
        content
            .padding(padding)
            .background(backgroundView)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            .overlay(overlayView)
            .shadow(
                color: shadowColor,
                radius: shadowRadius,
                x: 0,
                y: shadowY
            )
    }
    
    @ViewBuilder
    var backgroundView: some View {
        switch style {
        case .elevated, .outlined:
            Color(.systemBackground)
        case .filled:
            Color(.secondarySystemBackground)
        }
    }
    
    @ViewBuilder
    var overlayView: some View {
        switch style {
        case .outlined:
            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(Color.gray.opacity(0.2), lineWidth: 1)
        default:
            EmptyView()
        }
    }
    
    var shadowColor: Color {
        switch style {
        case .elevated:
            return .black.opacity(0.1)
        case .outlined, .filled:
            return .clear
        }
    }
    
    var shadowRadius: CGFloat {
        switch style {
        case .elevated:
            return 4
        case .outlined, .filled:
            return 0
        }
    }
    
    var shadowY: CGFloat {
        switch style {
        case .elevated:
            return 2
        case .outlined, .filled:
            return 0
        }
    }
}