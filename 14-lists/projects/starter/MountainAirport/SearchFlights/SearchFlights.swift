import SwiftUI

struct SearchFlights: View {
    var flightData: [FlightInformation]
    @State private var date = Date()
    @State private var directionFilter: FlightDirection = .none
    @State private var city = ""
    
    var matchingFlights: [FlightInformation] {
        var matchingFlights = flightData
        
//        if directionFilter != .none {
//            matchingFlights = matchingFlights.filter {
//                $0.direction == directionFilter
//            }
//        }
        if !city.isEmpty {
          matchingFlights = matchingFlights.filter {
            $0.otherAirport.lowercased().contains(city.lowercased())
          }
        }
        
        return matchingFlights
    }
    
//    struct HierarchicalFlightRow: Identifiable {
//      var label: String
//      var flight: FlightInformation?
//      var children: [HierarchicalFlightRow]?
//      var id = UUID()
//    }
//
//    func hierarchicalFlightRowFromFlight(_ flight: FlightInformation)
//      -> HierarchicalFlightRow {
//      return HierarchicalFlightRow(
//        label: longDateFormatter.string(from: flight.localTime),
//        flight: flight,
//        children: nil
//      )
//    }
    
    var flightDates: [Date] {
      let allDates = matchingFlights.map { $0.localTime.dateOnly }
      let uniqueDates = Array(Set(allDates))
      return uniqueDates.sorted()
    }
    
    func flightsForDay(date: Date) -> [FlightInformation] {
      matchingFlights.filter {
        Calendar.current.isDate($0.localTime, inSameDayAs: date)
      }
    }
    
//    var hierarchicalFlights: [HierarchicalFlightRow] {
//      // 1
//      var rows: [HierarchicalFlightRow] = []
//
//      // 2
//      for date in flightDates {
//        // 3
//        let newRow = HierarchicalFlightRow(
//          label: longDateFormatter.string(from: date),
//          // 4
//          children: flightsForDay(date: date).map {
//            hierarchicalFlightRowFromFlight($0)
//          }
//        )
//        rows.append(newRow)
//      }
//      return rows
//    }
    
    var body: some View {
        ZStack {
            Image("background-view")
                .resizable()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            VStack {
                Picker(
                    selection: $directionFilter,
                    label: Text("Flight Direction")) {
                        Text("All").tag(FlightDirection.none)
                        Text("Arrivals").tag(FlightDirection.arrival)
                        Text("Departures").tag(FlightDirection.departure)
                    }
                    .background(Color.white)
                    .pickerStyle(SegmentedPickerStyle())
                // Insert Results
//                List(matchingFlights) { flight in
//                  SearchResultRow(flight: flight)
//                }
                // 1
                List {
                  // 2
                  ForEach(flightDates, id: \.hashValue) { date in
                    // 3
                    Section(
                      // 4
                      header: Text(longDateFormatter.string(from: date)),
                      // 5
                      footer:
                        HStack {
                          Spacer()
                          Text("Matching flights " +
                                "\(flightsForDay(date: date).count)")
                        }
                    ) {
                      // 6
                      ForEach(flightsForDay(date: date)) { flight in
                        SearchResultRow(flight: flight)
                      }
                    }
                  }
                  // 7
                }.listStyle(InsetGroupedListStyle())
            }
            .searchable(text: $city)
            .navigationBarTitle("Search Flights")
            .padding()
        }
    }
}

struct SearchFlights_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SearchFlights(flightData: FlightData.generateTestFlights(date: Date())
            )
        }
    }
}
