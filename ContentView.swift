//
//  ContentView.swift
//  loginDemo
//
//  Created by Hooriya Kazmi on 6/30/25.
//

import SwiftUI

struct ContentView: View {
     @State var username = ""
    @State var password = ""
    var body: some View {
        ZStack{
            Color(red: 254/255, green: 246/255, blue: 223/255)
                .ignoresSafeArea()
            
            VStack{
                Text("Login")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(Color(red: 0.125, green: 0.282, blue: 0.004))
                Text("welcome back! You've been\nmissed")
                    .foregroundColor(Color(red: 0.125, green: 0.282, blue: 0.004))
                    .padding(.top,50)
                    .multilineTextAlignment(.center)
                   
                //email box
                TextField("Email", text: $username)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color.black.opacity(0.05))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color(red: 0.125, green: 0.282, blue: 0.004), lineWidth: 2)
                    )
                    .cornerRadius(10)
                    .padding(.top,60)
                
               //password box
                    SecureField("Password",text: $password)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color.black.opacity(0.05))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color(red: 0.125, green: 0.282, blue: 0.004), lineWidth: 2)
                    )
                    .cornerRadius(10)
                    .padding(.horizontal,32)
                    .padding(.top,30)
                
                //forgot pass
                HStack {
                           Spacer()
                           Button("Forgot your password?") {
                              
                           }
                           .font(.caption)
                           .foregroundColor(Color(red: 0.125, green: 0.282, blue: 0.004))
                           .padding(.trailing, 32)
                       }
                
                //sign in
                Button("Sign in"){
                }
                .frame(width:300,height:50)
                .foregroundColor(.white)
                .background(Color(red: 0.125, green: 0.282, blue: 0.004))
                .cornerRadius(40)
                .padding(.horizontal, 32)
                .shadow(color: .black.opacity(0.2), radius: 4, x: 0, y: 2)
                .padding(.top,30)

                //create new account styling
                Button("create new account"){
                }
                .foregroundColor(Color(red: 0.125, green: 0.282, blue: 0.004))
                .padding(.top, 8)
                
                //continue with styling
                Text("or continue with")
                    .foregroundColor(Color(red: 0.125, green: 0.282, blue: 0.004))
                    .padding(.top,50)
                
                HStack(spacing: 16) {
                    //button for apple icon
                    Button(action: {
                        print("Apple login tapped")
                    }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color(red: 234/255, green: 226/255, blue: 203/255)) // #EAE2CB
                                .frame(width: 40, height: 41)
                            
                            Image("apple")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                        }
                    }
                    //button for facebook icon
                    Button(action: {
                        print("Facebook login tapped")
                    }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color(red: 234/255, green: 226/255, blue: 203/255))
                                .frame(width: 40, height: 41)
                            Image("facebook")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                        }
                    }
                    // button for google icon
                    Button(action: {
                        print("Google login tapped")
                    }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color(red: 234/255, green: 226/255, blue: 203/255))
                                .frame(width: 40, height: 41)
                            
                            Image("google")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
