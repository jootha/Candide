//
//  Models.swift
//  LeaDEMOexo
//
//  Created by apprenant95 on 15/09/2025.
//

import SwiftUI

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

//Enum de filtres de posts
enum Filter: String {
    case interior = "Plantes d’intérieur"
        case aromatic = "Plantes aromatiques"
        case lowWater = "Faible arrosage"
        case fullSun = "Plein soleil"
        case airPurifier = "Plantes dépolluantes"
        case beginnerFriendly = "Débutant"
        case edible = "Plantes comestibles"
}

//Structure de plantes
class Plant : Identifiable, ObservableObject {
    var id = UUID()
    @Published var name: String
    @Published var imageName: String?
    @Published var soilType: SoilType
    @Published var watering: WateringFrequency
    @Published var sunlight: Sunlight
    @Published var isIndoor: Bool
    @Published var plantTask: [PlantTask]
    
    init( name: String, imageName: String? = nil, soilType: SoilType, watering: WateringFrequency, sunlight: Sunlight, isIndoor: Bool, plantTask: [PlantTask]) {
        self.name = name
        self.imageName = imageName
        self.soilType = soilType
        self.watering = watering
        self.sunlight = sunlight
        self.isIndoor = isIndoor
        self.plantTask = plantTask
    }
}

//Structure de tâches
struct PlantTask: Identifiable {
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
    var filter: Filter
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

class PlantListClass: ObservableObject {
    @Published var plantList: [Plant]
    
    init(listPlants: [Plant] = plantListInitVar) {
        self.plantList = listPlants
    }
    
    func printPlantListNames() {
        print("Printing plant list: [")
        for plant in plantList {
            print("name : " + plant.name)
        }
        print("]")
    }
    func removePlant(_ plant : Plant){
        if let index = plantList.firstIndex(where: { $0.id == plant.id }) {
            plantList.remove(at: index)
        }
        print("plant removed : \(plant.name)")
    }
    
    
}
