import SwiftUI

struct RegisterView: View {
        
    @State var name: String = ""
    @FocusState var nameFieldFocused: Bool
    
    @EnvironmentObject var userManager: UserManager
    
    var body: some View {
        VStack {
            Spacer()
            WelcomeMessageView()
            TextField("Type your name...", text: $userManager.profile.name)
                .onSubmit(registerUser)
                .bordered()
                .padding()
                .submitLabel(.done)
                .focused($nameFieldFocused)                
//            Button(action: registerUser) {
//              Text("OK")
//            }
//            .buttonStyle(.borderedProminent)
            HStack {
              // 1
              Spacer()
              // 2
              Text("\(userManager.profile.name.count)")
                .font(.caption)
                // 3
                .foregroundColor(
                  userManager.isUserNameValid() ? .green : .red)
                .padding(.trailing)
            }
            // 4
            .padding(.bottom)
            HStack {
              // 1
              Spacer()
              // 2
              Toggle(isOn: $userManager.settings.rememberUser) {
                // 3
                Text("Remember me")
                  // 4
                  .font(.subheadline)
                  .foregroundColor(.gray)
              }
              .padding(.trailing)
                // 5
                .fixedSize()
            }
            Button(action: self.registerUser) {
              // 1
              HStack {
                // 2
                Image(systemName: "checkmark")
                  // 3
                  .resizable()
                  .frame(width: 16, height: 16, alignment: .center)
                Text("OK")
                  // 4
                  .font(.body)
                  .bold()
              }
              .disabled(!userManager.isUserNameValid())
            }
              // 5
              .bordered()
            Spacer()
        }
        .background(WelcomeBackgroundImage())
    }
}

extension RegisterView {
  func registerUser() {
      func registerUser() {
          nameFieldFocused = false
          // 1
          if userManager.settings.rememberUser {
            // 2
            userManager.persistProfile()
          } else {
            // 3
            userManager.clear()
          }
          // 4
          userManager.persistSettings()
          userManager.setRegistered()
      }
  }
}


struct RegisterView_Previews: PreviewProvider {
    static let user = UserManager(name: "Harald")
    static var previews: some View {
        RegisterView()
            .environmentObject(user)
    }
}
