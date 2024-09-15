//
//  DashboardScreen.swift
//  iOSDashboardAssessment
//
//  Created by Kishore B on 06/09/24.
//

import SwiftUI

struct DashboardScreen: View {
    @ObservedObject var viewModel = ViewModel()
    private var formattedDate: String {
          let dateFormatter = DateFormatter()
          dateFormatter.dateFormat = "EEEE, MMMM d'th' yyyy"
          let currentDate = Date()
          return dateFormatter.string(from: currentDate)
      }
    var body: some View {
        NavigationStack{
            VStack{
                Text("Dashboard")
                    .font(Font.system(size: 18))
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity,alignment: .bottomLeading)
                    .padding(.leading,5)
                    .padding(.bottom,0)
                Spacer().frame(height: 1)
                    Divider()
                    .frame(height: 1,alignment: .top)
                    .background(.gray)
                Spacer().frame(height: 1)

                VStack(spacing: 20){
                    GreetingsView(formattedDate: formattedDate)
                        .frame(maxWidth: .infinity,maxHeight: 70,alignment: .leading)
                        .bordered(cornerRadius: 6, borderColor: .gray, borderWidth: 1)
                        .padding()
                    NavigationLink{
                        JobsScreen(viewModel: viewModel, selJobListModel: viewModel.jobListModelArr.first!)
                            .navigationBarHidden(true)
                    } label: {
                        JobStatsView(viewModel: viewModel)
                            .frame(maxWidth: .infinity,maxHeight: 200,alignment: .leading)
                            .bordered(cornerRadius: 6, borderColor: .gray, borderWidth: 1)
                            .padding()
                    }
                    
                    InvoiceStatsView(viewModel: viewModel)
                        .frame(maxWidth: .infinity,maxHeight: 175,alignment: .leading)
                        .bordered(cornerRadius: 6, borderColor: .gray, borderWidth: 1)
                        .padding()
                    }


                    Spacer()
                    
                }
                .frame(maxWidth: .infinity,maxHeight: .infinity)
                .edgesIgnoringSafeArea(.bottom)
               
                
                
// Adjust vertical padding

//                NavigationLink(value: 2) {
//                    VStack{
//                        Text("Hello, World!")
//                            .padding(.trailing,0)
//                    }
//                }
//                .navigationDestination(for: Int.self) { value in
//                    SecondScreen()
//                    }

            }
            .frame(maxWidth: .infinity,maxHeight: .infinity)
            .padding(.top,5)
            .navigationBarHidden(true)
           
        }
//        .frame(maxWidth: .infinity,maxHeight: .infinity)

//        .padding(.top,15)
        
           
}

#Preview {
    DashboardScreen()
}

struct GreetingsView: View {
    var formattedDate:String
    var body: some View {
        HStack{
            VStack(alignment: .leading){
                Text("Hello Henry Jones!👋")
                    .font(Font.system(size: 16,weight: .bold))
                    .lineLimit(1)
                Text(formattedDate)
                    .font(Font.system(size: 12,weight: .bold))
                    .foregroundStyle(Color.gray)
                    .lineLimit(1)
            }
            .padding()
            .frame(alignment: .leading)
            Spacer()
            Image("picture")
                .resizable()
                .frame(width:40,height: 40)
                .cornerRadius(3)
                .padding()
            
        }
        }
           
}
extension Color {
    static func random() -> Color {
        let red = Double.random(in: 0...1)
        let green = Double.random(in: 0...1)
        let blue = Double.random(in: 0...1)
        return Color(red: red, green: green, blue: blue)
    }
}

struct InvoiceStatsView: View {
   @ObservedObject var viewModel:ViewModel
    var body: some View {
        VStack(alignment: .leading){
            Text("Invoice Stats")
                .font(Font.system(size: 16,weight: .bold))
                .lineLimit(1)
                .frame(maxHeight: 40,alignment: .leading)
                .padding(.leading,10)
            Spacer().frame(height: 1)
            Divider()
                .background(.gray)
            Spacer().frame(height: 1)
            HStack(spacing: 0){
                Text("Total value ($\(String(format:"%.1f",viewModel.allInvoiceTotalBill)))")
                    .font(Font.system(size: 14,weight: .medium))
                    .foregroundStyle(Color(.darkGray))
                    .lineLimit(1)
                    .frame(alignment: .leading)
                Spacer()
                Text("$\(String(format:"%.1f",viewModel.paidInvoiceTotalBill)) collected")
                    .font(Font.system(size: 14,weight: .medium))
                    .foregroundStyle(Color(.darkGray))
                    .lineLimit(1)
                    .frame(alignment: .leading)
            }
            .padding(EdgeInsets(top: 10, leading: 10, bottom: -5, trailing: 10))
            GeometryReader{ geometry in
                HStack(spacing: 0){
                    ForEach(viewModel.invoiceColorArr) { val in
                        Rectangle()
                            .fill(val.color)
                            .frame(height: geometry.size.height)
                            .frame(width: geometry.size.width*CGFloat(val.percentage))
                    }
                }
                .frame(maxWidth: .infinity)
                .background(.yellow)
                .bordered(cornerRadius: 6, borderColor: .gray, borderWidth: 1)
                .background(.yellow)
                
            }
            .frame(maxWidth: .infinity,maxHeight: 20)
            .padding(EdgeInsets(top: 5, leading: 10, bottom: 10, trailing: 10))
            
            HStack{
                Spacer()
                ColoredTextView(color: .yellow, text: "Draft ($\(viewModel.draftInvoiceTotalBill))")
                    .padding(.trailing,25)
                ColoredTextView(color: Color(.systemBlue), text: "Pending ($\(viewModel.pendingInvoiceTotalBill))")
                Spacer()
            }
            HStack{
                Spacer()
                ColoredTextView(color: .green, text: "Paid ($\(viewModel.paidInvoiceTotalBill))")
                    .padding(.trailing,5)
                ColoredTextView(color: .red, text: "Bad Debt ($\(viewModel.badDebtInvoiceTotalBill))")
                Spacer()
                
            }
            
            Spacer()
        }
       
    }
}

struct JobStatsView: View {
    @ObservedObject var viewModel:ViewModel
    var body: some View {
        VStack(alignment: .leading){
            Text("Job Stats")
                .font(Font.system(size: 16,weight: .bold))
                .foregroundStyle(Color.black)
                .lineLimit(1)
                .frame(maxHeight: 40,alignment: .leading)
                .padding(.leading,10)
            Spacer().frame(height: 1)
            Divider()
                .background(.gray)
            Spacer().frame(height: 1)
            HStack(spacing: 0){
                Text("\(viewModel.jobList.count) Jobs")
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
            
            HStack{
                Spacer()
                ColoredTextView(color: .purple, text: "yet to start(\(viewModel.yetToStart.count))")
                    .padding(.trailing,25)
                ColoredTextView(color: Color(.systemBlue), text: "in progress(\(viewModel.inProgress.count))")
                Spacer()
            }
            HStack{
                Spacer()
                ColoredTextView(color: .yellow, text: "Cancelled(\(viewModel.cancelled.count))")
                    .padding(.trailing,5)
                ColoredTextView(color: .green, text: "Completed(\(viewModel.completed.count))")
                Spacer()
                
            }
            HStack{
                Spacer()
                ColoredTextView(color: .red, text: "In complete(\(viewModel.inComplete.count))")
                Spacer()
                
            }
            Spacer()
        }
       
    }
}
