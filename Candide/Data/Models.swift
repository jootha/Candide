//
//  Models.swift
//  LeaDEMOexo
//
//  Created by apprenant95 on 15/09/2025.
//

import SwiftUI

//Enums de la structure de plantes
enum SoilType: String, CaseIterable, Hashable  {
    case wellDrained = "Bien drainé"
    case sandy = "Sableux"
    case rich = "Riche et humide"
    case dry = "Sec"
    case calcareous = "Calcaire"
    case cactusMix = "Cactus"
}

enum WateringFrequency: String, CaseIterable, Hashable {
    case daily = "Tous les jours"
    case every2Days = "Tous les 2 jours"
    case weekly = "1 fois par semaine"
    case biweekly = "Toutes les 2 semaines"
    case every10Days = "Tous les 10 jours"
}

enum Sunlight: String, CaseIterable, Hashable {
    case fullSun = "Plein soleil"
    case indirectLight = "Lumière indirecte"
    case mediumLight = "Lumière moyenne"
    case shade = "Ombre"
}

//Enum de filtres de posts
enum Filter: String, CaseIterable, Hashable {
    case interior = "Plantes d’intérieur"
    case aromatic = "Plantes aromatiques"
    case lowWater = "Faible arrosage"
    case fullSun = "Plein soleil"
    case airPurifier = "Plantes dépolluantes"
    case beginnerFriendly = "Débutant"
    case edible = "Plantes comestibles"
}

//  Structure de posts
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

//  Structure de commentaires
struct Comment: Identifiable {
    var id = UUID()
    var commentText: String
    var date: String
    var author: Profile
}

//  Structure de profil utilisateur
struct Profile: Identifiable {
    var id = UUID()
    var username: String
    var profilePic: String
}

//  Classe de plantes
class Plant: Identifiable, ObservableObject, Hashable {
    var id = UUID()
    @Published var name: String
    @Published var imageName: String?
    @Published var soilType: SoilType
    @Published var watering: WateringFrequency
    @Published var sunlight: Sunlight
    @Published var isIndoor: Bool

    init(
        name: String,
        imageName: String? = nil,
        soilType: SoilType,
        watering: WateringFrequency,
        sunlight: Sunlight,
        isIndoor: Bool
    ) {
        self.name = name
        self.imageName = imageName
        self.soilType = soilType
        self.watering = watering
        self.sunlight = sunlight
        self.isIndoor = isIndoor
    }

    static func == (lhs: Plant, rhs: Plant) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

//  Classe de tâches
class PlantTask: Identifiable, ObservableObject, Hashable {
    var id = UUID()
    @Published var name: String
    @Published var date: String
    @Published var isDone: Bool
    @Published var plantID: UUID

    init(
        name: String,
        date: String,
        isDone: Bool,
        plantID: UUID
    ) {
        self.name = name
        self.date = date
        self.isDone = isDone
        self.plantID = plantID
    }

    static func == (lhs: PlantTask, rhs: PlantTask) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
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

class TaskListClass: ObservableObject {
    @Published var taskList: [PlantTask]

    init(listTasks: [PlantTask] = taskListInitVar) {
        self.taskList = listTasks
    }

    func printTaskListNames() {
        print("Printing task list: [")
        for myTask in taskList {
            print("name : " + myTask.name)
        }
        print("]")
    }

    func removeTask(_ myTask: PlantTask) {
        if let index = taskList.firstIndex(where: { $0.id == myTask.id }) {
            taskList.remove(at: index)
        }
        print("task removed : \(myTask.name)")
    }
}
