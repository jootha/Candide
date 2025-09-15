//
//  Models.swift
//  Candide
//
//  Created by apprenant84 on 15/09/2025.
//

import Foundation

//Enums de la structure de plantes
enum SoilType: String {
    case wellDrained = "Bien drainé"
    case sandy = "Sableux"
    case rich = "Riche et humide"
    case dry = "Sec"
    case calcareous = "Calcaire"
    case cactusMix = "Cactus"
}

enum WateringFrequency: String {
    case daily = "Tous les jours"
    case every2Days = "Tous les 2 jours"
    case weekly = "1 fois par semaine"
    case biweekly = "Toutes les 2 semaines"
    case every10Days = "Tous les 10 jours"
}

enum Sunlight: String {
    case fullSun = "Plein soleil"
    case indirectLight = "Lumière indirecte"
    case mediumLight = "Lumière moyenne"
    case shade = "Ombre"
}

//Structure de plantes
struct Plant : Identifiable {
    var id = UUID()
    var name: String
    var soilType: SoilType
    var watering: WateringFrequency
    var sunlight: Sunlight
    var isIndoor: Bool
    var plantTask: [Task]
}

//Structure de tâches
struct Task: Identifiable {
    var id = UUID()
    var name: String
    var date: String
    var isDone: Bool
}

//Structure de posts
struct Post: Identifiable {
    var id = UUID()
    var title: String
    var image: String
    var contentText: String
    var description: String
    var author: Profile
    var date: String
    var nbLike: Int
    var comments: Comment
}

//Structure de commentaires
struct Comment: Identifiable {
    var id = UUID()
    var commentText: String
    var date: String
    var author: Profile
}

//Structure de profil utilisateur
struct Profile: Identifiable {
    var id = UUID()
    var username: String
    var profilePic: String
}

struct Models: View {
    var body: some View {
        
    }
}
