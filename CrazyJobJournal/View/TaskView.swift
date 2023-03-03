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
    @State var isSaved = false
    
    var body: some View {
        NavigationStack() {
            VStack(alignment: .leading){
                Text("Info").bold().font(.system(size:24))
                HStack{
                    Text(LocalizedStringKey(job.desc!)).padding().overlay(RoundedRectangle(cornerRadius: 20)
                        .stroke(.blue,lineWidth: 0.4)).font(.system(size:16))
                }.frame(maxWidth: 300, maxHeight: 300, alignment: .topLeading)
            }.padding()
            VStack(alignment: .leading){
                Text("Info").bold().font(.system(size:24))
                HStack{
                    Text(LocalizedStringKey(tasksForJob.title!)).padding().overlay(RoundedRectangle(cornerRadius: 20)
                        .stroke(.blue,lineWidth: 0.4)).font(.system(size:16))
                }.frame(maxWidth: 300, maxHeight: 300, alignment: .topLeading)
            }.padding()
            NavigationLink {
                NoteView(path: $path, tasksForJob: $tasksForJob, job: $job)
            } label: {
                ZStack{
                    RoundedRectangle(cornerRadius: 15).frame(width: 275,height: 64).foregroundColor(.cyan)
                    Text(LocalizedStringKey("Add")).font(.title).foregroundColor(.white)
                }
            }
            NavigationLink {
                MainView().navigationBarBackButtonHidden(true)
            } label: {
                ZStack{
                    RoundedRectangle(cornerRadius: 15).frame(width: 275,height: 64).foregroundColor(.cyan)
                    Text(LocalizedStringKey("Home")).font(.title).foregroundColor(.white)
                }
            }

        }.navigationTitle(Text(LocalizedStringKey(job.title!)))
    }
}
