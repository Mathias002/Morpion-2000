import SwiftUI

// style Bouton "Rejouer"
struct NeonRejouerView: View {
    var body: some View {
        Text("Rejouer")
            .font(.largeTitle)
            .frame(width: 360, height: 160)
            .font(Font.system(size: 100, weight: .bold, design: .default))
            .foregroundColor(Color.clear) // Texte transparent pour la couleur de base
            .background(LinearGradient(gradient: Gradient(colors: [Color(hex: 0x3c1cdc), Color(hex: 0x54f0c8), Color(hex: 0x280b79)]), startPoint: .topLeading, endPoint: .bottomTrailing)) // Dégradé de couleur pour l'effet de néon
            .mask(Text("Rejouer")
            .font(Font.system(size: 75, weight: .bold, design: .default))) // Masquer avec la lettre "O" de la couleur de base
            .shadow(color: Color.blue, radius: 5, x: 0, y: 0) // Ombre
    }
}
