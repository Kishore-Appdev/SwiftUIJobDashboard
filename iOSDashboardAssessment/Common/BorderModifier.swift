//
//  BorderModifier.swift
//  iOSDashboardAssessment
//
//  Created by Kishore B on 06/09/24.
import SwiftUI

struct BorderModifier: ViewModifier {
    var cornerRadius: CGFloat
    var borderColor: Color
    var borderWidth: CGFloat

    func body(content: Content) -> some View {
        content
            .cornerRadius(cornerRadius)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(borderColor, lineWidth: borderWidth)
            )
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
    }
}

extension View {
    func bordered(cornerRadius: CGFloat = 10, borderColor: Color = .gray, borderWidth: CGFloat = 2) -> some View {
        self.modifier(BorderModifier(cornerRadius: cornerRadius, borderColor: borderColor, borderWidth: borderWidth))
    }
}
