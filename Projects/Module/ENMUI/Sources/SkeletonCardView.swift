//
//  SkeletonCardView.swift
//  ENMUI
//
//  Created by linsaeng on 8/16/25.
//

import SwiftUI

public struct SkeletonCardView: View {
    
    @State private var isAnimating = false
    
    private var cardWidth: CGFloat {
        UIScreen.main.bounds.width - 32 - 24
    }
    
    private var imageHeight: CGFloat {
        cardWidth * 9 / 16
    }
    
    public init() {}
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Rectangle()
                .fill(Color.gray.opacity(0.2))
                .frame(width: cardWidth, height: imageHeight)
                .overlay(
                    LinearGradient(
                        colors: [
                            Color.gray.opacity(0.2),
                            Color.gray.opacity(0.3),
                            Color.gray.opacity(0.2)
                        ],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                    .offset(x: isAnimating ? 400 : -400)
                    .animation(
                        .linear(duration: 1.5)
                        .repeatForever(autoreverses: false),
                        value: isAnimating
                    )
                )
                .clipShape(RoundedRectangle(cornerRadius: 12))
            
            VStack(alignment: .leading, spacing: 8) {
                Rectangle()
                    .fill(Color.gray.opacity(0.2))
                    .frame(width: 80, height: 14)
                    .cornerRadius(4)
                
                Rectangle()
                    .fill(Color.gray.opacity(0.2))
                    .frame(height: 18)
                    .cornerRadius(4)
                
                Rectangle()
                    .fill(Color.gray.opacity(0.2))
                    .frame(width: 120, height: 24)
                    .cornerRadius(4)
            }
            .padding(.horizontal, 4)
        }
        .padding(12)
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
        .onAppear {
            isAnimating = true
        }
    }
}

#if DEBUG
#Preview("Skeleton Card") {
    VStack(spacing: 16) {
        Text("스켈레톤 카드")
            .font(.headline)
            .fontWeight(.bold)
        
        SkeletonCardView()
    }
    .padding()
    .background(Color(.systemGroupedBackground))
}

#Preview("Skeleton Loading List") {
    ScrollView {
        VStack(spacing: 16) {
            Text("로딩 중인 상품 리스트")
                .font(.headline)
                .fontWeight(.bold)
                .padding()
            
            ForEach(0..<3) { _ in
                SkeletonCardView()
            }
        }
        .padding()
    }
    .background(Color(.systemGroupedBackground))
}

#Preview("Skeleton Grid") {
    ScrollView {
        VStack(spacing: 16) {
            Text("그리드 레이아웃 로딩")
                .font(.headline)
                .fontWeight(.bold)
                .padding()
            
            LazyVGrid(columns: [
                GridItem(.flexible()),
                GridItem(.flexible())
            ], spacing: 16) {
                ForEach(0..<6) { _ in
                    SkeletonCardView()
                }
            }
            .padding()
        }
    }
    .background(Color(.systemGroupedBackground))
}

#Preview("Mixed Content Loading") {
    ScrollView {
        VStack(spacing: 16) {
            Text("혼합 콘텐츠 로딩")
                .font(.headline)
                .fontWeight(.bold)
                .padding()
            
            // 헤더 스켈레톤
            VStack(alignment: .leading, spacing: 8) {
                Rectangle()
                    .fill(Color.gray.opacity(0.2))
                    .frame(height: 80)
                    .cornerRadius(12)
                
                HStack {
                    Circle()
                        .fill(Color.gray.opacity(0.2))
                        .frame(width: 40, height: 40)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Rectangle()
                            .fill(Color.gray.opacity(0.2))
                            .frame(width: 100, height: 16)
                            .cornerRadius(4)
                        
                        Rectangle()
                            .fill(Color.gray.opacity(0.2))
                            .frame(width: 80, height: 12)
                            .cornerRadius(4)
                    }
                    Spacer()
                }
            }
            .padding()
            .background(Color(.systemBackground))
            .cornerRadius(12)
            .shadow(radius: 2)
            
            // 상품 카드들
            ForEach(0..<2) { _ in
                SkeletonCardView()
            }
        }
        .padding()
    }
    .background(Color(.systemGroupedBackground))
}
#endif
