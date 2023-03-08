//
//  OnBoardingView.swift
//  CrazyJobJournal
//
//  Created by Mattia Golino on 07/03/23.
//

import SwiftUI

struct OnBoardingView: View {
    
    @Binding var path: NavigationPath
    
    var body: some View {
        NavigationStack(){
            TabView{
                
                Image("OnBoarding0")
                
                Image("OnBoarding1")
                
                Image("OnBoarding2")
                
                NavigationLink {
                    ShakeView(path: $path,firstTime: Binding.constant(true))
                } label: {
                    Image("OnBoarding3")
                }.onAppear(){
                    UserDefaults.standard.set(true,forKey: "otherUse")
                }
            }.tabViewStyle(.page(indexDisplayMode: .always)).indexViewStyle(.page(backgroundDisplayMode: .always))
        }
    }
}
