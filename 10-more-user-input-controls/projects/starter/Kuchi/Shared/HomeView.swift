import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var userManager: UserManager
    @EnvironmentObject var challengesViewModel: ChallengesViewModel
    @State var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            PracticeView(
                challengeTest: $challengesViewModel.currentChallenge,
                userName: $userManager.profile.name,
                numberOfAnswered: .constant(challengesViewModel.numberOfAnswered)
            )
            .tabItem({
                VStack {
                    Image(systemName: "rectangle.dock")
                    Text("Challenge")
                }
            })
            .tag(1)
            SettingsView()
                .tabItem({
                    VStack {
                        Image(systemName: "gear")
                        Text("Settings")
                    }
                })
                .tag(2)
        }
        .accentColor(.blue)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
          .environmentObject(UserManager())
          .environmentObject(ChallengesViewModel())
    }
}
