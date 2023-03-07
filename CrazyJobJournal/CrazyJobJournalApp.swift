//
//  CrazyJobJournalApp.swift
//  CrazyJobJournal
//
//  Created by Nanashi Kai Ni on 28/02/23.
//
import SwiftUI

@main
struct CrazyJobJournalApp: App {
    
    @StateObject private var dataController = DataController()
    @AppStorage("firstUse") private var firstuse: Bool = true
    
    var body: some Scene {
        WindowGroup {
            MainView()
                //.preferredColorScheme(.light)
                .environment(\.managedObjectContext, dataController.container.viewContext).onAppear(){
                    if(firstuse){
                        firstuse.toggle()
                        AddAllWork()
                    }
                }
        }
    }
    
    private func AddAllWork(){
        DataController().addJob(title: "Job1", desc: "Desc1", imageName: "civil_eng", icon: "icon_civil_eng", context: dataController.container.viewContext)
        
        DataController().addJob(title: "Job2", desc: "Desc2", imageName: "computer_science", icon: "icon_computer_science", context: dataController.container.viewContext)
        
        DataController().addJob(title: "Job3", desc: "Desc3", imageName: "linguist", icon: "icon_linguist", context: dataController.container.viewContext)
        
        DataController().addJob(title: "Job4", desc: "Desc4", imageName: "graphic_designer", icon: "icon_graphic_designer", context: dataController.container.viewContext)
        
        DataController().addJob(title: "Job5", desc: "Desc5", imageName: "business_development_officer", icon: "icon_business_development_officer", context: dataController.container.viewContext)
        
        AddAllTask()
    }
    
    private func AddAllTask(){
        let jobs: [JobE] = DataController().getJob(context: dataController.container.viewContext)
        DataController().addTask(title: "Task1", desc: "TaskDes1", job: jobs[0], context: dataController.container.viewContext)
        DataController().addTask(title: "Task2", desc: "TaskDes2", job: jobs[0], context: dataController.container.viewContext)
        DataController().addTask(title: "Task3", desc: "TaskDes3", job: jobs[0], context: dataController.container.viewContext)
        DataController().addTask(title: "Task4", desc: "TaskDes4", job: jobs[1], context: dataController.container.viewContext)
        DataController().addTask(title: "Task5", desc: "TaskDes5", job: jobs[1], context: dataController.container.viewContext)
        DataController().addTask(title: "Task6", desc: "TaskDes6", job: jobs[1], context: dataController.container.viewContext)
        DataController().addTask(title: "Task7", desc: "TaskDes7", job: jobs[2], context: dataController.container.viewContext)
        DataController().addTask(title: "Task8", desc: "TaskDes8", job: jobs[2], context: dataController.container.viewContext)
        DataController().addTask(title: "Task9", desc: "TaskDes9", job: jobs[2], context: dataController.container.viewContext)
        DataController().addTask(title: "Task10", desc: "TaskDes10", job: jobs[3], context: dataController.container.viewContext)
        DataController().addTask(title: "Task11", desc: "TaskDes11", job: jobs[3], context: dataController.container.viewContext)
        DataController().addTask(title: "Task12", desc: "TaskDes12", job: jobs[3], context: dataController.container.viewContext)
        DataController().addTask(title: "Task13", desc: "TaskDes13", job: jobs[4], context: dataController.container.viewContext)
        DataController().addTask(title: "Task14", desc: "TaskDes14", job: jobs[4], context: dataController.container.viewContext)
        DataController().addTask(title: "Task15", desc: "TaskDes15", job: jobs[4], context: dataController.container.viewContext)
    }
    
}
