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
    
    var body: some View {
        NavigationStack(path: $path){
            Text(LocalizedStringKey("SelfReflection")).padding(.top)
            Form{
                Section{
                    ZStack{
                        TextEditor(text: self.$Desc).textSelection(.enabled).frame(height: 400)
                    }
                }.onTapGesture {
                    self.hideKeyboard()
                }
                NavigationLink {
                    MainView().navigationBarBackButtonHidden(true)
                } label: {
                    HStack{
                        Spacer()
                        Text(LocalizedStringKey("Done"))
                        Spacer()
                    }
                }.onDisappear(){
                    note = DataController().addNote(desc: Desc, task: tasksForJob, context: managedObjContext)
                    DataController().addNoteToTask(note: note, task: tasksForJob, context: managedObjContext)
                    DataController().editTask(task: tasksForJob, isTaken: false, context: managedObjContext)
                    DataController().editTask(task: tasksForJob, isDone: true, context: managedObjContext)
                    DataController().editJob(job: job, isFound: false, context: managedObjContext)
                }
            }
        }
    }
}
