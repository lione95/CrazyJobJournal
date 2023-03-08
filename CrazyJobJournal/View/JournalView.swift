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
            Text(LocalizedStringKey(task.taskForNote!.desc!))
            .frame(width: 240 ,height: 480)
            .padding(10)
            .background(Color.ColorNote)
            .cornerRadius(20)
            .font(.system(size:16))
            .fixedSize(horizontal: false, vertical: true)
        }
    }
}
