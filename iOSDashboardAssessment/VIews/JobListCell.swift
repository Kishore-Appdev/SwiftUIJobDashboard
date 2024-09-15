//
//  JobListCell.swift
//  iOSDashboardAssessment
//
//  Created by Kishore B on 08/09/24.
//

import SwiftUI
import SampleData

struct JobListCell: View {
    var viewModel:ViewModel
    var jobapiModel:JobApiModel
    var body: some View {
        VStack(alignment: .leading,spacing: 0){
            Text("#\(jobapiModel.jobNumber)")
                .padding(EdgeInsets(top: 15, leading: 15, bottom: 10, trailing: 15))
            Text("\(jobapiModel.title)")
                .fontWeight(.bold)
                .padding(EdgeInsets(top: 2, leading: 15, bottom: 0, trailing: 10))
            Text("\(viewModel.formatDateRange(start: jobapiModel.startTime, end: jobapiModel.endTime) ?? "") ")
                .padding(EdgeInsets(top: 5, leading: 15, bottom: 10, trailing: 10))
            

        }
        .frame(maxWidth: .infinity,maxHeight: 120,alignment: .topLeading)
        .bordered()
        .padding(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 10))
        
    }
}

#Preview {
    JobListCell(viewModel: ViewModel(), jobapiModel: ViewModel().jobList.first!)
}
