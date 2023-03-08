//
//  ShakeView.swift
//  CrazyJobJournal
//
//  Created by Nanshi Kai Ni on 28/02/23.
//

import SwiftUI

struct ShakeView: View {
    
    @Environment(\.managedObjectContext) var managedObjContext
    @State var hasShaked : Bool = UserDefaults.standard.bool(forKey: "hasShaked")
    @State var afterTimer: Bool = false
    @State var dayJob : String = UserDefaults.standard.string(forKey: "dayJob") ?? Date.distantPast.toString()
    @State var job : [JobE] = Array()
    @State var title: String = "Shake"
    @State var imageName: String = "base"
    @State var desc: String = "DefDesc"
    @State var tasksForJob: TaskE = TaskE()
    @State var angleRotation: Double = 0.0
    @State var randomJob : JobE = JobE()
    @State var timer = Timer.publish(every: 1, tolerance: 0.5, on: .current, in: .common).autoconnect()
    @Binding var path : NavigationPath
    @Binding var firstTime: Bool
    @State var waitingTime : String = ""
    let pre = Locale.preferredLanguages[0] // Da usare in OnB e congr per cambiare immagini ita eng
    let timeOff : TimeInterval = 30 //3*60*60 // 3 hours delay

    var body: some View {
        NavigationStack(path:$path){
            VStack(spacing:20){
                Spacer()
                Image(imageName).modifier(Card(width: 275, height: 360, angleRotation: $angleRotation))
                Spacer()
                Text(LocalizedStringKey(title)).font(.title).font(.system(size:16)).foregroundColor(.accentColor)
                Spacer()
                if(hasShaked){
                    if(dayJob.toDate()!.addingTimeInterval(timeOff) < Date.now){
                        NavigationLink {
                            TaskView(path: $path, job: randomJob, tasksForJob: tasksForJob).navigationBarBackButtonHidden(true)
                        } label: {
                            ZStack{
                                RoundedRectangle(cornerRadius: 20).frame(width: 185,height: 65).foregroundColor(.accentColor)
                                Text(LocalizedStringKey("Next")).foregroundColor(.white)
                            }
                        }
                        .onDisappear(){
                            afterTimer = false
                            if(hasShaked && UserDefaults.standard.string(forKey: "jobID") != "" ){
                                DataController().editJob(job: randomJob, isChosen: true, context: managedObjContext)
                            }
                        }
                        
                    } else {
                        HStack{
                            Text(LocalizedStringKey("Wait"))
                            Text("\(waitingTime)")
                        }
                    }
                }
            }.onShake {
                if(!hasShaked){
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
                        randomJob = job.filter{$0.toTask.array(of: TaskE.self).contains{!$0.isDone}}.randomElement()!
                        title = randomJob.title!
                        desc = randomJob.desc!
                        imageName = randomJob.imageName!
                        tasksForJob = randomJob.toTask.array(of: TaskE.self).filter({!$0.isDone}).randomElement()!
                        afterTimer = true
                        hasShaked = true
                        UserDefaults.standard.set(true, forKey: "hasShaked")
                    }
                }
            }
        }.onReceive(timer, perform: { _ in
            waitingTime = Date.now.distance(to: dayJob.toDate()!.addingTimeInterval(timeOff)).asString()
            if(dayJob.toDate()!.addingTimeInterval(timeOff) < Date.now && !firstTime && !afterTimer){
                hasShaked = false
                UserDefaults.standard.set(false, forKey: "hasShaked")
            }
            
        })
        .onAppear(){
            dayJob = UserDefaults.standard.string(forKey: "dayJob") ?? Date.distantPast.toString()
            waitingTime = Date.now.distance(to: dayJob.toDate()!.addingTimeInterval(timeOff)).asString()
            job = DataController().getJob(context: managedObjContext)
        }
    }
}

