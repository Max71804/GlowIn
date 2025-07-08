//
//  moodTracker.swift
//  GlowIn
//
//  Created by Hooriya Kazmi on 7/8/25.
//
import SwiftUI

struct moodTracker: View {
    var body: some View {
        let cream = Color(red: 255/255, green: 239/255, blue: 193/255)

        ZStack {
            cream
                .ignoresSafeArea()

            VStack {
                HStack {
                    Button(action: {
                        print("Sad face tapped")
                    }) {
                        VStack {
                            Image("sad")
                                .resizable()
                                .frame(width: 120, height: 200)
                                .padding(.bottom, -50)
                            Text("sad")
                                .font(.headline)
                                .foregroundColor(.black)
                        }
                        .padding(.trailing, 20)
                    }

                    Button(action: {
                        print("Not good face tapped")
                    }) {
                        VStack {
                            Image("notGood")
                                .resizable()
                                .frame(width: 100, height: 140)
                                .padding(.bottom, -40)
                            Text("not good")
                                .font(.headline)
                                .foregroundColor(.black)
                               
                        }
                       
                    }
                }

                HStack {
                    Button(action: {
                        print("Okay face tapped")
                    }) {
                        VStack {
                            Image("okay")
                                .resizable()
                                .frame(width: 140, height: 150)
                                .padding(.bottom, -40)
                            Text("okay")
                                .font(.headline)
                                .foregroundColor(.black)
                        }
                        .padding()
                    }

                    Button(action: {
                        print("Good face tapped")
                    }) {
                        VStack {
                            Image("good")
                                .resizable()
                                .frame(width: 120, height: 140)
                                .padding(.bottom, -40)
                            Text("good")
                                .font(.headline)
                                .foregroundColor(.black)
                        }
                        .padding()
                        
                    }
                }

                Button(action: {
                    print("Happy face tapped")
                }) {
                    VStack {
                        Image("happy")
                            .resizable()
                            .frame(width: 120, height: 170)
                            .padding(.bottom, -40)
                        Text("happy")
                            .font(.headline)
                            .foregroundColor(.black)
                    }
                }

                Text("How are you feeling \ntoday?")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color(red: 54/255, green: 79/255, blue: 35/255))
                    .padding(.top, 50)
                    .multilineTextAlignment(.center)
                Text("select an emoji that most closely aligns\nwith your mood ")
                    .font(.caption)
                    .foregroundColor(Color(red: 255/255, green: 93/255, blue: 0/255))
                    .padding(.bottom, 50)
                    .multilineTextAlignment(.center)
              
                Button(action: {
                    print("Done button tapped")
                }) {
                    Text("Done")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 5)
                        .background(Color(red: 54/255, green: 79/255, blue: 35/255))
                        .cornerRadius(12)
                }

                    
            }
        }
    }
}

#Preview {
    moodTracker()
}
