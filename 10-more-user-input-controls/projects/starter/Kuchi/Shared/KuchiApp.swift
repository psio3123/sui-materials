import SwiftUI

@main
struct KuchiApp: App {
    
  let userManager = UserManager()
  @AppStorage("appearance") var appearance: Appearance = .automatic
    
  init() {
    userManager.load()
  }

  var body: some Scene {
    WindowGroup {
        StarterView()
          .environmentObject(userManager)
          .environmentObject(ChallengesViewModel())
          .preferredColorScheme(appearance.getColorScheme())
    }
  }
}

struct KuchiApp_Previews: PreviewProvider {
  static let userManager = UserManager(name: "Ray")
  static var previews: some View {
    StarterView()
      .environmentObject(userManager)
  }
}
