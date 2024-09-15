//
//  JobsScreen.swift
//  iOSDashboardAssessment
//
//  Created by Kishore B on 06/09/24.
//

import SwiftUI
struct JobsScreen:View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel:ViewModel
    @State var selJobListModel:JobListModel
    
    var body: some View {
        VStack(alignment: .leading){
            HStack {
                Image("ic_back")
                    .resizable()
                    .frame(width: 20,height: 20)
                    .padding()
                    .onTapGesture {
                        dismiss()

                    }
                Text("Jobs (\(viewModel.jobList.count)) ")
                    .font(Font.system(size: 18))
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity,alignment: .bottomLeading)
                    .padding(.leading,5)
                    .padding(.bottom,0)
            }
            Spacer().frame(height: 1)
            Divider()
                .frame(height: 1,alignment: .top)
                .background(.gray)
            Spacer().frame(height: 1)
            HStack(spacing: 0){
                Text("\($viewModel.jobList.count) Jobs")
                    .font(Font.system(size: 14,weight: .medium))
                    .foregroundStyle(Color(.darkGray))
                    .lineLimit(1)
                    .frame(alignment: .leading)
                Spacer()
                Text("\(viewModel.completed.count) of \(viewModel.jobList.count) completed")
                    .font(Font.system(size: 14,weight: .medium))
                    .foregroundStyle(Color(.darkGray))
                    .lineLimit(1)
                    .frame(alignment: .leading)
            }
            .padding(EdgeInsets(top: 10, leading: 10, bottom: -5, trailing: 10))
            GeometryReader{ geometry in
                HStack(spacing: 0){
                    ForEach(viewModel.jobsColorArr) { val in
                        Rectangle()
                            .fill(val.color) // Use the random color
                            .frame(height: geometry.size.height)
                            .frame(width: geometry.size.width * CGFloat(val.percentage))
                        //                                    .background(.brown)
                    }
                }
                .frame(maxWidth: .infinity)
                .background(.yellow)
                .bordered(cornerRadius: 6, borderColor: .gray, borderWidth: 1)
                .background(.yellow)
                
            }
            .frame(maxWidth: .infinity,maxHeight: 20)
            .bordered(cornerRadius: 6, borderColor: .gray, borderWidth: 1)
            .padding(EdgeInsets(top: 5, leading: 10, bottom: 10, trailing: 10))
            Spacer()
            let rows = [
                GridItem(.fixed(3))
            ]
            Rectangle()
                .frame(height: 1)
                .foregroundColor(Color(.lightGray))
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))

            ScrollView(.horizontal){
                
                ZStack {
                        Rectangle()
                            .frame(height: 1,alignment: .bottom)
                            .offset(y:17)
                        .foregroundColor(Color(.lightGray))
                    LazyHGrid(rows: rows,spacing: 10){
                        ForEach(viewModel.jobListModelArr){ jobListModel  in
                          
                                VStack{
                                    Text("\(jobListModel.topicString)")
                                        .onTapGesture {
                                            selJobListModel = jobListModel
                                        }
                                    Spacer()
                                        .frame(height: 10)
      
                                            Rectangle()
                                                .frame(height: 4)
                                                .foregroundColor(self.selJobListModel.id == jobListModel.id ? Color.purple : Color(.clear))
                                            Spacer()
                                                .frame(height: 0)

                                }
                     
                        }
                    }
                    .padding(.leading,10)
                    .background(Color(.clear))
                }

            }
            .frame(height: 50)
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))

            let columns = [GridItem(.flexible())]
            ScrollView(.vertical){
                LazyVGrid(columns: columns){
                    ForEach(selJobListModel.topicJobList){ job in
                        JobListCell(viewModel: viewModel, jobapiModel: job)
                    }
                }
            }
            .refreshable {
                viewModel.refreshAllList()
                selJobListModel = viewModel.jobListModelArr.first!
            }
            
        }
        .onAppear{
            self.selJobListModel = self.viewModel.jobListModelArr.first!
        }
    }
}
struct FirstScreen: View {
    var body: some View {
        NavigationStack {
            VStack {
                NavigationLink(destination: SecondScreen()) {
                    Text("Go to Second Screen")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            .navigationTitle("First Screen")
        }
    }
}

struct SecondScreen: View {
    @Environment(\.dismiss) var dismiss // Access the dismiss action
    
    var body: some View {
        VStack {
            Text("This is the second screen")
                .font(.largeTitle)
            
            Button(action: {
                dismiss() // Pop the current view
            }) {
                Text("Go Back")
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
        .navigationBarHidden(true)
        .navigationTitle("Second Screen")
    }
}

#Preview(body: {
    JobsScreen(viewModel: ViewModel(), selJobListModel: ViewModel().jobListModelArr.first!)
})
