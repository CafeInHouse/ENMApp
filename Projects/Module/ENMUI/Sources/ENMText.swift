//
//  ENMText.swift
//  ENMUI
//
//  Created by Claude on 8/16/25.
//

import SwiftUI
import UIKit

// MARK: - ENMText Component
public struct ENMText: View {
    private let text: String
    private var typography: Typography = .body
    private var colorStyle: ColorStyle = .primary
    private var alignment: TextAlignment = .leading
    private var lineLimit: Int? = nil
    private var allowsSelection: Bool = false
    
    public init(_ text: String) {
        self.text = text
    }
    
    public var body: some View {
        Group {
            if allowsSelection {
                Text(text)
                    .font(typography.font)
                    .foregroundColor(colorStyle.color)
                    .multilineTextAlignment(alignment)
                    .lineLimit(lineLimit)
                    .textSelection(.enabled)
                    .accessibilityLabel(text)
                    .accessibilityAddTraits(.isStaticText)
            } else {
                Text(text)
                    .font(typography.font)
                    .foregroundColor(colorStyle.color)
                    .multilineTextAlignment(alignment)
                    .lineLimit(lineLimit)
                    .accessibilityLabel(text)
                    .accessibilityAddTraits(.isStaticText)
            }
        }
    }
}

// MARK: - Typography Styles
public extension ENMText {
    enum Typography {
        case largeTitle
        case title1
        case title2
        case title3
        case headline
        case body
        case callout
        case subheadline
        case footnote
        case caption1
        case caption2
        case custom(size: CGFloat, weight: Font.Weight)
        
        var font: Font {
            switch self {
            case .largeTitle:
                return .largeTitle
            case .title1:
                return .title
            case .title2:
                return .title2
            case .title3:
                return .title3
            case .headline:
                return .headline
            case .body:
                return .body
            case .callout:
                return .callout
            case .subheadline:
                return .subheadline
            case .footnote:
                return .footnote
            case .caption1:
                return .caption
            case .caption2:
                return .caption2
            case .custom(let size, let weight):
                return .system(size: size, weight: weight)
            }
        }
    }
}

// MARK: - Color Styles
public extension ENMText {
    enum ColorStyle {
        case primary
        case secondary
        case accent
        case success
        case warning
        case error
        case custom(Color)
        
        var color: Color {
            switch self {
            case .primary:
                return .primary
            case .secondary:
                return .secondary
            case .accent:
                return .accentColor
            case .success:
                return .green
            case .warning:
                return .orange
            case .error:
                return .red
            case .custom(let color):
                return color
            }
        }
    }
}

// MARK: - Modifiers
public extension ENMText {
    func typography(_ style: Typography) -> ENMText {
        var copy = self
        copy.typography = style
        return copy
    }
    
    func color(_ style: ColorStyle) -> ENMText {
        var copy = self
        copy.colorStyle = style
        return copy
    }
    
    func alignment(_ alignment: TextAlignment) -> ENMText {
        var copy = self
        copy.alignment = alignment
        return copy
    }
    
    func lineLimit(_ limit: Int?) -> ENMText {
        var copy = self
        copy.lineLimit = limit
        return copy
    }
    
    func selectable(_ enabled: Bool = true) -> ENMText {
        var copy = self
        copy.allowsSelection = enabled
        return copy
    }
}

// MARK: - Convenience Initializers
public extension ENMText {
    static func title(_ text: String) -> ENMText {
        ENMText(text).typography(.title1)
    }
    
    static func headline(_ text: String) -> ENMText {
        ENMText(text).typography(.headline)
    }
    
    static func body(_ text: String) -> ENMText {
        ENMText(text).typography(.body)
    }
    
    static func caption(_ text: String) -> ENMText {
        ENMText(text).typography(.caption1).color(.secondary)
    }
    
    static func error(_ text: String) -> ENMText {
        ENMText(text).color(.error)
    }
    
    static func success(_ text: String) -> ENMText {
        ENMText(text).color(.success)
    }
}
