//  Created by Hooriya on 7/13/25.
//  (Adjust date and name)
import SwiftUI
struct WeeklyAchievementsView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var navigationPath: NavigationPathManager
    // Define custom colors based on the screenshot
    let lightBeige = Color(red: 0.96, green: 0.95, blue: 0.88) // #F5F3E1
    let darkGreen = Color(red: 54/255, green: 79/255, blue: 35/255) // #364F23
    let trophyOrange = Color(red: 0.94, green: 0.45, blue: 0.24) // #EF733D
    @State private var selectedTab: String = "Badge" // Default to Badge
    @State private var selectedDate = Date()
    @State private var showCalendar = false
    // Mock data for weekly achievements
    let weeklyAchievements: [Achievement] = [
        Achievement(text: "smile at a stranger", date: "3/1/25", color: Color(red: 228/255, green: 236/255, blue: 196/255)),
        Achievement(text: "compliment a stranger", date: "3/1/25", color: Color(red: 228/255, green: 236/255, blue: 196/255)),
        Achievement(text: "tell someone you appreciate them", date: "3/2/25", color: Color(red: 240/255, green: 153/255, blue: 110/255)),
        Achievement(text: "reach out to a distant friend", date: "3/3/25", color: Color(red: 255/255, green: 247/255, blue: 196/255)),
        Achievement(text: "call a distant family member", date: "3/4/25", color: Color(red: 255/255, green: 247/255, blue: 196/255)),
        Achievement(text: "give someone a small gift", date: "3/5/25", color: Color(red: 204/255, green: 193/255, blue: 230/255)),
        Achievement(text: "thank someone", date: "3/6/25", color: Color(red: 240/255, green: 153/255, blue: 110/255))
    ]
    var selectedWeekRange: String {
        let calendar = Calendar.current
        guard let weekStart = calendar.dateInterval(of: .weekOfYear, for: selectedDate)?.start else { return "" }
        let weekEnd = calendar.date(byAdding: .day, value: 6, to: weekStart) ?? selectedDate
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d"
        return "\(formatter.string(from: weekStart)) - \(formatter.string(from: weekEnd))"
    }
    var body: some View {
        ZStack {
            lightBeige.ignoresSafeArea()
            VStack(spacing: 20) {
                // MARK: - Top Bar (Back Button)
                HStack {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "arrow.backward")
                            .font(.title2)
                            .foregroundColor(darkGreen)
                            .padding(.leading, 20)
                    }
                    Spacer()
                }
                .padding(.top, 20)
                // MARK: - Weekly Achievements Title
                HStack {
                    Text("Weekly\nAchievements")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(darkGreen)
                        .padding(.leading, 20)
                    Spacer()
                    VStack(alignment: .trailing) {
                        Button(action: {
                            withAnimation {
                                showCalendar.toggle()
                            }
                        }) {
                            Image(systemName: "calendar")
                                .font(.title2)
                        }
                        Text(selectedWeekRange)
                            .font(.caption)
                    }
                    .foregroundColor(darkGreen)
                    .padding(.trailing, 20)
                }
                .padding(.bottom, 10)
                // MARK: - Inline Calendar Picker
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
                // MARK: - Achievements List
                ScrollView {
                    VStack(spacing: 15) {
                        ForEach(weeklyAchievements) { achievement in
                            AchievementCard(achievement: achievement)
                        }
                    }
                    .padding(.horizontal, 20)
                }
                Spacer()
                // MARK: - Bottom Navigation Bar
                VStack {
                    Divider()
                        .background(darkGreen.opacity(0.3))
                        .padding(.horizontal, -20)
                    HStack {
                        Spacer()
                        Button(action: {
                            navigationPath.path = NavigationPath()
                            navigationPath.path.append("LocationView")
                        }) {
                            VStack {
                                Image(systemName: "location.fill").font(.title2)
                                Text("Location").font(.caption2)
                            }
                        }
                        .foregroundColor(selectedTab == "Location" ? trophyOrange : darkGreen)
                        Spacer()
                        Button(action: {
                            selectedTab = "Badge"
                        }) {
                            VStack {
                                Image(systemName: "rosette").font(.title2)
                                Text("Badge").font(.caption2)
                            }
                        }
                        .foregroundColor(selectedTab == "Badge" ? trophyOrange : darkGreen)
                        Spacer()
                        Button(action: {
                            navigationPath.path = NavigationPath()
                            navigationPath.path.append("HomeView")
                        }) {
                            VStack {
                                Image(systemName: "house.fill").font(.title2)
                                Text("Home").font(.caption2)
                            }
                        }
                        .foregroundColor(selectedTab == "Home" ? trophyOrange : darkGreen)
                        Spacer()
                        Button(action: {
                            navigationPath.path = NavigationPath()
                            navigationPath.path.append("ActionView")
                        }) {
                            VStack {
                                Image(systemName: "hand.raised.fill").font(.title2)
                                Text("Action").font(.caption2)
                            }
                        }
                        .foregroundColor(selectedTab == "Action" ? trophyOrange : darkGreen)
                        Spacer()
                        Button(action: {
                            navigationPath.path = NavigationPath()
                            navigationPath.path.append("ProfileView")
                        }) {
                            VStack {
                                Image(systemName: "person.fill").font(.title2)
                                Text("Profile").font(.caption2)
                            }
                        }
                        .foregroundColor(selectedTab == "Profile" ? trophyOrange : darkGreen)
                        Spacer()
                    }
                    .padding(.vertical, 10)
                    .background(lightBeige)
                    .cornerRadius(20)
                    .shadow(radius: 5)
                }
                .padding(.bottom, 0)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}
// MARK: - Achievement Data Model
struct Achievement: Identifiable {
    let id = UUID()
    let text: String
    let date: String
    let color: Color
}
// MARK: - AchievementCard Sub-View
struct AchievementCard: View {
    let achievement: Achievement
    let darkGreen = Color(red: 54/255, green: 79/255, blue: 35/255)
    let trophyOrange = Color(red: 0.94, green: 0.45, blue: 0.24)
    var body: some View {
        HStack {
            Image(systemName: "trophy.fill")
                .foregroundColor(trophyOrange)
                .font(.title2)
                .padding(.leading, 10)
            Text(achievement.text)
                .font(.headline)
                .fontWeight(.medium)
                .foregroundColor(darkGreen)
            Spacer()
            Text(achievement.date)
                .font(.subheadline)
                .foregroundColor(darkGreen.opacity(0.8))
                .padding(.trailing, 10)
        }
        .padding(.vertical, 15)
        .background(achievement.color)
        .cornerRadius(15)
        .shadow(radius: 3)
        .frame(maxWidth: .infinity)
    }
}
// MARK: - Preview Provider
struct WeeklyAchievementsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            WeeklyAchievementsView()
                .environmentObject(NavigationPathManager())
        }
    }
}
