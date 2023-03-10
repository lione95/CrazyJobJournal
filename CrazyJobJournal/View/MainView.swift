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
    var isEmptyJournal : Bool {
        return jobs.filter({$0.isChosen})
            .contains{$0.toTask.array(of: TaskE.self)
                .contains{$0.isDone}}
    }
    
    
    var body: some View {
        NavigationStack(path: $path){
            VStack(spacing:100){
                Spacer()
                Image("base").frame(width: 275,height: 360)
                VStack(spacing: 20){
                    NavigationLink {
                        if(jobIDstr == ""){
                            if(!UserDefaults.standard.bool(forKey: "otherUse")){
                                OnBoardingView(path: $path)
                                    .navigationBarBackButtonHidden(true)
                            }else{
                                ShakeView(path: $path,firstTime: Binding.constant(false))
                                    .navigationBarBackButtonHidden(UserDefaults.standard.bool(forKey: "hasShaked"))
                            }
                        }else{
                            TaskView(path: $path, job: jobs.first{$0.id == UUID(uuidString: jobIDstr)}!, tasksForJob: tasks.first{$0.id == UUID(uuidString: taskIDstr)}!)
                                .navigationBarBackButtonHidden(true)
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
                    if(isEmptyJournal){
                        NavigationLink(destination: JobView(path: $path)) {
                            HStack{
                                ZStack{
                                    RoundedRectangle(cornerRadius: 20).frame(width: 185,height: 65).foregroundColor(.white)
                                    HStack{
                                        Text(LocalizedStringKey("PastJ")).font(.system(size: 18)).foregroundColor(.accentColor)
                                        Image(systemName: "book.fill").foregroundColor( .accentColor)
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
                                    Image(systemName: "book").foregroundColor(.white)
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
