//
//  JobView.swift
//  CrazyJobJournal
//
//  Created by Nanashi Kai Ni on 28/02/23.
//

import SwiftUI

struct JobView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.id,order:.reverse)]) var job : FetchedResults<JobE>
    @Binding var path : NavigationPath
    @State var jobActive : [JobE] = []
    var body: some View {
        NavigationStack(path:$path){
            Text("History").font(.title)
            Divider()
            List{
                ForEach($jobActive) { $job in
                    NavigationLink {
                        HistoryView(path: $path, job: $job)
                    } label: {
                        HStack{
                            ZStack{
                                RoundedRectangle(cornerRadius: 20).frame(width: 65, height: 65).foregroundColor(.accentColor)
                                Image($job.icon.wrappedValue!)
                            }
                            Text(LocalizedStringKey($job.title.wrappedValue!))
                        }
                    }.frame(height:50)
                }.padding()
            }
        }.onAppear(){
            jobActive = job.filter { $0.toTask.array(of: TaskE.self).contains(where: {$0.isDone})}
        }
    }
}
