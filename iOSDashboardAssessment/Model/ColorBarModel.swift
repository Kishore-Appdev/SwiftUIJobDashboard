//
//  ColorBarModel.swift
//  iOSDashboardAssessment
//
//  Created by Kishore B on 08/09/24.
//

import Foundation
import SwiftUI
struct ColorBarModel: Identifiable {
    let id = UUID()
    let color: Color
    let percentage: Float
}
