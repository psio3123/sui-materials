import SwiftUI

@available(macOS 12.0, *)
struct StarterView: View {
  @EnvironmentObject var userViewModel: UserManager
  
  @ViewBuilder
  var body: some View {
    if userViewModel.isRegistered {
      WelcomeView()
    } else {
      RegisterView()
    }
  }
}

@available(macOS 12.0, *)
struct StarterView_Previews: PreviewProvider {
  static var previews: some View {
    StarterView()
      .environmentObject(UserManager())
  }
}
