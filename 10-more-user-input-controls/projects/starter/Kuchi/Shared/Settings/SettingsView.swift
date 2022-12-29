import SwiftUI

struct SettingsView: View {
    
    //@State var numberOfQuestions = 6
    @AppStorage("numberOfQuestions") var numberOfQuestions = 6
    @State var learningEnabled: Bool = true
    //@State var dailyReminderEnabled = false
    @AppStorage("dailyReminderEnabled") var dailyReminderEnabled = false
    @State var dailyReminderTime = Date(timeIntervalSince1970: 0)
    @AppStorage("dailyReminderTime") var dailyReminderTimeShadow: Double = 0
    @State var cardBackgroundColor: Color = .red
    //@State var appearance: Appearance = .automatic
    @AppStorage("appearance") var appearance: Appearance = .automatic
    
    var body: some View {
        List {
            Text("Settings")
                .font(.largeTitle)
                .padding(.bottom, 8)
            Section(header: Text("Appearance")) {
                VStack(alignment: .leading) {
                    Picker("", selection: $appearance) {
                        ForEach(Appearance.allCases) { appearance in
                          Text(appearance.name).tag(appearance)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    ColorPicker(
                        "Card Background Color",
                        selection: $cardBackgroundColor
                    )
                }
            }
            
            Section(header: Text("Game")) {
                VStack(alignment: .leading) {
                    Stepper(
                        "Number of Questions: \(numberOfQuestions)",
                        value: $numberOfQuestions,
                        in: 3 ... 20
                    )
                    Text("Any change will affect the next game")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                    Toggle("Learning Enabled", isOn: $learningEnabled)
                }
            }
            
            Section(header: Text("Notifications")) {
                HStack {
                    Toggle("Daily Reminder", isOn: $dailyReminderEnabled)
                        .onChange(of: dailyReminderTime,
                                  perform: { newValue in
                          dailyReminderTimeShadow = newValue.timeIntervalSince1970
                          configureNotification()
                        })
                        .onAppear {
                          dailyReminderTime = Date(timeIntervalSince1970: dailyReminderTimeShadow)
                        }
                    DatePicker(
                        "",
                        selection: $dailyReminderTime,
                        displayedComponents: .hourAndMinute
                    )
                    .onChange(
                        of: dailyReminderTime,
                        perform: { _ in configureNotification() }
                    )
                    .disabled(dailyReminderEnabled == false)
                }
            }
        }
    }
    func configureNotification() {
        if dailyReminderEnabled {
            // 1
            LocalNotifications.shared.createReminder(
                time: dailyReminderTime)
        } else {
            // 2
            LocalNotifications.shared.deleteReminder()
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
