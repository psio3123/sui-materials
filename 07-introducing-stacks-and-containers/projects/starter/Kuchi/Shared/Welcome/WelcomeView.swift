import SwiftUI

struct WelcomeView: View {
    
    @EnvironmentObject var userManager: UserManager
    @ObservedObject var challengesViewModel = ChallengesViewModel()
    @State var showPractice = false
    
    @ViewBuilder
    var body: some View {
      if showPractice {
        // 2
        PracticeView(
          challengeTest: $challengesViewModel.currentChallenge,
          userName: $userManager.profile.name
        )
      } else {
        // 3
        ZStack {
          WelcomeBackgroundImage()

          VStack {
            Text(verbatim: "Hi, \(userManager.profile.name)")

            WelcomeMessageView()

            // 4
            Button(action: {
              self.showPractice = true
            }, label: {
              HStack {
                Image(systemName: "play")
                Text(verbatim: "Start")
              }
            })
          }
        }
      }
    }
}

struct WelcomeView_Previews: PreviewProvider {
  static var previews: some View {
    WelcomeView()
      .environmentObject(UserManager())
  }
}
