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

#if DEBUG
#Preview("Normal Prices") {
    VStack(spacing: 16) {
        // 일반 가격
        ENMPriceView(price: 29900)
        
        // 높은 가격
        ENMPriceView(price: 599000)
        
        // 낮은 가격
        ENMPriceView(price: 1500)
        
        // 컴팩트 스타일
        ENMPriceView(price: 49900, style: .compact)
    }
    .padding()
    .background(Color(.systemGroupedBackground))
}

#Preview("Discount Prices") {
    VStack(spacing: 16) {
        // 일반 할인
        ENMPriceView(
            price: 79900,
            discountPrice: 59900,
            discountRate: 25,
            style: .normal
        )
        
        // 큰 할인
        ENMPriceView(
            price: 199000,
            discountPrice: 99000,
            discountRate: 50,
            style: .discount
        )
        
        // 컴팩트 할인
        ENMPriceView(
            price: 39900,
            discountPrice: 29900,
            discountRate: 25,
            style: .compact
        )
        
        // 작은 할인
        ENMPriceView(
            price: 15000,
            discountPrice: 14000,
            discountRate: 7,
            style: .normal
        )
    }
    .padding()
    .background(Color(.systemGroupedBackground))
}

#Preview("Price Card Examples") {
    ScrollView {
        VStack(spacing: 16) {
            // 상품 카드 예시
            VStack(alignment: .leading, spacing: 8) {
                Text("프리미엄 상품")
                    .font(.headline)
                
                ENMPriceView(
                    price: 299000,
                    discountPrice: 199000,
                    discountRate: 33
                )
                
                Text("★★★★★ (1,234)")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .background(Color(.systemBackground))
            .cornerRadius(12)
            .shadow(radius: 2)
            
            // 리스트 아이템 예시
            HStack {
                VStack(alignment: .leading) {
                    Text("일반 상품")
                        .font(.subheadline)
                    ENMPriceView(
                        price: 49900,
                        discountPrice: 39900,
                        discountRate: 20,
                        style: .compact
                    )
                }
                Spacer()
                Button("구매") { }
                    .buttonStyle(.borderedProminent)
                    .controlSize(.small)
            }
            .padding()
            .background(Color(.systemBackground))
            .cornerRadius(8)
            .shadow(radius: 1)
        }
        .padding()
    }
    .background(Color(.systemGroupedBackground))
}

#Preview("Different Currencies") {
    VStack(spacing: 16) {
        ENMPriceView(
            price: 299,
            discountPrice: 199,
            discountRate: 33,
            currencySymbol: "$"
        )
        
        ENMPriceView(
            price: 25000,
            discountPrice: 20000,
            discountRate: 20,
            currencySymbol: "¥"
        )
        
        ENMPriceView(
            price: 250,
            discountPrice: 199,
            discountRate: 20,
            currencySymbol: "€"
        )
    }
    .padding()
    .background(Color(.systemGroupedBackground))
}
#endif