//
//  ColoredTextView.swift
//  iOSDashboardAssessment
//
//  Created by Kishore B on 06/09/24.
//

import Foundation
import SwiftUI

struct ColoredTextView: View {
    var color: Color
    var text: String
    var cornerRadius: CGFloat = 2
    var borderColor: Color = .gray
    var borderWidth: CGFloat = 0

    var body: some View {
        HStack {
            color
                .frame(width: 10, height: 10)
                .bordered(cornerRadius: cornerRadius, borderColor: borderColor, borderWidth: borderWidth)
            Text(text)
                .font(Font.system(size: 14, weight: .medium))
                .foregroundStyle(Color(.darkGray))
                .lineLimit(1)
                .frame(alignment: .leading) // Ensure text is aligned to the leading edge
        }
    }
}

#Preview {
    ColoredTextView(color: .blue, text: "abc")
}
