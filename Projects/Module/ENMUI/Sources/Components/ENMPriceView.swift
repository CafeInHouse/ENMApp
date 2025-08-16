//
//  ENMPriceView.swift
//  ENMUI
//
//  Created by linsaeng on 8/16/25.
//

import SwiftUI

public struct ENMPriceView: View {
    
    public enum PriceStyle {
        case normal
        case discount
        case compact
    }
    
    let price: Int
    let discountPrice: Int?
    let discountRate: Int?
    let style: PriceStyle
    let currencySymbol: String
    
    public init(
        price: Int,
        discountPrice: Int? = nil,
        discountRate: Int? = nil,
        style: PriceStyle = .normal,
        currencySymbol: String = "₩"
    ) {
        self.price = price
        self.discountPrice = discountPrice
        self.discountRate = discountRate
        self.style = style
        self.currencySymbol = currencySymbol
    }
    
    public var body: some View {
        _bodyView
    }
}

private extension ENMPriceView {
    
    @ViewBuilder
    var _bodyView: some View {
        if let discountRate = discountRate,
           let discountPrice = discountPrice,
           discountRate > 0 {
            discountPriceView
        } else {
            normalPriceView
        }
    }
    
    var normalPriceView: some View {
        Text("\(currencySymbol)\(price.formatted())")
            .font(style == .compact ? .caption : .title3)
            .fontWeight(.bold)
            .foregroundColor(.primary)
    }
    
    var discountPriceView: some View {
        HStack(spacing: style == .compact ? 4 : 8) {
            if let discountRate = discountRate {
                Text("\(discountRate)%")
                    .font(style == .compact ? .caption : .title3)
                    .fontWeight(.bold)
                    .foregroundColor(.red)
            }
            
            if let discountPrice = discountPrice {
                Text("\(currencySymbol)\(discountPrice.formatted())")
                    .font(style == .compact ? .caption : .title3)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
            }
            
            Text("\(currencySymbol)\(price.formatted())")
                .font(style == .compact ? .caption2 : .caption)
                .foregroundColor(.secondary)
                .strikethrough()
        }
    }
}