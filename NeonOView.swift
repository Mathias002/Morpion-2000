import SwiftUI

// style symbolle "O"
struct NeonOView: View {
    var body: some View {
        Text("O")
            .font(.largeTitle)
            .frame(width: 80, height: 80)
            .font(Font.system(size: 100, weight: .bold, design: .default))
            .foregroundColor(Color.clear) // Texte transparent pour la couleur de base
            .background(
                LinearGradient(gradient: Gradient(colors: [Color.green, Color.yellow]), startPoint: .topLeading, endPoint: .bottomTrailing)
            ) // Dégradé de couleur pour l'effet de néon
            .mask(Text("O")
                .font(Font.system(size: 100, weight: .bold, design: .default))
            ) // Masquer avec la lettre "O" de la couleur de base
            .shadow(color: Color.green, radius: 10, x: 0, y: 0) // Ombre
    }
}
