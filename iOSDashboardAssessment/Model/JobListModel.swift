//
//  JobListModel.swift
//  iOSDashboardAssessment
//
//  Created by Kishore B on 08/09/24.
//

import Foundation
import SampleData
struct JobListModel:Identifiable{
    let id = UUID()
    let topicString:String
    let topicJobList:[JobApiModel]
}
