//
//  ContentView.swift
//  CrazyJobJournal
//
//  Created by Nanshi Kai Ni on 28/02/23.
//

import SwiftUI

struct MainView: View {
    
    @AppStorage("jobID") private var jobIDstr: String = ""
    @AppStorage("taskID") private var taskIDstr: String = ""
    @Environment(\.managedObjectContext) var managedObjContext
    @State var path : NavigationPath = NavigationPath()
    @FetchRequest(sortDescriptors: [SortDescriptor(\.id,order:.reverse)]) var jobs : FetchedResults<JobE>
    @FetchRequest(sortDescriptors: [SortDescriptor(\.id,order:.reverse)]) var tasks : FetchedResults<TaskE>
    var save: Bool {
        for i in 0..<jobs.count{
            if(jobs[i].isChosen){
                for j in 0..<tasks.count{
                    if(tasks[j].toJob?.title == jobs[i].title){
                        if(tasks[j].isDone){
                            return true
                        }
                    }
                }
            }
        }
        return false
    }
    
    
    var body: some View {
        NavigationStack(path: $path){
            VStack(spacing:100){
                Spacer()
                Image("base").frame(width: 275,height: 360)
                VStack(spacing: 20){
                    NavigationLink {
                        if(jobIDstr == ""){
                            ShakeView(path: $path)
                        }else{
                            TaskView(path: $path, job: jobs.first{$0.id == UUID(uuidString: jobIDstr)}!, tasksForJob: tasks.first{$0.id == UUID(uuidString: taskIDstr)}!).navigationBarBackButtonHidden(true)
                        }
                    } label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 20).frame(width: 185,height: 65).foregroundColor(.accentColor)
                            HStack{
                                Text(jobIDstr != "" ? LocalizedStringKey("Resume") : LocalizedStringKey("FirstButton") ).font(.system(size: 18)).foregroundColor(.white)
                                Image(systemName: "play.fill")
                                    .foregroundColor(.white)
                            }
                        }
                    }
                    if(save){
                        NavigationLink(destination: JobView(path: $path)) {
                            HStack{
                                ZStack{
                                    RoundedRectangle(cornerRadius: 20).frame(width: 185,height: 65).foregroundColor(.white)
                                    HStack{
                                        Text(LocalizedStringKey("PastJ")).font(.system(size: 18)).foregroundColor(.accentColor)
                                        Image(systemName: "bookmark.fill").foregroundColor( .accentColor)
                                    }
                                }.overlay(RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.accentColor, lineWidth: 1.0))
                            }
                        }.padding(.bottom)
                    }else{
                        HStack{
                            ZStack{
                                RoundedRectangle(cornerRadius: 20).frame(width: 185,height: 65).foregroundColor(Color.gray).opacity(0.3)
                                HStack{
                                    Text(LocalizedStringKey("PastJ")).font(.system(size: 18)).foregroundColor(.white)
                                    Image(systemName: "bookmark.fill").foregroundColor(.white)
                                }
                            }.overlay(RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.ColorStroke, lineWidth: 1.0))
                        }.padding(.bottom)
                    }
                }
            }
            
        }

    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
