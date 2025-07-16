//
//  popUp.swift
//  GlowIn
//
//  Created by Hooriya Kazmi on 7/16/25.
//

import SwiftUI

struct QuestCompleteView: View {
    var body: some View {
        ZStack {
        
            Color(red: 1.0, green: 0.937, blue: 0.757)
                            .ignoresSafeArea()
            Image("questCompleteBackground")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 300)
            VStack {
                Spacer().frame(height: 100)
                
                HStack(spacing: 40) {
                  
                    Button(action: {
                        print("Liked it")
                    }) {
                        Image("thumbsUpButton")
                            .resizable()
                            .frame(width: 100, height: 100)
                    }
                    
                   
                    Button(action: {
                        print("Not for me")
                    }) {
                        Image("thumbsDownButton")
                            .resizable()
                            .frame(width: 100, height: 100)
                    }
                }
                
                Spacer().frame(height: 30)
                
                Button(action: {
                    print("Done pressed")
                }) {
                    Text("done")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 10)
                        .background(Color.orange)
                        .cornerRadius(20)
                        .shadow(color: .gray.opacity(0.3), radius: 4, x: 0, y: 2)
                }
            }
        }
    }
}
#Preview {
    QuestCompleteView()
}
