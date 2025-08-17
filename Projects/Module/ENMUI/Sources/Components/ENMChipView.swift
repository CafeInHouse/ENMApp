//
//  ENMChipView.swift
//  ENMUI
//
//  Created by linsaeng on 8/16/25.
//

import SwiftUI

/// 소형 라벨이나 태그를 표시하는 칩 컴포넌트입니다.
///
/// ENMChipView는 카테고리, 태그, 필터 등에 사용할 수 있는 작은 라벨 컴포넌트입니다.
/// primary, secondary, success, warning, info, custom 6가지 스타일을 제공합니다.
///
/// - Example:
/// ```swift
/// // 기본 칩
/// ENMChipView("태그", style: .primary)
///
/// // 커스텀 색상 칩
/// ENMChipView("특별", style: .custom(color: .pink))
///
/// // 칩 그룹
/// ENMChipGroup(items: ["Apple", "Samsung", "LG"], style: .secondary)
/// ```
public struct ENMChipView: View {
    
    /// 칩의 시각적 스타일을 정의하는 열거형
    ///
    /// - primary: 주요 액션이나 중요한 정보 (파란색)
    /// - secondary: 일반적인 정보나 보조 액션 (회색)
    /// - success: 성공이나 긍정적인 상태 (녹색)
    /// - warning: 주의나 경고 상태 (주황색)
    /// - info: 정보 제공 (보라색)
    /// - custom(color): 사용자 정의 색상
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
    
    /// ENMChipView를 초기화합니다.
    ///
    /// - Parameters:
    ///   - text: 칩에 표시될 텍스트
    ///   - style: 칩의 시각적 스타일 (기본값: .primary)
    ///
    /// - Example:
    /// ```swift
    /// // 기본 primary 스타일
    /// ENMChipView("새상품")
    ///
    /// // warning 스타일
    /// ENMChipView("재고부족", style: .warning)
    /// ```
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

/// 여러 개의 칩을 그룹으로 표시하는 컨테이너 컴포넌트입니다.
///
/// ENMChipGroup은 텍스트 배열을 받아 여러 개의 칩을 자동으로 배치합니다.
/// FlowLayout을 사용하여 화면 너비에 맞게 줄바꿈이 자동으로 처리됩니다.
///
/// - Example:
/// ```swift
/// // 카테고리 칩 그룹
/// ENMChipGroup(
///     items: ["전자제품", "스마트폰", "액세서리"],
///     style: .primary
/// )
///
/// // 태그 칩 그룹 (간격 조정)
/// ENMChipGroup(
///     items: ["무료배송", "할인중", "신상품"],
///     style: .success,
///     spacing: 8
/// )
/// ```
public struct ENMChipGroup: View {
    let items: [String]
    let style: ENMChipView.ChipStyle
    let spacing: CGFloat
    
    /// ENMChipGroup을 초기화합니다.
    ///
    /// - Parameters:
    ///   - items: 표시할 텍스트 배열
    ///   - style: 모든 칩에 적용될 스타일 (기본값: .primary)
    ///   - spacing: 칩 사이의 간격 (기본값: 6)
    ///
    /// - Note: 칩들은 FlowLayout으로 배치되어 화면 너비에 따라 자동 줄바꿈됩니다.
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
