import SwiftUI

struct WelcomeView: View {
  @StateObject var flightInfo = FlightData()
  @State var showNextFlight = false
  @StateObject var lastFlightInfo = FlightNavigationInfo()
  
  var body: some View {
      // 1
      NavigationView {

        ZStack(alignment: .topLeading) {
          // 2
          Image("welcome-background")
            .resizable()
            .frame(height: 250)
          if
            let id = lastFlightInfo.lastFlightId,
            let lastFlight = flightInfo.getFlightById(id) {
            NavigationLink(
              destination: FlightDetails(flight: lastFlight),
              isActive: $showNextFlight
            ) { }
          }
          VStack(alignment: .leading) {
            // 3
            NavigationLink(
              // 4
              destination: FlightStatusBoard(
                flights: flightInfo.getDaysFlights(Date())
              )
            ) {
              // 5
              WelcomeButtonView(
                title: "Flight Status",
                subTitle: "Departure and arrival information"
              )
            }
//            Button(action: {
//              showNextFlight = true
//            }) {
//              WelcomeButtonView(
//                title: "First Flight",
//                subTitle: "Detail for First Flight of the Day"
//              )
//            }
            if
              let id = lastFlightInfo.lastFlightId,
              let lastFlight = flightInfo.getFlightById(id) {
              Button(action: {
                // 2
                showNextFlight = true
              }) {
                WelcomeButtonView(
                // 3
                  title: "Last Flight \(lastFlight.flightName)",
                  subTitle: "Show Next Flight Departing or Arriving at Airport"
                )
              }
            }
            Spacer()
          }.font(.title)
            .foregroundColor(.white)
            .padding()
          // 6
        }.navigationBarTitle("Mountain Airport")
        // End Navigation View
      }
      .environmentObject(lastFlightInfo)
      .navigationViewStyle(StackNavigationViewStyle())
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    WelcomeView()
  }
}
