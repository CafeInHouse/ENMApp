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

#if DEBUG
#Preview("Chip Styles") {
    VStack(spacing: 16) {
        VStack(alignment: .leading, spacing: 8) {
            Text("Chip 스타일")
                .font(.headline)
                .fontWeight(.bold)
            
            HStack(spacing: 8) {
                ENMChipView("Primary", style: .primary)
                ENMChipView("Secondary", style: .secondary)
                ENMChipView("Success", style: .success)
            }
            
            HStack(spacing: 8) {
                ENMChipView("Warning", style: .warning)
                ENMChipView("Info", style: .info)
                ENMChipView("Custom", style: .custom(color: .pink))
            }
        }
    }
    .padding()
    .background(Color(.systemGroupedBackground))
}

#Preview("Chip Groups") {
    VStack(spacing: 16) {
        VStack(alignment: .leading, spacing: 8) {
            Text("카테고리 그룹")
                .font(.headline)
                .fontWeight(.bold)
            
            ENMChipGroup(
                items: ["전자제품", "스마트폰", "액세서리", "케이스", "충전기"],
                style: .primary
            )
        }
        
        VStack(alignment: .leading, spacing: 8) {
            Text("브랜드 그룹")
                .font(.headline)
                .fontWeight(.bold)
            
            ENMChipGroup(
                items: ["Apple", "Samsung", "LG", "Sony", "Microsoft"],
                style: .secondary
            )
        }
        
        VStack(alignment: .leading, spacing: 8) {
            Text("태그 그룹")
                .font(.headline)
                .fontWeight(.bold)
            
            ENMChipGroup(
                items: ["신상품", "베스트셀러", "할인중", "무료배송"],
                style: .success
            )
        }
    }
    .padding()
    .background(Color(.systemGroupedBackground))
}

#Preview("Product Filter Usage") {
    ScrollView {
        VStack(spacing: 16) {
            // 상품 필터 예시
            VStack(alignment: .leading, spacing: 12) {
                Text("상품 필터")
                    .font(.headline)
                    .fontWeight(.bold)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("카테고리")
                        .font(.subheadline)
                        .fontWeight(.medium)
                    
                    ENMChipGroup(
                        items: ["전체", "스마트폰", "태블릿", "노트북", "액세서리"],
                        style: .primary,
                        spacing: 8
                    )
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("가격대")
                        .font(.subheadline)
                        .fontWeight(.medium)
                    
                    ENMChipGroup(
                        items: ["10만원 이하", "10-50만원", "50-100만원", "100만원 이상"],
                        style: .secondary,
                        spacing: 8
                    )
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("특별 옵션")
                        .font(.subheadline)
                        .fontWeight(.medium)
                    
                    HStack(spacing: 8) {
                        ENMChipView("무료배송", style: .success)
                        ENMChipView("할인중", style: .warning)
                        ENMChipView("신상품", style: .info)
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .background(Color(.systemBackground))
            .cornerRadius(12)
            .shadow(radius: 2)
            
            // 검색 태그 예시
            VStack(alignment: .leading, spacing: 12) {
                Text("인기 검색어")
                    .font(.headline)
                    .fontWeight(.bold)
                
                ENMChipGroup(
                    items: ["아이폰", "맥북", "에어팟", "갤럭시", "워치", "케이스", "충전기", "블루투스"],
                    style: .custom(color: .teal),
                    spacing: 6
                )
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .background(Color(.systemBackground))
            .cornerRadius(12)
            .shadow(radius: 2)
        }
        .padding()
    }
    .background(Color(.systemGroupedBackground))
}

#Preview("Status Chips") {
    VStack(spacing: 16) {
        VStack(alignment: .leading, spacing: 8) {
            Text("주문 상태")
                .font(.headline)
                .fontWeight(.bold)
            
            VStack(spacing: 8) {
                HStack {
                    Text("주문 완료")
                        .font(.body)
                    Spacer()
                    ENMChipView("결제 완료", style: .success)
                }
                
                HStack {
                    Text("배송 준비중")
                        .font(.body)
                    Spacer()
                    ENMChipView("준비중", style: .warning)
                }
                
                HStack {
                    Text("배송중")
                        .font(.body)
                    Spacer()
                    ENMChipView("배송중", style: .info)
                }
                
                HStack {
                    Text("배송 완료")
                        .font(.body)
                    Spacer()
                    ENMChipView("완료", style: .success)
                }
                
                HStack {
                    Text("취소된 주문")
                        .font(.body)
                    Spacer()
                    ENMChipView("취소", style: .secondary)
                }
            }
        }
    }
    .padding()
    .background(Color(.systemGroupedBackground))
}
#endif
