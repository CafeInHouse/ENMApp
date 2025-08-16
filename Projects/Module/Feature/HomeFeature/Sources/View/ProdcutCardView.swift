//
//  ProdcutCardView.swift
//  HomeFeature
//
//  Created by linsaeng on 8/16/25.
//

import SwiftUI

import HomeDomain
import ENMUI

struct ProductCardView: View {
    let product: Product
    let onTapped: (Product) -> Void
    
    init(product: Product, onTapped: @escaping @Sendable (Product) -> Void) {
        self.product = product
        self.onTapped = onTapped
    }
    
    var body: some View {
        _bodyView
            .onTapGesture {
                onTapped(product)
            }
    }
}

private extension ProductCardView {
    
    var cardWidth: CGFloat {
        UIScreen.main.bounds.width - 32 - 24
    }
    
    var imageHeight: CGFloat {
        cardWidth
    }
    
    @ViewBuilder
    var _bodyView: some View {
        ENMCardView(style: .elevated) {
            VStack(alignment: .leading, spacing: 12) {
                productImageView
                productInfoView
            }
        }
    }
    
    var productImageView: some View {
        ENMAsyncImageView(
            url: URL(string: product.image),
            width: cardWidth,
            height: imageHeight,
            shape: .rounded(cornerRadius: 12),
            contentMode: .fill
        )
    }
    
    var productInfoView: some View {
        VStack(alignment: .leading, spacing: 8) {
            brandView
            nameView
            priceView
            ratingView
            
            if !product.tags.isEmpty {
                tagsView
            }
            
            if !product.benefits.isEmpty {
                benefitsView
            }
        }
        .padding(.horizontal, 4)
    }
}

private extension ProductCardView {
    
    var brandView: some View {
        Text(product.brand)
            .font(.caption)
            .foregroundColor(.secondary)
            .fontWeight(.medium)
    }
    
    var nameView: some View {
        Text(product.name)
            .font(.body)
            .fontWeight(.medium)
            .lineLimit(2)
            .multilineTextAlignment(.leading)
    }
    
    var priceView: some View {
        HStack {
            ENMPriceView(
                price: product.price,
                discountPrice: product.discountPrice,
                discountRate: product.discountRate,
                style: .normal
            )
            
            Spacer()
        }
    }
    
    var ratingView: some View {
        HStack {
            ENMRatingView(
                rating: product.rating,
                reviewCount: product.reviewCount,
                style: .detailed
            )
            
            Spacer()
        }
    }
    
    var tagsView: some View {
        ENMChipGroup(
            items: product.tags,
            style: .primary
        )
    }
    
    var benefitsView: some View {
        ENMChipGroup(
            items: product.benefits,
            style: .success
        )
    }
}
