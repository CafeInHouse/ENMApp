//
//  ENMAsyncImageView.swift
//  ENMUI
//
//  Created by linsaeng on 8/16/25.
//

import SwiftUI

public struct ENMAsyncImageView: View {
    
    public enum ImageShape {
        case rectangle
        case rounded(cornerRadius: CGFloat)
        case circle
    }
    
    let url: URL?
    let width: CGFloat?
    let height: CGFloat?
    let shape: ImageShape
    let contentMode: ContentMode
    
    public init(
        url: URL?,
        width: CGFloat? = nil,
        height: CGFloat? = nil,
        shape: ImageShape = .rectangle,
        contentMode: ContentMode = .fill
    ) {
        self.url = url
        self.width = width
        self.height = height
        self.shape = shape
        self.contentMode = contentMode
    }
    
    public var body: some View {
        _bodyView
    }
}

private extension ENMAsyncImageView {
    
    @ViewBuilder
    var _bodyView: some View {
        AsyncImage(url: url) { phase in
            switch phase {
            case .success(let image):
                successView(image: image)
            case .failure(_):
                failureView
            case .empty:
                loadingView
            @unknown default:
                EmptyView()
            }
        }
        .frame(width: width, height: height)
        .modifier(ClipShapeModifier(shape: shape))
    }
    
    func successView(image: Image) -> some View {
        image
            .resizable()
            .aspectRatio(contentMode: contentMode)
            .transition(.opacity)
    }
    
    var failureView: some View {
        Rectangle()
            .fill(Color.gray.opacity(0.2))
            .overlay(
                Image(systemName: "photo.fill")
                    .font(.largeTitle)
                    .foregroundColor(.gray.opacity(0.5))
            )
    }
    
    var loadingView: some View {
        Rectangle()
            .fill(Color.gray.opacity(0.2))
            .overlay(
                ProgressView()
                    .tint(.gray)
            )
    }
}

private struct ClipShapeModifier: ViewModifier {
    let shape: ENMAsyncImageView.ImageShape
    
    @ViewBuilder
    func body(content: Content) -> some View {
        switch shape {
        case .rectangle:
            content.clipShape(Rectangle())
        case .rounded(let cornerRadius):
            content.clipShape(RoundedRectangle(cornerRadius: cornerRadius))
        case .circle:
            content.clipShape(Circle())
        }
    }
}

#if DEBUG
#Preview("Image Shapes") {
    VStack(spacing: 16) {
        VStack(alignment: .leading, spacing: 8) {
            Text("이미지 모양")
                .font(.headline)
                .fontWeight(.bold)
            
            HStack(spacing: 16) {
                // Rectangle
                VStack(spacing: 4) {
                    ENMAsyncImageView(
                        url: URL(string: "https://picsum.photos/200/200"),
                        width: 80,
                        height: 80,
                        shape: .rectangle
                    )
                    Text("Rectangle")
                        .font(.caption)
                }
                
                // Rounded
                VStack(spacing: 4) {
                    ENMAsyncImageView(
                        url: URL(string: "https://picsum.photos/201/201"),
                        width: 80,
                        height: 80,
                        shape: .rounded(cornerRadius: 12)
                    )
                    Text("Rounded")
                        .font(.caption)
                }
                
                // Circle
                VStack(spacing: 4) {
                    ENMAsyncImageView(
                        url: URL(string: "https://picsum.photos/202/202"),
                        width: 80,
                        height: 80,
                        shape: .circle
                    )
                    Text("Circle")
                        .font(.caption)
                }
            }
        }
    }
    .padding()
    .background(Color(.systemGroupedBackground))
}

#Preview("Image States") {
    VStack(spacing: 16) {
        VStack(alignment: .leading, spacing: 8) {
            Text("이미지 상태")
                .font(.headline)
                .fontWeight(.bold)
            
            HStack(spacing: 16) {
                // 로딩 상태 (빈 URL)
                VStack(spacing: 4) {
                    ENMAsyncImageView(
                        url: nil,
                        width: 80,
                        height: 80,
                        shape: .rounded(cornerRadius: 8)
                    )
                    Text("Loading")
                        .font(.caption)
                }
                
                // 에러 상태 (잘못된 URL)
                VStack(spacing: 4) {
                    ENMAsyncImageView(
                        url: URL(string: "https://invalid-url.com/image.jpg"),
                        width: 80,
                        height: 80,
                        shape: .rounded(cornerRadius: 8)
                    )
                    Text("Error")
                        .font(.caption)
                }
                
                // 성공 상태
                VStack(spacing: 4) {
                    ENMAsyncImageView(
                        url: URL(string: "https://picsum.photos/203/203"),
                        width: 80,
                        height: 80,
                        shape: .rounded(cornerRadius: 8)
                    )
                    Text("Success")
                        .font(.caption)
                }
            }
        }
    }
    .padding()
    .background(Color(.systemGroupedBackground))
}

#Preview("Product Images") {
    ScrollView {
        VStack(spacing: 16) {
            // 상품 카드에서의 사용
            VStack(alignment: .leading, spacing: 12) {
                Text("상품 이미지")
                    .font(.headline)
                    .fontWeight(.bold)
                
                VStack(spacing: 16) {
                    // 대형 상품 이미지
                    VStack(alignment: .leading, spacing: 8) {
                        ENMAsyncImageView(
                            url: URL(string: "https://picsum.photos/300/200"),
                            width: nil,
                            height: 160,
                            shape: .rounded(cornerRadius: 12),
                            contentMode: .fill
                        )
                        
                        Text("프리미엄 헤드폰")
                            .font(.headline)
                            .fontWeight(.bold)
                        
                        Text("₩299,000")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(Color(.systemBackground))
                    .cornerRadius(12)
                    .shadow(radius: 2)
                    
                    // 상품 리스트
                    VStack(spacing: 12) {
                        ForEach(0..<3) { index in
                            HStack {
                                ENMAsyncImageView(
                                    url: URL(string: "https://picsum.photos/\(250 + index)/\(200 + index)"),
                                    width: 60,
                                    height: 60,
                                    shape: .rounded(cornerRadius: 8)
                                )
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("상품 \(index + 1)")
                                        .font(.subheadline)
                                        .fontWeight(.medium)
                                    Text("₩\((index + 1) * 50000)")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                                Spacer()
                            }
                            .padding()
                            .background(Color(.systemBackground))
                            .cornerRadius(8)
                            .shadow(radius: 1)
                        }
                    }
                }
            }
        }
        .padding()
    }
    .background(Color(.systemGroupedBackground))
}

#Preview("Content Modes") {
    VStack(spacing: 16) {
        VStack(alignment: .leading, spacing: 8) {
            Text("콘텐츠 모드")
                .font(.headline)
                .fontWeight(.bold)
            
            HStack(spacing: 16) {
                VStack(spacing: 4) {
                    ENMAsyncImageView(
                        url: URL(string: "https://picsum.photos/300/200"),
                        width: 100,
                        height: 100,
                        shape: .rounded(cornerRadius: 8),
                        contentMode: .fill
                    )
                    Text("Fill")
                        .font(.caption)
                }
                
                VStack(spacing: 4) {
                    ENMAsyncImageView(
                        url: URL(string: "https://picsum.photos/300/200"),
                        width: 100,
                        height: 100,
                        shape: .rounded(cornerRadius: 8),
                        contentMode: .fit
                    )
                    Text("Fit")
                        .font(.caption)
                }
            }
        }
    }
    .padding()
    .background(Color(.systemGroupedBackground))
}
#endif
