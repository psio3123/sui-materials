import SwiftUI

@available(macOS 12.0, *)
@main
struct KuchiApp: App {
  let userManager = UserManager()
  
  init() {
    userManager.load()
  }
  
  var body: some Scene {
    WindowGroup {
      StarterView()
        .environmentObject(userManager)
        .environmentObject(ChallengesViewModel())
    }
  }
}

@available(macOS 12.0, *)
struct KuchiApp_Previews: PreviewProvider {
  static let userManager = UserManager(name: "Ray")
  static var previews: some View {
    StarterView()
      .environmentObject(userManager)
  }
}
