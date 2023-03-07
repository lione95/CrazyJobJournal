//
//  NoteView.swift
//  CrazyJobJournal
//
//  Created by Nanshi Kai Ni on 28/02/23.
//

import SwiftUI

struct NoteView: View {
    
    @Environment(\.managedObjectContext) var managedObjContext
    @Binding var path: NavigationPath
    @Binding var tasksForJob: TaskE
    @Binding var job: JobE
    @State var Desc: String = ""
    @State var note: NoteE = NoteE()
    @State var save: Bool = false
    
    var body: some View {
        NavigationStack(path: $path){
            VStack{
                VStack{
                    HStack{
                        Spacer()
                        Text(LocalizedStringKey("SelfReflection")).font(.system(size:24)).foregroundColor(.accentColor)
                        Spacer()
                    }
                }
                TextField("", text: self.$Desc,prompt: Text(LocalizedStringKey("Rifletti")), axis: .vertical).padding(.all,10)
                    .lineLimit(12...18)
                    .font(.system(size:20))
                    .overlay(RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.accentColor,lineWidth: 2))
                    .padding()
            }.onTapGesture {
                self.hideKeyboard()
            }
            if(self.Desc.isEmpty){
                ZStack{
                    RoundedRectangle(cornerRadius: 20).frame(width: 185, height: 65).foregroundColor(.gray)
                    Text(LocalizedStringKey("Done")).foregroundColor(.white)
                }.padding()
            } else {
                NavigationLink(destination: MainView().navigationBarBackButtonHidden(true)) {
                    ZStack{
                        RoundedRectangle(cornerRadius: 20).frame(width: 185, height: 65).foregroundColor(.accentColor)
                        Text(LocalizedStringKey("Done")).foregroundColor(.white)
                    }.padding()
                }
            }
            Spacer()
        }.onDisappear(){
            if(!(self.Desc.isEmpty)){
                note = DataController().addNote(desc: Desc, task: tasksForJob, context: managedObjContext)
                DataController().addNoteToTask(note: note, task: tasksForJob, context: managedObjContext)
                DataController().editTask(task: tasksForJob, isDone: true, context: managedObjContext)
                DataController().editJob(job: job, isFound: false, context: managedObjContext)
                UserDefaults.standard.set("", forKey: "jobID")
                UserDefaults.standard.set("", forKey: "taskID")
            }
            
        }
    }
}
