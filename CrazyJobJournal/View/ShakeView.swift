//
//  ShakeView.swift
//  CrazyJobJournal
//
//  Created by Nanshi Kai Ni on 28/02/23.
//

import SwiftUI

struct ShakeView: View {
    
    @Environment(\.managedObjectContext) var managedObjContext
    @State var job : [JobE] = Array()
    @State var title: String = "Shake"
    @State var imageName: String = "base"
    @State var desc: String = "DefDesc"
    @State var tasks: Array<TaskE> = Array()
    @State var tasksForJob: TaskE = TaskE()
    @State var angleRotation: Double = 0.0
    @State var hasOnceShaked : Bool = false
    @State var randomJob : JobE = JobE()
    @Binding var path : NavigationPath
    
    var body: some View {
        NavigationStack(path:$path){
            VStack(spacing:20){
                Spacer()
                Image(imageName).modifier(Card(width: 275, height: 360, angleRotation: $angleRotation))
                Spacer()
                Text(LocalizedStringKey(title)).font(.title).font(.system(size:16)).foregroundColor(.accentColor)
                Spacer()
                NavigationLink {
                    TaskView(path: $path, job: randomJob, tasksForJob: tasksForJob).navigationBarBackButtonHidden(true)
                } label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 20).frame(width: 185,height: 65).foregroundColor(.accentColor)
                        Text(LocalizedStringKey("Next")).foregroundColor(.white)
                    }
                }.opacity(hasOnceShaked ? 1 : 0).onDisappear(){
                    if(hasOnceShaked){
                        DataController().editJob(job: randomJob, isChosen: true, context: managedObjContext)
                    }
                }
            }.onShake {
                if(!hasOnceShaked){
                    withAnimation(.easeInOut(duration:0.1)){
                        angleRotation = -15
                    }
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1){
                        withAnimation(.easeInOut(duration: 0.1)
                            .repeatCount(10)) {
                                angleRotation = 15
                            }}
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.1){
                        angleRotation = 0
                        hasOnceShaked = true
                        randomJob = job.randomElement()!
                        randomJob = job.randomElement()!
                        //while(randomJob.toTask.array(of: TaskE.self).contains{$0.isDone}) {}
                        
                        title = randomJob.title!
                        desc = randomJob.desc!
                        imageName = randomJob.imageName!
                        tasks = randomJob.toTask.array(of: TaskE.self).filter({!$0.isDone})
                        tasksForJob = tasks.randomElement()!

                    }
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 43200){
                        hasOnceShaked = false
                    }
                }
            }
        }.onAppear(){
            job = DataController().getJob(context: managedObjContext)
        }
    }
}

