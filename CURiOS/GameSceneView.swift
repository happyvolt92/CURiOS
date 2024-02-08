import SwiftUI

struct GameSceneView: View {
    @State private var playerPosition = CGPoint(x: 80, y: 750) // Initial position of the player
    
    var body: some View {
        ZStack {
            Rectangle() // Black background
                .fill(Color.black)
                .edgesIgnoringSafeArea(.all)
            
            Rectangle() // Placeholder for player sprite
                .fill(Color.blue)
                .frame(width: 40, height: 40) // Adjust size as needed
                .position(playerPosition)
            
            // Rectangles representing houses
            Rectangle()
                .fill(Color.red)
                .frame(width: 80, height: 80) // Adjust size as needed
                .position(CGPoint(x: 100, y: 300)) // Bottom house position
            
            Rectangle()
                .fill(Color.green)
                .frame(width: 80, height: 80) // Adjust size as needed
                .position(CGPoint(x: 300, y: 200)) // Middle house position
            
            Rectangle()
                .fill(Color.yellow)
                .frame(width: 80, height: 80) // Adjust size as needed
                .position(CGPoint(x: 250, y: 600)) // Top house position
        }
        .gesture(
            DragGesture()
                .onChanged { value in
                    let newPosition = value.location
                    // We will still use collision detection with these rectangles
                    if !collidesWithHouses(position: newPosition) {
                        playerPosition = newPosition
                    }
                }
        )
    }
    
    func collidesWithHouses(position: CGPoint) -> Bool {
        let houseRectangles = [
            CGRect(x: 50, y: 250, width: 80, height: 80), // Bottom house rectangle
            CGRect(x: 250, y: 150, width: 80, height: 80), // Middle house rectangle
            CGRect(x: 450, y: 50, width: 80, height: 80) // Top house rectangle
        ]
        
        let playerRect = CGRect(origin: position, size: CGSize(width: 50, height: 50)) // Adjust size as needed
        for houseRect in houseRectangles {
            if playerRect.intersects(houseRect) {
                return true
            }
        }
        return false
    }
}

#if DEBUG
struct GameSceneView_Previews: PreviewProvider {
    static var previews: some View {
        GameSceneView()
    }
}
#endif
