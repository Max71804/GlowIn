import SwiftUI

// MARK: - Helpers

extension TimeInterval {
    var asHMS: String {
        let hours = Int(self) / 3600
        let minutes = (Int(self) % 3600) / 60
        let seconds = Int(self) % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
}

extension Color {
    init(hex: Int, opacity: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: opacity
        )
    }
}

// MARK: - Profile Picture View

struct Profilepic: View {
    let imageName: String
    let borderColor: Color
    let borderWidth: CGFloat
    let size: CGFloat

    var body: some View {
        Image(imageName)
            .resizable()
            .frame(width: size, height: size)
            .clipShape(Circle())
            .overlay(Circle().stroke(borderColor, lineWidth: borderWidth))
    }
}

// MARK: - Daily Quest View

struct DailyQuest: View {
    let quest: String
    let streak: Int

    @State private var timeRemaining: TimeInterval = 83440
    @State private var progress: Double = 0
    @State private var isCompleted: Bool = false
    @State private var timer: Timer?

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(hex: 0xE77E42))
                .frame(width: 380, height: 240)
                .shadow(color: .black, radius: 1, x: 0, y: 3)

            VStack(alignment: .leading, spacing: 14) {
                HStack {
                    Image("Trophy")
                        .resizable()
                        .frame(width: 28, height: 28)

                    Text("Daily Quest:")
                        .font(.title3)
                        .foregroundStyle(Color(hex: 0x364F23))

                    Spacer()

                    VStack(alignment: .trailing) {
                        Text("time left:")
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.8))

                        Text(timeRemaining.asHMS)
                            .font(.subheadline)
                            .foregroundColor(.white)
                    }
                }

                Text(quest)
                    .foregroundStyle(.white)
                    .font(.title2)
                    .frame(maxWidth: .infinity, alignment: .center)

                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.white.opacity(0.3))
                        .frame(width: 260, height: 20)

                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(hex: 0x364F23))
                        .frame(width: CGFloat(progress * 260), height: 20)
                        .animation(.easeInOut(duration: 0.3), value: progress)
                }
                .frame(maxWidth: .infinity, alignment: .center)

                HStack(spacing: 10) {
                    Text("\(Int(progress * 100))%")
                        .foregroundColor(.white)
                        .font(.footnote)

                    Spacer()

                    Button(action: {
                        isCompleted.toggle()
                        progress = isCompleted ? 1 : 0
                        isCompleted ? stopTimer() : startTimer()
                    }) {
                        ZStack {
                            Circle()
                                .strokeBorder(Color.white, lineWidth: 2)
                                .background(
                                    Circle()
                                        .fill(isCompleted ? Color.yellow : Color.clear)
                                )
                                .frame(width: 36, height: 36)

                            if isCompleted {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.white)
                                    .font(.system(size: 18, weight: .bold))
                            }
                        }
                    }
                    .buttonStyle(.plain)
                    .animation(.easeInOut(duration: 0.2), value: isCompleted)

                    Spacer()

                    Text("🔥 \(streak)")
                        .font(.title3)
                        .foregroundColor(.white)
                }
                .padding(.horizontal, 20)
            }
            .padding(20)
        }
        .onAppear { startTimer() }
        .onDisappear { stopTimer() }
    }

    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if timeRemaining > 0 && !isCompleted {
                timeRemaining -= 1
            } else {
                stopTimer()
            }
        }
    }

    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}

// MARK: - Home View



struct HomeView: View {
    @State private var selectedTab: String = "Profile"
    @EnvironmentObject var navigationPath: NavigationPathManager
    @Environment(\.dismiss) var dismiss

    @State private var text = ""
    @State private var dailyquote = "If you can dream it, you can do it. - Walt Disney"

    var body: some View {
        ZStack(alignment: .bottom) {
            Color(hex: 0xFCF1C6)
                .ignoresSafeArea()

            ScrollView {
                VStack(spacing: 20) {
                    // Welcome Section
                    HStack {
                        VStack(alignment: .leading) {
                            Text("***welcome back,***")
                                .font(.body)
                                .foregroundStyle(Color(hex: 0x364F23))
                            Text("**[Insert Name]**")
                                .font(.title2)
                                .foregroundStyle(Color(hex: 0xFF5D00))
                        }

                        Spacer()

                        Profilepic(imageName: "Pfp", borderColor: .orange, borderWidth: 1, size: 65)
                    }
                    .padding(.horizontal)

                    // Daily Quest
                    DailyQuest(quest: "Smile at a Stranger", streak: 6)

                    // Mood Tracker
                   
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color(hex: 0xF7CE9B))
                            .frame(width: 360, height: 160)
                            .shadow(color: .black, radius: 1, x: 0, y: 3)

                        VStack(spacing: 12) {
                            Text("**Mood Tracker**")
                                .font(.title2)
                                .foregroundStyle(Color(hex: 0x364F23))

                            HStack(spacing: 5) {
                                ForEach(["happy", "good", "okay", "notGood", "sad"], id: \.self) { mood in
                                    Button(action: {
                                        navigationPath.path.append("Moodtracker")
                                    }) {
                                        Image(mood)
                                            .resizable()
                                            .frame(width: 65, height: 100)
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                        }
                    }


                           

                    // Quote + Journal Side by Side
                    HStack(spacing: 20) {
                        // Today's Quote
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color(hex: 0xDCDB95))
                                .frame(height: 180)
                                .shadow(color: .black, radius: 1, x: 0, y: 3)

                            VStack {
                                Text("**Today's Quote**")
                                    .font(.title3)
                                    .foregroundStyle(Color(hex: 0x364F23))
                                    .padding(.top, 10)

                                Text(dailyquote)
                                    .multilineTextAlignment(.center)
                                    .frame(width: 140, height: 80)
                                    .foregroundStyle(Color(hex: 0x364F23))
                            }
                        }
                        .frame(maxWidth: .infinity)

                        // Journal
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color(hex: 0xF9DBA4))
                                .frame(height: 180)
                                .shadow(color: .black, radius: 1, x: 0, y: 3)

                            VStack(spacing: 10) {
                                Text("**Journal**")
                                    .font(.title2)
                                    .foregroundStyle(Color(hex: 0x364F23))

                                TextField("Type Here", text: $text)
                                    .font(.body)
                                    .padding()
                                    .frame(width: 140, height: 80)
                                    .background(Color.white.opacity(0.2))
                                    .cornerRadius(10)
                                    .foregroundColor(Color(hex: 0x364F23))
                            }
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .padding(.horizontal)


                    Spacer().frame(height: 100) // buffer for keyboard
                }
                .padding(.top, 40)
                .padding(.bottom, 120) // enough space above nav bar
            }

            // Bottom Nav Bar
            VStack {
                Divider()
                    .background(Color(red: 0.25, green: 0.35, blue: 0.20).opacity(0.4))
                    .padding(.horizontal, -20)

                HStack {
                    ForEach(["Location", "Badge", "Home", "Action", "Profile"], id: \.self) { tab in
                        Spacer()
                        Button {
                            selectedTab = tab
                            navigationPath.path = NavigationPath()
                            if tab != "Profile" {
                                navigationPath.path.append("\(tab)View")
                            }
                        } label: {
                            VStack {
                                Image(systemName: icon(for: tab))
                                    .font(.title2)
                                Text(tab)
                                    .font(.caption2)
                            }
                        }
                        .foregroundColor(selectedTab == tab ? Color(red: 0.94, green: 0.45, blue: 0.24) : Color(red: 0.25, green: 0.35, blue: 0.20))
                        Spacer()
                    }
                }
                .padding(.vertical, 10)
                .background(Color(red: 0.96, green: 0.95, blue: 0.88))
                .cornerRadius(20)
                .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: -2)
                .padding(.horizontal)
            }
        }
        .ignoresSafeArea(.keyboard)
    }

    func icon(for tab: String) -> String {
        switch tab {
            case "Location": return "location.fill"
            case "Badge": return "rosette"
            case "Home": return "house.fill"
            case "Action": return "hand.raised.fill"
            case "Profile": return "person.fill"
            default: return "questionmark"
        }
    }
}


// MARK: - Preview

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            HomeView()
                .environmentObject(NavigationPathManager())
        }
    }
}

