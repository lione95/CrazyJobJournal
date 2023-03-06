//
//  JournalView.swift
//  CrazyJobJournal
//
//  Created by Nanshi Kai Ni on 28/02/23.
//

import SwiftUI

struct JournalView: View {
    
    @Binding var path : NavigationPath
    @State var task : TaskE
    
    var body: some View {
        NavigationStack(path: $path){
            Text(task.taskForNote!.desc!).foregroundColor(.accentColor)
        }
    }
}
