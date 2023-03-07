//
//  TaskView.swift
//  CrazyJobJournal
//
//  Created by Nanashi Kai Ni on 28/02/23.
//

import SwiftUI

struct TaskView: View {
    
    @Environment(\.managedObjectContext) var managedObjContext
    @Binding var path: NavigationPath
    @State var job: JobE
    @State var tasksForJob: TaskE
    
    var body: some View {
        NavigationStack() {
            
            VStack(){
                Text(LocalizedStringKey(job.title!)).bold().font(.system(size:24)).multilineTextAlignment(.leading).padding(.top,20)
                Divider()
                HStack{
                    Text(LocalizedStringKey(job.desc!)).font(.system(size:16)).multilineTextAlignment(.leading)
                }.padding()
            }
            Divider()
            VStack{
                Text("Task").bold().font(.system(size:24))
                HStack{
                    Text(LocalizedStringKey(tasksForJob.title!)).padding(10)
                        .background(Color.ColorNote)
                    .cornerRadius(20)
                    .font(.system(size:16)).multilineTextAlignment(.leading)
                }
            }
            Spacer()
            HStack{
                VStack(spacing:30){
                    NavigationLink {
                        NoteView(path: $path, tasksForJob: $tasksForJob, job: $job)
                    } label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 20).frame(width: 185,height: 65).foregroundColor(.accentColor)
                            Text(LocalizedStringKey("Add")).font(.system(size: 16)).foregroundColor(.white)
                        }
                    }
                    NavigationLink {
                        MainView().navigationBarBackButtonHidden(true)
                    } label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 20).frame(width: 185,height: 65).foregroundColor(.accentColor)
                            Text(LocalizedStringKey("Home")).font(.system(size: 16)).foregroundColor(.white)
                        }
                    }
                }
                //Image(job.imageName!).resizable()
            }.padding()
        Spacer()
        }.onAppear(){
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0){
                UserDefaults.standard.set(job.id!.uuidString, forKey: "jobID")
                UserDefaults.standard.set(tasksForJob.id!.uuidString, forKey: "taskID")
            }
        }
    }
}
