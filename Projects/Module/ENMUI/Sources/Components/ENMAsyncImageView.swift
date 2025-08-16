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
