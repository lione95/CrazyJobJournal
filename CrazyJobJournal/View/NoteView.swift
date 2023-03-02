//
//  NoteView.swift
//  CrazyJobJournal
//
//  Created by Nanshi Kai Ni on 28/02/23.
//

import SwiftUI

struct NoteView: View {
    
    @Environment(\.managedObjectContext) var managedObjContext
    @Environment(\.presentationMode) var presentationMode
    @Binding var tasksForJob: TaskE
    @Binding var job: JobE
    @State var Desc: String = ""
    @State var note: NoteE = NoteE()
    
    var body: some View {
        Text(LocalizedStringKey("SelfReflection")).padding(.top)
        Form{
            Section{
                ZStack{
                    TextEditor(text: self.$Desc).textSelection(.enabled).frame(height: 400)
                }
            }.onTapGesture {
                self.hideKeyboard()
            }
            HStack{
                Spacer()
                Button {
                    note = DataController().addNote(desc: Desc, task: tasksForJob, context: managedObjContext)
                    DataController().addNoteToTask(note: note, task: tasksForJob, context: managedObjContext)
                    DataController().editTask(task: tasksForJob, isTaken: false, context: managedObjContext)
                    DataController().editTask(task: tasksForJob, isDone: true, context: managedObjContext)
                    DataController().editJob(job: job, isFound: false, context: managedObjContext)
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text(LocalizedStringKey("Done"))
                }
                Spacer()
            }
        }
    }
}
