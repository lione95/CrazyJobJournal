//
//  ShakeView.swift
//  CrazyJobJournal
//
//  Created by Nanshi Kai Ni on 28/02/23.
//

import SwiftUI

struct ShakeView: View {
    
    @Environment(\.managedObjectContext) var managedObjContext
    @State var afterTimer: Bool = false
    @State var dayJob : String = UserDefaults.standard.string(forKey: "dayJob") ?? Date.distantPast.toString()
    @State var job : [JobE] = Array()
    @State var title: String = "Shake"
    @State var imageName: String = "base"
    @State var desc: String = "DefDesc"
    @State var tasksForJob: TaskE = TaskE()
    @State var angleRotation: Double = 0.0
    @State var randomJob : JobE = JobE()
    @State var timerOff = Timer.publish(every: 1, tolerance: 0.5, on: .current, in: .common).autoconnect()
    @State var timerShake = Timer.publish(every: 60, tolerance: 0.1, on: .current, in: .common).autoconnect()
    @Binding var path : NavigationPath
    @Binding var firstTime: Bool
    @State var waitingTime : String = ""
    let pre = Locale.preferredLanguages[0] // Da usare in OnB e congr per cambiare immagini ita eng
    let timeOffset : TimeInterval = 60 //3*60*60 // 3 hours delay

    var body: some View {
        NavigationStack(path:$path){
            VStack(spacing:20){
                Spacer()
                Image(imageName).modifier(Card(width: 275, height: 360, angleRotation: $angleRotation))
                Spacer()
                Text(LocalizedStringKey(title)).font(.title).font(.system(size:16)).foregroundColor(.accentColor)
                    .opacity(dayJob.toDate()!.addingTimeInterval(timeOffset) < Date.now ? 1 : 0)
                Spacer()
                if(UserDefaults.standard.bool(forKey: "hasShaked")){
                    if(dayJob.toDate()!.addingTimeInterval(timeOffset) < Date.now){
                        NavigationLink {
                            TaskView(path: $path, job: randomJob, tasksForJob: tasksForJob).navigationBarBackButtonHidden(true)
                        } label: {
                            ZStack{
                                RoundedRectangle(cornerRadius: 20).frame(width: 185,height: 65).foregroundColor(.accentColor)
                                Text(LocalizedStringKey("Next")).foregroundColor(.white)
                            }
                        }
                        .onDisappear(){
                            if(UserDefaults.standard.bool(forKey: "hasShaked") && UserDefaults.standard.string(forKey: "jobID") != "" ){
                                DataController().editJob(job: randomJob, isChosen: true, context: managedObjContext)
                            }
                        }
                        
                    } else {
                        HStack{
                            Text(LocalizedStringKey("Wait"))
                            Text("\(waitingTime)")
                        }
                        Spacer()
                    }
                }
            }.onShake {
                if(!UserDefaults.standard.bool(forKey: "hasShaked")){
                    afterTimer = true
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
                        UserDefaults.standard.set(true, forKey: "hasShaked")
                        print("HA SHAKERATO E VERO")
                    }
                }
            }
        }
        .onReceive(timerOff, perform: { _ in
            let waitingT : TimeInterval = Date.now.distance(to: dayJob.toDate()!.addingTimeInterval(timeOffset))
            waitingTime = waitingT.asString()
            if( waitingT < 0.5 && waitingT > -0.5){
                UserDefaults.standard.set(false, forKey: "hasShaked")
            }
        })
        .onReceive(timerShake, perform: { _ in
            if(!firstTime && !afterTimer){
                UserDefaults.standard.set(false, forKey: "hasShaked")
                print("FINITO IL TIMER E FALSO")
            }
            
        })
        .onAppear(){
            if(dayJob.toDate()!.addingTimeInterval(timeOffset) < Date.now && !firstTime && !afterTimer){
                UserDefaults.standard.set(false, forKey: "hasShaked")
            }
            afterTimer = false
            dayJob = UserDefaults.standard.string(forKey: "dayJob") ?? Date.distantPast.toString()
            waitingTime = Date.now.distance(to: dayJob.toDate()!.addingTimeInterval(timeOffset)).asString()
            job = DataController().getJob(context: managedObjContext)
        }
    }
}

