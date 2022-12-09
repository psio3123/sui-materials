import SwiftUI

struct WelcomeView: View {
    var body: some View {
        ZStack {
            Image("welcome-background", bundle: nil)
                .resizable()
                .aspectRatio(1, contentMode: .fit)
                .saturation(0.5)
                .blur(radius: 3)
                .opacity(0.3)
            HStack {
                Image(systemName: "table")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .overlay(Circle().stroke(Color.gray, lineWidth: 1))
                    .background(Color(white: 0.9))
                    .clipShape(Circle())
                    .foregroundColor(.red)
                VStack(alignment: .leading) {
                    Text("**Welcome to**")
                        .font(.headline)
                    Text("**Kuchi**")
                        .font(.largeTitle)
                    Text("_awesome_ **SwiftUI Software Engineer**")
                    Label("Welcome", systemImage: "hand.wave")
                }
                .foregroundColor(.red)
                //.multilineTextAlignment(.leading)
                .lineLimit(1)
            }
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
