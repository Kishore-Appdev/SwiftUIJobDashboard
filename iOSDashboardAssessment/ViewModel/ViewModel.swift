//
//  ViewModel.swift
//  iOSDashboardAssessment
//
//  Created by Kishore B on 06/09/24.
//

import Foundation
import SampleData
import SwiftUI


class ViewModel:ObservableObject{
    
    @Published var jobList:[JobApiModel] = []
    @Published var yetToStart:[JobApiModel] = []
    @Published var inProgress:[JobApiModel] = []
    @Published var cancelled:[JobApiModel] = []
    @Published var completed:[JobApiModel] = []
    @Published var inComplete:[JobApiModel] = []
    
    @Published var draftInvoiceTotalBill:Float = 0
    @Published var pendingInvoiceTotalBill:Float = 0
    @Published var paidInvoiceTotalBill:Float = 0
    @Published var badDebtInvoiceTotalBill:Float = 0
    @Published var allInvoiceTotalBill:Float = 0
    
    @Published var jobsColorArr:[ColorBarModel] = []
    @Published var invoiceColorArr:[ColorBarModel] = []
    
    @Published var jobListModelArr:[JobListModel] = []


    


    @Published var invoiceList : [InvoiceApiModel] = []
    
    init(jobList: [JobApiModel] = [JobApiModel](), invoiceList: [InvoiceApiModel] = [InvoiceApiModel]()) {
        self.refreshAllList()
    }
    
    func refreshAllList(){
        self.jobsColorArr = []
        self.invoiceColorArr = []
        self.jobListModelArr = []
        self.jobList = SampleData.generateRandomJobList(size: 5000)
        self.invoiceList = SampleData.generateRandomInvoiceList(size: 5000)
        self.segregateJobsBasedOnStatus()
        self.segregateInvoiceBasedOnStatus()
        self.fillJobListModel()
    }
    
    func segregateJobsBasedOnStatus(){
//        print(jobList.first)
        var yetToStrt:[JobApiModel] = []
        var inProgres:[JobApiModel] = []
        var canceled:[JobApiModel] = []
        var completedArr:[JobApiModel] = []
        var inComplet:[JobApiModel] = []
        for job in jobList{
            if job.status == .yetToStart{
                yetToStrt.append(job)
            }
            else if job.status == .inProgress{
                inProgres.append(job)
            }else if job.status == .canceled{
                canceled.append(job)
            }
            else if job.status == .completed{
                completedArr.append(job)
            }else{
                inComplet.append(job)
            }
        }
        yetToStart = yetToStrt
        inProgress = inProgres
        cancelled = canceled
        completed = completedArr
        inComplete = inComplet
        jobsColorArr.append(ColorBarModel(color: .purple, percentage: Float(Float(yetToStart.count)/Float(jobList.count))))
        jobsColorArr.append(ColorBarModel(color: Color(.systemBlue), percentage: Float(Float(inProgress.count)/Float(jobList.count))))
        jobsColorArr.append(ColorBarModel(color: Color(.yellow), percentage: Float(Float(cancelled.count)/Float(jobList.count))))
        jobsColorArr.append(ColorBarModel(color: Color(.green), percentage: Float(Float(completed.count)/Float(jobList.count))))
        jobsColorArr.append(ColorBarModel(color: Color(.red), percentage: Float(Float(inComplete.count)/Float(jobList.count))))
        jobsColorArr.sort { ele1, ele2 in
            return ele1.percentage>ele2.percentage
        }
        
    }
    
    func segregateInvoiceBasedOnStatus(){
//        print(jobList.first)
        var draft:Float = 0
        var pending:Float = 0
        var paid:Float = 0
        var badDebt:Float = 0
        for invoice in invoiceList{
            if invoice.status == .draft{
                draft += Float(invoice.total)
            }
            else if invoice.status == .pending{
                pending += Float(invoice.total)
            }else if invoice.status == .paid{
                paid += Float(invoice.total)
            }
            else {
                badDebt += Float(invoice.total)
            }
        }
        draftInvoiceTotalBill = draft
        pendingInvoiceTotalBill = pending
        paidInvoiceTotalBill = paid
        badDebtInvoiceTotalBill = badDebt
        allInvoiceTotalBill = 0
        allInvoiceTotalBill = draftInvoiceTotalBill+pendingInvoiceTotalBill+paidInvoiceTotalBill+badDebtInvoiceTotalBill
        invoiceColorArr.append(ColorBarModel(color: Color(.yellow), percentage: draftInvoiceTotalBill/allInvoiceTotalBill))
        invoiceColorArr.append(ColorBarModel(color: Color(.systemBlue), percentage: pendingInvoiceTotalBill/allInvoiceTotalBill))
        invoiceColorArr.append(ColorBarModel(color: Color(.green), percentage: paidInvoiceTotalBill/allInvoiceTotalBill))
        invoiceColorArr.append(ColorBarModel(color: Color(.red), percentage: badDebtInvoiceTotalBill/allInvoiceTotalBill))

        invoiceColorArr.sort { ele1, ele2 in
            return ele1.percentage>ele2.percentage
        }

    }
    
    func fillJobListModel(){
        self.jobListModelArr.append(JobListModel(topicString: "Yet To Start (\(self.yetToStart.count))", topicJobList: yetToStart))
        self.jobListModelArr.append(JobListModel(topicString: "In-Progress (\(self.inProgress.count))", topicJobList: inProgress))
        self.jobListModelArr.append(JobListModel(topicString: "Cancelled (\(self.cancelled.count))", topicJobList: cancelled))
        self.jobListModelArr.append(JobListModel(topicString: "Completed (\(self.completed.count))", topicJobList: completed))
        self.jobListModelArr.append(JobListModel(topicString: "In-Complete (\(self.inComplete.count))", topicJobList: inComplete))
    }
    
    func formatDateRange(start: String, end: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"

        let outputDateFormatter = DateFormatter()
        outputDateFormatter.dateFormat = "dd-MM-yyyy"
        
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "h:mm a"
        
        let todayFormatter = DateFormatter()
        todayFormatter.dateFormat = "'Today', h:mm a"

        guard let startDate = dateFormatter.date(from: start), let endDate = dateFormatter.date(from: end) else {
            return nil
        }

        let calendar = Calendar.current
        let isSameDay = calendar.isDate(startDate, inSameDayAs: endDate)
        let isToday = calendar.isDateInToday(startDate)
        
        if isToday && isSameDay {
            return "\(todayFormatter.string(from: startDate)) - \(timeFormatter.string(from: endDate))"
        } else if isSameDay {
            return "\(outputDateFormatter.string(from: startDate)), \(timeFormatter.string(from: startDate)) - \(timeFormatter.string(from: endDate))"
        } else {
            return "\(outputDateFormatter.string(from: startDate)), \(timeFormatter.string(from: startDate)) - \(outputDateFormatter.string(from: endDate)), \(timeFormatter.string(from: endDate))"
        }
    }
}
