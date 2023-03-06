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
            VStack{
                Text(LocalizedStringKey(job.title!)).bold().font(.system(size:24)).multilineTextAlignment(.leading)
                Divider()
                HStack{
                    Text(LocalizedStringKey(job.desc!)).font(.system(size:16)).multilineTextAlignment(.leading)
                }.padding()
            }
            Divider()
            VStack{
                Text("Task").bold().font(.system(size:24))
                HStack{
                    Text(LocalizedStringKey(tasksForJob.title!)).padding().overlay(RoundedRectangle(cornerRadius: 20)
                    .stroke(Color("AccentColor"),lineWidth: 2)).font(.system(size:16)).multilineTextAlignment(.leading)
                }
            }.padding()
            HStack{
                VStack{
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
                Image("base").resizable()
            }.padding()
        }
    }
}
