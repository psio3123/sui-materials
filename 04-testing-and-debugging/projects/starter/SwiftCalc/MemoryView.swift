import SwiftUI

struct MemoryView: View {
    @Binding var memory: Double
    var geometry: GeometryProxy
    
    var body: some View {
        
        let memorySwipe = DragGesture(minimumDistance: 20)
            .onEnded { _ in
                memory = 0.0
            }
        
        HStack {
            Spacer()
            Text("\(memory)")
                .accessibility(identifier: "memoryDisplay")
                .padding(.horizontal, 5)
                .frame(
                    width: geometry.size.width * 0.85,
                    alignment: .trailing
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(lineWidth: 2)
                        .foregroundColor(Color.gray)
                )
            // Add gesture here
            .gesture(memorySwipe)
            Text("M")
        }.padding(.bottom).padding(.horizontal, 5)
    }
}

struct MemoryView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geometry in
            MemoryView(memory: .constant(3.2), geometry: geometry)
        }
    }
}
