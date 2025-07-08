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
    @State var confirmPassword = ""
    let orange = Color(red: 255/255, green: 93/255, blue: 0/255)       // #FF5D00
       let cream = Color(red: 255/255, green: 239/255, blue: 193/255)     // #FFEFC1
       let darkGreen = Color(red: 54/255, green: 79/255, blue: 35/255)    // #364F23
    var body: some View {
        ZStack{
            Color(Color(red: 255/255, green: 239/255, blue: 193/255) )
                .ignoresSafeArea()
            
            VStack{
                Text("Create Account")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor( Color(red: 255/255, green: 93/255, blue: 0/255) )
                Text("Welcome! Ready to get your\nglow on?")
                    .foregroundColor(Color(red: 0.125, green: 0.282, blue: 0.004))
                    .padding(.top,50)
                    .multilineTextAlignment(.center)
                   
                //email box
                TextField("Email", text: $username)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color.black.opacity(0.05))
                    .foregroundColor(Color(red: 54/255, green: 79/255, blue: 35/255))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke( Color(red: 255/255, green: 93/255, blue: 0/255), lineWidth: 2)
                        
                    )
                    .cornerRadius(10)
                    .padding(.top,60)
                
               //password box
                    SecureField("Password",text: $confirmPassword)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color.black.opacity(0.05))
                    .foregroundColor(Color(red: 54/255, green: 79/255, blue: 35/255))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke( Color(red: 255/255, green: 93/255, blue: 0/255) , lineWidth: 2)
                    )
                    .cornerRadius(10)
                    .padding(.horizontal,32)
                    .padding(.top,30)
                
                //confirm password box
                     SecureField(" Confirm Password",text: $password)
                     .padding()
                     .frame(width: 300, height: 50)
                     .background(Color.black.opacity(0.05))
                     .foregroundColor(Color(red: 54/255, green: 79/255, blue: 35/255))
                     .overlay(
                         RoundedRectangle(cornerRadius: 10)
                             .stroke( Color(red: 255/255, green: 93/255, blue: 0/255), lineWidth: 2)
                     )
                     .cornerRadius(10)
                     .padding(.horizontal,32)
                     .padding(.top,30)
                 
                
                //sign in
                Button("Sign up"){
                }
                .frame(width:300,height:50)
                .foregroundColor(.white)
                .background(Color(red: 0.125, green: 0.282, blue: 0.004))
                .cornerRadius(40)
                .padding(.horizontal, 32)
                .shadow(color: .black.opacity(0.2), radius: 4, x: 0, y: 2)
                .padding(.top,30)

                //old account styling
                Button("already have an account?"){
                }
                .foregroundColor(Color(red: 54/255, green: 79/255, blue: 35/255))
                .padding(.top, 8)
                .font(.caption)
                
                //continue with styling
                Text("or continue with")
                    .foregroundColor(Color(red: 54/255, green: 79/255, blue: 35/255))
                    .padding(.top,50)
                
                HStack(spacing: 16) {
                    //button for apple icon
                    Button(action: {
                        print("Apple login tapped")
                    }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color(red: 255/255, green: 202/255, blue: 123/255)) // #EAE2CB
                                .frame(width: 40, height: 41)
                            
                            Image("apple")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25, height: 25)
                        }
                    }
                    //button for facebook icon
                    Button(action: {
                        print("Facebook login tapped")
                    }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color(red: 255/255, green: 202/255, blue: 123/255))
                                .frame(width: 40, height: 41)
                            Image("facebook")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25, height: 25)
                        }
                    }
                    // button for google icon
                    Button(action: {
                        print("Google login tapped")
                    }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color(red: 255/255, green: 202/255, blue: 123/255))
                                .frame(width: 40, height: 41)
                            
                            Image("google")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25, height: 25)
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
