//
//  HistoryView.swift
//  CrazyJobJournal
//
//  Created by Nanashi Kai Ni on 28/02/23.
//

import SwiftUI

struct HistoryView: View {
    
    @Environment(\.managedObjectContext) var managedObjContext
    @Binding var path : NavigationPath
    @Binding var job : JobE
    @State var listOfTask : [TaskE] = []
    
    var body: some View {
        NavigationStack(path: $path){
            Text(LocalizedStringKey(job.title!)).font(.title)
            Divider()
            List{
                ForEach($listOfTask){ $task in
                    NavigationLink {
                        JournalView(path: $path, task: task)
                    } label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 20).frame(width: 65, height: 65).foregroundColor(Color.clear)
                            Text(LocalizedStringKey($task.title.wrappedValue!)).foregroundColor(.accentColor)
                        }
                    }
                }
            }
        }.onAppear(){
            listOfTask = job.toTask.array(of: TaskE.self).filter({$0.isDone})
        }
    }
}
