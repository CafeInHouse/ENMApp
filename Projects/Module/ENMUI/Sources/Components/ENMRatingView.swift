//
//  ENMRatingView.swift
//  ENMUI
//
//  Created by linsaeng on 8/16/25.
//

import SwiftUI

/// 별점과 리뷰 수를 표시하는 평점 컴포넌트입니다.
///
/// ENMRatingView는 0.0~5.0 범위의 평점을 별 모양으로 표시하며,
/// compact, detailed, simple 세 가지 스타일을 제공합니다.
/// 리뷰 수와 별 색상도 커스터마이징 가능합니다.
///
/// - Example:
/// ```swift
/// // 기본 detailed 스타일
/// ENMRatingView(rating: 4.5, reviewCount: 1234)
///
/// // 간결한 compact 스타일
/// ENMRatingView(rating: 3.8, style: .compact)
///
/// // 커스텀 색상
/// ENMRatingView(rating: 4.2, starColor: .orange)
/// ```
public struct ENMRatingView: View {
    
    /// 평점 표시 스타일을 정의하는 열거형
    ///
    /// - compact: 별점만 간결하게 표시
    /// - detailed: 별점, 평점 숫자, 리뷰 수를 모두 표시
    /// - simple: 별점과 평점 숫자만 표시
    public enum DisplayStyle {
        case compact
        case detailed
        case simple
    }
    
    let rating: Double
    let reviewCount: Int?
    let style: DisplayStyle
    let starColor: Color
    
    /// ENMRatingView를 초기화합니다.
    ///
    /// - Parameters:
    ///   - rating: 평점 (0.0~5.0 범위)
    ///   - reviewCount: 리뷰 수 (선택사항)
    ///   - style: 표시 스타일 (기본값: .detailed)
    ///   - starColor: 별의 색상 (기본값: .yellow)
    ///
    /// - Note: rating 값은 자동으로 0.0~5.0 범위로 제한됩니다.
    ///
    /// - Example:
    /// ```swift
    /// // 상세 정보 포함
    /// ENMRatingView(
    ///     rating: 4.7,
    ///     reviewCount: 2834,
    ///     style: .detailed
    /// )
    /// ```
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

#if DEBUG
#Preview("Rating Styles") {
    VStack(spacing: 16) {
        // Compact 스타일
        VStack(alignment: .leading, spacing: 8) {
            Text("Compact Style")
                .font(.headline)
                .fontWeight(.bold)
            
            ENMRatingView(rating: 4.5, style: .compact)
            ENMRatingView(rating: 3.2, style: .compact)
            ENMRatingView(rating: 5.0, style: .compact)
        }
        
        Divider()
        
        // Detailed 스타일
        VStack(alignment: .leading, spacing: 8) {
            Text("Detailed Style")
                .font(.headline)
                .fontWeight(.bold)
            
            ENMRatingView(rating: 4.5, reviewCount: 1234, style: .detailed)
            ENMRatingView(rating: 3.2, reviewCount: 567, style: .detailed)
            ENMRatingView(rating: 5.0, reviewCount: 89, style: .detailed)
        }
        
        Divider()
        
        // Simple 스타일
        VStack(alignment: .leading, spacing: 8) {
            Text("Simple Style")
                .font(.headline)
                .fontWeight(.bold)
            
            ENMRatingView(rating: 4.5, reviewCount: 1234, style: .simple)
            ENMRatingView(rating: 3.2, reviewCount: 567, style: .simple)
            ENMRatingView(rating: 5.0, style: .simple)
        }
    }
    .padding()
    .background(Color(.systemGroupedBackground))
}

#Preview("Rating Values") {
    VStack(spacing: 16) {
        // 다양한 평점 값들
        VStack(alignment: .leading, spacing: 8) {
            Text("다양한 평점")
                .font(.headline)
                .fontWeight(.bold)
            
            ENMRatingView(rating: 5.0, reviewCount: 2500, style: .detailed)
            ENMRatingView(rating: 4.8, reviewCount: 1200, style: .detailed)
            ENMRatingView(rating: 4.5, reviewCount: 890, style: .detailed)
            ENMRatingView(rating: 4.2, reviewCount: 456, style: .detailed)
            ENMRatingView(rating: 3.8, reviewCount: 234, style: .detailed)
            ENMRatingView(rating: 3.5, reviewCount: 123, style: .detailed)
            ENMRatingView(rating: 2.7, reviewCount: 67, style: .detailed)
            ENMRatingView(rating: 1.5, reviewCount: 12, style: .detailed)
        }
    }
    .padding()
    .background(Color(.systemGroupedBackground))
}

#Preview("Star Colors") {
    VStack(spacing: 16) {
        // 다양한 별 색상
        VStack(alignment: .leading, spacing: 8) {
            Text("별 색상 변경")
                .font(.headline)
                .fontWeight(.bold)
            
            ENMRatingView(rating: 4.5, reviewCount: 123, style: .simple, starColor: .yellow)
            ENMRatingView(rating: 4.5, reviewCount: 123, style: .simple, starColor: .orange)
            ENMRatingView(rating: 4.5, reviewCount: 123, style: .simple, starColor: .red)
            ENMRatingView(rating: 4.5, reviewCount: 123, style: .simple, starColor: .blue)
            ENMRatingView(rating: 4.5, reviewCount: 123, style: .simple, starColor: .green)
        }
    }
    .padding()
    .background(Color(.systemGroupedBackground))
}

#Preview("Product Card Usage") {
    ScrollView {
        VStack(spacing: 16) {
            // 상품 카드에서의 사용 예시
            VStack(alignment: .leading, spacing: 12) {
                Text("프리미엄 헤드폰")
                    .font(.headline)
                    .fontWeight(.bold)
                
                HStack {
                    ENMRatingView(rating: 4.7, reviewCount: 2834, style: .detailed)
                    Spacer()
                    Text("₩299,000")
                        .font(.title3)
                        .fontWeight(.bold)
                }
                
                Text("고품질 노이즈 캔슬링 헤드폰으로 뛰어난 음질을 제공합니다.")
                    .font(.body)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .background(Color(.systemBackground))
            .cornerRadius(12)
            .shadow(radius: 2)
            
            // 리뷰 리스트에서의 사용 예시
            VStack(spacing: 12) {
                ForEach(Array(zip([4.8, 4.2, 3.9, 4.5], ["훌륭한 제품입니다!", "가성비 좋아요", "배송이 빨라요", "품질이 만족스러워요"])), id: \.0) { rating, comment in
                    HStack(alignment: .top) {
                        VStack(alignment: .leading, spacing: 4) {
                            ENMRatingView(rating: rating, style: .compact)
                            Text(comment)
                                .font(.body)
                                .foregroundColor(.primary)
                        }
                        Spacer()
                        Text("김**")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    .padding()
                    .background(Color(.systemBackground))
                    .cornerRadius(8)
                    .shadow(radius: 1)
                }
            }
        }
        .padding()
    }
    .background(Color(.systemGroupedBackground))
}
#endif