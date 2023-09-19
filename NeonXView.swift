import SwiftUI

// style symbolle "X"
struct NeonXView: View {
    var body: some View {
        Text("X")
            .font(.largeTitle)
            .frame(width: 80, height: 80)
            .font(Font.system(size: 100, weight: .bold, design: .default))
            .foregroundColor(Color.clear) // Texte transparent pour la couleur de base
            .background(
                LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .topLeading, endPoint: .bottomTrailing)
            ) // Dégradé de couleur pour l'effet de néon
            .mask(Text("X")
                .font(Font.system(size: 100, weight: .bold, design: .default))
            ) // Masquer avec la lettre "X" de la couleur de base
            .shadow(color: Color.blue, radius: 10, x: 0, y: 0) // Ombre
    }
}
