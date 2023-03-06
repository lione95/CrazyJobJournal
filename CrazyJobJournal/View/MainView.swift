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
    var save: Bool {
        for i in 0..<jobs.count{
            if(jobs[i].isChosen){
               return true
            }
        }
        return false
    }
    
    
    var body: some View {
        NavigationStack(path: $path){
            VStack(spacing:50){
                Spacer()
                Image("base").frame(width: 275,height: 360)
                Spacer()
                VStack(spacing: 35){
                    NavigationLink {
                        if(!(thereIsJobAndTask(job: jobs, task: tasks))){
                            ShakeView(path: $path)
                        }else{
                            TaskView(path: $path, job: jobActive, tasksForJob: taskActive)
                        }
                    } label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 20).frame(width: 185,height: 65).foregroundColor(.accentColor)
                            HStack{
                                Text(thereIsJobAndTask(job: jobs, task: tasks) ? LocalizedStringKey("Resume") : LocalizedStringKey("FirstButton") ).font(.system(size: 18)).foregroundColor(.white)
                                Image(systemName: "play.fill")
                                    .foregroundColor(.white)
                            }
                        }
                    }
                    if(save){
                        NavigationLink(destination: JobView(path: $path)) {
                            HStack{
                                ZStack{
                                    RoundedRectangle(cornerRadius: 20).frame(width: 185,height: 65).foregroundColor(Color.white)
                                    HStack{
                                        Text(LocalizedStringKey("PastJ")).font(.system(size: 18)).foregroundColor( .accentColor)
                                        Image(systemName: "bookmark.fill").foregroundColor( .accentColor)
                                    }
                                }.overlay(RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color("AccentColor"),lineWidth: 1.0))
                            }
                        }.padding(.bottom)
                    }else{
                        HStack{
                            ZStack{
                                RoundedRectangle(cornerRadius: 20).frame(width: 185,height: 65).foregroundColor( Color.gray).opacity(0.3)
                                HStack{
                                    Text(LocalizedStringKey("PastJ")).font(.system(size: 18)).foregroundColor(.white)
                                    Image(systemName: "bookmark.fill").foregroundColor(.white)
                                }
                            }.overlay(RoundedRectangle(cornerRadius: 20)
                                .stroke(Color("ColorStroke"),lineWidth: 1.0))
                        }.padding(.bottom)
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
