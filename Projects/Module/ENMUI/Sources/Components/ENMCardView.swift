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

#if DEBUG
#Preview("Elevated Style") {
    ScrollView {
        VStack(spacing: 16) {
            ENMCardView(style: .elevated) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Elevated Card")
                        .font(.headline)
                        .fontWeight(.bold)
                    
                    Text("그림자가 있는 카드 스타일입니다. 일반적으로 가장 많이 사용되는 스타일입니다.")
                        .font(.body)
                        .foregroundColor(.secondary)
                        .lineLimit(nil)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            ENMCardView(style: .elevated, padding: 16) {
                HStack {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                    Text("별점 카드")
                        .font(.subheadline)
                    Spacer()
                }
            }
        }
        .padding()
    }
    .background(Color(.systemGroupedBackground))
}

#Preview("Outlined Style") {
    ScrollView {
        VStack(spacing: 16) {
            ENMCardView(style: .outlined) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Outlined Card")
                        .font(.headline)
                        .fontWeight(.bold)
                    
                    Text("테두리가 있는 카드 스타일입니다. 깔끔한 디자인을 원할 때 사용합니다.")
                        .font(.body)
                        .foregroundColor(.secondary)
                        .lineLimit(nil)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            ENMCardView(style: .outlined, cornerRadius: 8) {
                HStack {
                    Image(systemName: "heart.fill")
                        .foregroundColor(.red)
                    Text("좋아요 카드")
                        .font(.subheadline)
                    Spacer()
                }
            }
        }
        .padding()
    }
    .background(Color(.systemGroupedBackground))
}

#Preview("Filled Style") {
    ScrollView {
        VStack(spacing: 16) {
            ENMCardView(style: .filled) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Filled Card")
                        .font(.headline)
                        .fontWeight(.bold)
                    
                    Text("배경이 채워진 카드 스타일입니다. 강조하고 싶은 내용에 사용합니다.")
                        .font(.body)
                        .foregroundColor(.secondary)
                        .lineLimit(nil)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            ENMCardView(style: .filled, padding: 20) {
                HStack {
                    Image(systemName: "bell.fill")
                        .foregroundColor(.orange)
                    Text("알림 카드")
                        .font(.subheadline)
                    Spacer()
                }
            }
        }
        .padding()
    }
    .background(Color(.systemGroupedBackground))
}

#Preview("All Styles Comparison") {
    ScrollView {
        VStack(spacing: 16) {
            ForEach(["elevated", "outlined", "filled"], id: \.self) { styleName in
                let style: ENMCardView<AnyView>.CardStyle = {
                    switch styleName {
                    case "elevated": return .elevated
                    case "outlined": return .outlined
                    case "filled": return .filled
                    default: return .elevated
                    }
                }()
                
                ENMCardView(style: style) {
                    AnyView(
                        VStack(alignment: .leading, spacing: 8) {
                            Text("\(styleName.capitalized) Style")
                                .font(.headline)
                                .fontWeight(.bold)
                            
                            Text("이것은 \(styleName) 스타일의 카드입니다.")
                                .font(.body)
                                .foregroundColor(.secondary)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    )
                }
            }
        }
        .padding()
    }
    .background(Color(.systemGroupedBackground))
}
#endif