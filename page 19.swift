import SwiftUI

struct Achievement: Identifiable {
    let id = UUID()
    let title: String
    let date: String
    let color: Color
}

struct page_19: View {
    @State private var showCalendar = false
    @State private var selectedDate = Date()
    
    let darkGreen = Color(red: 54/255, green: 79/255, blue: 35/255)
    let cream = Color(red: 255/255, green: 239/255, blue: 193/255)
    let bg = Color(red: 255/255, green: 239/255, blue: 193/255)


    let achievements: [Achievement] = [
        Achievement(title: "smile at a stranger", date: "3/1/25", color: Color(red: 220/255, green: 235/255, blue: 170/255)),
        Achievement(title: "compliment a stranger", date: "3/1/25", color: Color(red: 220/255, green: 235/255, blue: 170/255)),
        Achievement(title: "tell someone you appreciate them", date: "3/2/25", color: Color(red: 180/255, green: 170/255, blue: 170/255)),
        Achievement(title: "reach out to a distant friend", date: "3/3/25", color: Color(red: 255/255, green: 252/255, blue: 153/255)),
        Achievement(title: "call a distant family member", date: "3/4/25", color: Color(red: 255/255, green: 252/255, blue: 153/255)),
        Achievement(title: "give someone a small gift", date: "3/5/25", color: Color(red: 180/255, green: 200/255, blue: 220/255)),
        Achievement(title: "thank someone", date: "3/6/25", color: Color(red: 255/255, green: 165/255, blue: 120/255))
    ]
    
    var selectedWeekRange: String {
        let calendar = Calendar.current
        guard let weekStart = calendar.dateInterval(of: .weekOfYear, for: selectedDate)?.start else {
            return ""
        }
        let weekEnd = calendar.date(byAdding: .day, value: 6, to: weekStart)!
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d"
        return "\(formatter.string(from: weekStart)) - \(formatter.string(from: weekEnd))"
    }

    var body: some View {
        ZStack {
            bg.ignoresSafeArea()
            
            VStack(alignment: .center, spacing: 16) {
                // Header
                HStack {
                    VStack(alignment: .leading) {
                        Text("Weekly")
                        Text("Achievements")
                    }
                    .font(.system(size: 34, weight: .bold))
                    .foregroundColor(darkGreen)
                    
                    Spacer()
                    
                    VStack(alignment: .trailing) {
                        Button(action: {
                            withAnimation {
                                showCalendar.toggle()
                            }
                        }) {
                            Image(systemName: "calendar")
                                .font(.title2)
                                .foregroundColor(Color(red: 54/255, green: 79/255, blue: 35/255))
                        }
                        
                        Text(selectedWeekRange)
                            .font(.caption)
                    }
                    .foregroundColor(.black)
                }
                .padding(.horizontal)
                
                // Inline Calendar View
                if showCalendar {
                    VStack {
                        DatePicker("Select Week", selection: $selectedDate, displayedComponents: [.date])
                            .datePickerStyle(.graphical)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(20)
                            .shadow(radius: 10)
                            .padding(.horizontal)
                        
                        Button("Done") {
                            withAnimation {
                                showCalendar = false
                            }
                        }
                        .padding(.bottom)
                    }
                    .transition(.scale)
                }
                
                // Achievement Cards
                ScrollView {
                    VStack(spacing: 20) {
                        ForEach(achievements) { achievement in
                            HStack {
                                Image(systemName: "trophy.fill")
                                    .foregroundColor(.orange)
                                
                                Text(achievement.title)
                                    .font(.body)
                                    .foregroundColor(.black)
                                
                                Spacer()
                                
                                Text(achievement.date)
                                    .font(.caption)
                                    .foregroundColor(.black)
                            }
                            .padding(.horizontal, 20)
                            .frame(width: 350, height: 60)
                            .background(achievement.color)
                            .cornerRadius(20)
                            .shadow(color: .gray.opacity(0.3), radius: 4, x: 1, y: 2)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.top)
                }
                
                Spacer()
                HStack {
                    Spacer()
                    VStack {
                        Image(systemName: "location.fill")
                            .font(.system(size: 26))
                        Text("Map")
                            .font(.caption2)
                    }
                    .foregroundColor(Color(red: 54/255, green: 79/255, blue: 35/255))
                    
                    Spacer()
                    VStack {
                        Image(systemName: "rosette")
                            .font(.system(size: 26))
                        Text("Achieved")
                            .font(.caption2)
                    }
                    .foregroundColor(Color(red: 54/255, green: 79/255, blue: 35/255))
                    
                    Spacer()
                    VStack {
                        Image(systemName: "house")
                            .font(.system(size: 26))
                        Text("Home")
                            .font(.caption2)
                    }
                    .foregroundColor(Color(red: 54/255, green: 79/255, blue: 35/255))
                    
                    Spacer()
                    VStack {
                        Image(systemName: "hand.raised.fill")
                            .font(.system(size: 26))
                        Text("Acts")
                            .font(.caption2)
                    }
                    .foregroundColor(Color(red: 54/255, green: 79/255, blue: 35/255))
                    
                    Spacer()
                    VStack {
                        Image(systemName: "person.crop.circle")
                            .font(.system(size: 26))
                        Text("Profile")
                            .font(.caption2)
                    }
                    .foregroundColor(Color(red: 54/255, green: 79/255, blue: 35/255))
                    
                    Spacer()
                }
                .padding(.top, 6)
                .padding(.bottom, 12)
                .background(Color(red: 255/255, green: 239/255, blue: 193/255)) // cream
                .overlay(
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.gray.opacity(0.3)),
                    alignment: .top
                )
            }}
    }
}

#Preview {
    page_19()
}
