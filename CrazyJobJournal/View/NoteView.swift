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
            VStack(alignment: .leading){
                VStack(spacing: 15){
                    HStack{
                        Spacer()
                        Text(LocalizedStringKey("SelfReflection")).font(.system(size:24)).foregroundColor(.accentColor)
                        Spacer()
                    }
                    Text(LocalizedStringKey("Rifletti")).font(.system(size:16)).foregroundColor(.accentColor).fixedSize(horizontal: true, vertical: false)
                }
                VStack{
                    ZStack{
                        RoundedRectangle(cornerRadius: 20).frame(width: 346, height: 500)
                        TextEditor(text: self.$Desc).textSelection(.enabled).frame(width: 346, height: 500).scrollContentBackground(.hidden).background(Color("ColorNote")).cornerRadius(20)
                    }
                }.padding()
            }.onTapGesture {
                self.hideKeyboard()
            }.padding()
            NavigationLink(destination: MainView().navigationBarBackButtonHidden(true), isActive: $save) {
                HStack{
                    Button(action: {save.toggle()}) {
                        ZStack{
                            RoundedRectangle(cornerRadius: 20).frame(width: 185, height: 65).foregroundColor(.accentColor)
                            Text(LocalizedStringKey("Done")).foregroundColor(.white)
                        }
                    }
                }
            }.onDisappear(){
                if(save && !(self.Desc.isEmpty)){
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
