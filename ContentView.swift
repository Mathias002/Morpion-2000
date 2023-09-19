import SwiftUI

// Fonction qui renvoie true si une condition de victoire existe

func verifWin(tab: [[String]], tabVictoire: [String]) -> Bool {

    // Vérification des lignes
    for row in tab {
        if tabVictoire == row {
            return true
        }
    }

    // Vérification des colonnes
    for col in 0..<3 {
        let column = [tab[0][col], tab[1][col], tab[2][col]]
        if tabVictoire == column {
            return true
        }
    }

    // Vérification des diagonales
    let diagonal1 = [tab[0][0], tab[1][1], tab[2][2]]
    let diagonal2 = [tab[0][2], tab[1][1], tab[2][0]]

    if tabVictoire == diagonal1 || tabVictoire == diagonal2 {
        return true
    }

    return false
}

struct Morpion: View {
    // Variables représentant les conditions de victoire
    @State var isThreeXAligned: [String] = ["X", "X", "X"]
    @State var isThreeOAligned: [String] = ["O", "O", "O"]

    // Créer un tableau de trois tableaux de trois caractères vides
    @State var tabJeux: [[String]] = Array(repeating: Array(repeating: "", count: 3), count: 3)

    // Compteur qui s'incrémente à chaque fois qu'un clic est effectué
    // Sert à savoir quel joueur a joué
    @State var compteur: Int = 0

    var body: some View {
        ZStack {
            Color.black
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    // -- Titre -- //
                    Text("Morpion")
                        .font(.system(size: 36))
                    Text("2000")
                        .font(.largeTitle)
                        .frame(width: 120, height: 80)
                        .font(Font.system(size: 100, weight: .bold, design: .default))
                        .foregroundColor(Color.clear) // Texte transparent pour la couleur de base
                        .background(LinearGradient(gradient: Gradient(colors: [Color(hex: 0x3c1cdc), Color(hex: 0x54f0c8), Color(hex: 0x280b79)]), startPoint: .topLeading, endPoint: .bottomTrailing)) // Dégradé de couleur pour l'effet de néon
                        .mask(Text("2000")
                            .font(Font.system(size: 36, weight: .bold, design: .default))) // Masquer avec la lettre "X" de la couleur de base
                        .shadow(color: Color.blue, radius: 8, x: 0, y: 0) // Ombre
                    // -- Titre -- //
                }
                Spacer().frame(height: 80)
            }.foregroundColor(Color.white).padding(.bottom, 450)

            // Phrase en cas de fin de match
            VStack {
                if verifWin(tab: tabJeux, tabVictoire: isThreeXAligned) {
                    Text("Victoire pour le Joueur X")
                        .font(.system(size: 26))
                        .padding(.top, 50)
                } else if verifWin(tab: tabJeux, tabVictoire: isThreeOAligned) {
                    Text("Victoire pour le Joueur O")
                        .font(.system(size: 26))
                        .padding(.top, 50)
                } else if (!tabJeux.flatMap { $0 }.contains("")) {
                    Text("Match nul")
                        .font(.system(size: 26))
                        .padding(.top, 50)
                } else {
                    if (compteur % 2 == 0) {
                        Text("Au tour du joueur X")
                            .font(.system(size: 26))
                            .padding(.top, 50)
                    } else {
                        Text("Au tour du joueur O")
                            .font(.system(size: 26))
                            .padding(.top, 50)
                    }
                }
                Spacer().frame(height: 50)
            }.foregroundColor(Color.white).padding(.bottom, 400)

            // Grille de jeux + affichage des symboles
            VStack(spacing: 0) {
                ForEach(0..<3, id: \.self) { row in
                    HStack(spacing: 0) {
                        ForEach(0..<3, id: \.self) { col in
                            // Appel la fonction "verifWin" à chaque clic
                            Button(action: {
                                // Vérifie qu'aucune condition de victoire ne se trouve dans la grille de jeux
                                if (!(verifWin(tab: tabJeux, tabVictoire: isThreeXAligned) || verifWin(tab: tabJeux, tabVictoire: isThreeOAligned))) {
                                    // Vérifie si la case choisie par le joueur est vide, si oui, on divise le compteur par deux. Si le résultat est égal à zéro, on ajoute "X" sinon on ajoute "O"
                                    if tabJeux[row][col] == "" {
                                        if (compteur % 2 == 0) {
                                            tabJeux[row][col] = "X"
                                        } else {
                                            tabJeux[row][col] = "O"
                                        }
                                        compteur += 1
                                    }
                                }
                            }) {
                                // Vérifie le symbole ajouté et lui applique son style
                                if tabJeux[row][col] == "X" {
                                    NeonXView() // Utiliser la vue NeonXView pour "X"
                                } else if tabJeux[row][col] == "O" {
                                    NeonOView() // Utiliser la vue NeonOView pour "O"
                                } else {
                                    Text("")
                                        .frame(width: 80, height: 80)
                                }
                            }
                            // Ajoute une ligne verticale entre les boutons
                            if col < 2 {
                                Rectangle()
                                    .fill(Color.white)
                                    .frame(width: 2, height: 80)
                            }
                        }
                    }
                    // Ajoute une ligne horizontale entre les lignes de boutons
                    if row < 2 {
                        Rectangle()
                            .fill(Color.white)
                            .frame(width: 240, height: 2)
                    }
                }
            }

            VStack {
                // Vérifie si une condition de victoire existe ou si la grille est complète. Si oui, on affiche le bouton "Rejouer"
                if ((verifWin(tab: tabJeux, tabVictoire: isThreeXAligned) || verifWin(tab: tabJeux, tabVictoire: isThreeOAligned) || !tabJeux.flatMap { $0 }.contains(""))) {
                    Button(action: {
                        tabJeux = Array(repeating: Array(repeating: "", count: 3), count: 3)
                    }) {
                        NeonRejouerView()
                    }
                }
            }.foregroundColor(Color.white).padding(.top, 500)
        }.ignoresSafeArea()
    }
}


// Extension pour définir la couleur avec un code hexadécimal
extension Color {
    init(hex: Int, opacity: Double = 1.0) {
        let red = Double((hex & 0xff0000) >> 16) / 255.0
        let green = Double((hex & 0xff00) >> 8) / 255.0
        let blue = Double((hex & 0xff) >> 0) / 255.0
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
    }
}
