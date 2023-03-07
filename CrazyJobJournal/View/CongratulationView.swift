//
//  CongratulationView.swift
//  CrazyJobJournal
//
//  Created by Mattia Golino on 07/03/23.
//

import SwiftUI

struct CongratulationView: View {
    
    @Binding var path: NavigationPath
    @Binding var tasksForJob: TaskE
    @Binding var job: JobE
    
    var body: some View {
        NavigationStack(path: $path){
            NavigationLink {
                NoteView(path: $path, tasksForJob: $tasksForJob, job: $job).navigationBarBackButtonHidden(true)
            } label: {
                Image("Congratulation")
            }

        }
    }
}
