import SwiftUI

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
                    // Check if the new position collides with any house
                    if !collidesWithHouses(position: newPosition) {
                        playerPosition = newPosition
                    }
                }
        )
    }
    
    // Function to check if the player collides with any house
    func collidesWithHouses(position: CGPoint) -> Bool {
        let houseRectangles = [
            CGRect(x: 60, y: 270, width: 80, height: 80), // Bottom house rectangle
            CGRect(x: 260, y: 170, width: 80, height: 80), // Middle house rectangle
            CGRect(x: 210, y: 570, width: 80, height: 80) // Top house rectangle
        ]
        
        let playerRect = CGRect(origin: position, size: CGSize(width: 40, height: 40)) // Adjust size as needed
        for houseRect in houseRectangles {
            if playerRect.intersects(houseRect) {
                return true // Collision detected
            }
        }
        return false // No collision detected
    }
}

#if DEBUG
struct GameSceneView_Previews: PreviewProvider {
    static var previews: some View {
        GameSceneView()
    }
}
#endif
