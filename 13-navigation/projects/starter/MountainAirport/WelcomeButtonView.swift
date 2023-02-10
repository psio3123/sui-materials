import SwiftUI

struct WelcomeButtonView: View {
  var title: String
  var subTitle: String

  var body: some View {
    VStack(alignment: .leading) {
      Text(title)
        .font(.title)
        .foregroundColor(.white)
      Text(subTitle)
        .font(.subheadline)
        .foregroundColor(.white)
    }.padding()
    // 1
    .frame(maxWidth: .infinity, alignment: .leading)
    // 2
    .background(
      Image("link-pattern")
        .resizable()
        .clipped()
    )
  }
}

struct WelcomeButtonView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeButtonView(
            title: "Flight Status",
            subTitle: "Departure and Arrival Information" )
    }
}
