//
//  TextEntryView.swift
//  ChatGpt_App
//
//  Created by Venkatesh Nyamagoudar on 5/27/23.
//

import SwiftUI

struct TextEntryView: View {
    
    @State private var userEnteredText: String = ""
    
    var body: some View {
        HStack {
            TextField("Enter Text", text: $userEnteredText)
                .textFieldStyle(.roundedBorder)
                .border(.gray)
                .padding()
            Button{
                getAnswerFor(text: userEnteredText)
            } label: {
                Image(systemName: "paperplane.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
            }
            .padding(.trailing)
        }
    }
    
    func getAnswerFor(text userEnteredText: String) {
        
    }
}

struct TextEntryView_Previews: PreviewProvider {
    static var previews: some View {
        TextEntryView()
    }
}


private enum LogType: String {
    case e = "[‼️]" // error
    case i = "[ℹ️]" // info
    case d = "[💬]" // debug
    case v = "[🔬]" // verbose
    case w = "[⚠️]" // warning
    case s = "[🔥]" // severe
}

