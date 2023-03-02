//
//  ContentView.swift
//  CrazyJobJournal
//
//  Created by Nanshi Kai Ni on 28/02/23.
//

import SwiftUI

var jobActive: JobE = JobE()
var taskActive: TaskE = TaskE()

struct MainView: View {
    
    @Environment(\.managedObjectContext) var managedObjContext
    @State var path : NavigationPath = NavigationPath()
    @FetchRequest(sortDescriptors: [SortDescriptor(\.id,order:.reverse)]) var jobs : FetchedResults<JobE>
    @FetchRequest(sortDescriptors: [SortDescriptor(\.id,order:.reverse)]) var tasks : FetchedResults<TaskE>
    
    var body: some View {
        NavigationStack(path: $path){
            VStack(spacing:50){
                Image("base").frame(width: 275,height: 360)
                NavigationLink {
                   if(!(thereIsJobAndTask(job: jobs, task: tasks))){
                        ShakeView(path: $path)
                    }else{
                        TaskView(path: $path, job: jobActive, tasksForJob: taskActive)
                    }
                } label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 15).frame(width: 275,height: 64).foregroundColor(.cyan)
                        Text(thereIsJobAndTask(job: jobs, task: tasks) ? LocalizedStringKey("Resume") : LocalizedStringKey("FirstButton") ).font(.title).foregroundColor(.white)
                    }
                }
                NavigationLink {
                    JobView(path: $path)
                } label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 15).frame(width: 275,height: 64).foregroundColor(.cyan)
                        Text(LocalizedStringKey("PastJ")).font(.title).foregroundColor(.white)
                    }
                }
            }
        }
    }
    
    func thereIsJobAndTask(job: FetchedResults<JobE>, task: FetchedResults<TaskE>) -> Bool{
        var isOk: Bool = false
        for i in 0..<job.count{
            if(job[i].isChosen){
                for j in 0..<task.count{
                    if(task[j].toJob?.title == job[i].title){
                        if(task[j].isTaken){
                            jobActive = job[i]
                            taskActive = task[j]
                            isOk = true
                        }
                    }
                }
            }
        }
        return isOk
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
