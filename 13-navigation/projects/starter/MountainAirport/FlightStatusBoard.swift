import SwiftUI

struct FlightList: View {
    var flights: [FlightInformation]
    
    var body: some View {
        List(flights, id: \.id) { flight in
            NavigationLink(
                flight.statusBoardName,
                destination: FlightDetails(flight: flight)
            )
        }
    }
}

struct FlightStatusBoard: View {
    
    @State private var hidePast = false
    @AppStorage("FlightStatusCurrentTab") var selectedTab = 1
    var flights: [FlightInformation]
    var shownFlights: [FlightInformation] {
        hidePast ?
        flights.filter { $0.localTime >= Date() } :
        flights
    }
    
    var body: some View {
        // 1
        TabView(selection: $selectedTab) {
          // 2
          FlightList(
            flights: shownFlights.filter { $0.direction == .arrival }
          )
          // 3
          .tabItem {
            // 4
            Image("descending-airplane")
              .resizable()
            Text("Arrivals")
          }
          .tag(0)
          FlightList(
            flights: shownFlights
          )
          .tabItem {
            Image(systemName: "airplane")
              .resizable()
            Text("All")
          }.tag(1)
          FlightList(
            flights: shownFlights.filter { $0.direction == .departure }
          )
          .tabItem {
            Image("ascending-airplane")
            Text("Departures")
          }.tag(2)
        }
        .navigationTitle("Flight Status")
        .navigationBarItems(
          trailing: Toggle("Hide Past", isOn: $hidePast)
        )
    }
}

struct FlightStatusBoard_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            FlightStatusBoard(
                flights: FlightData.generateTestFlights(date: Date())
            )
        }
    }
}
