//
//  Models.swift
//  LeaDEMOexo
//
//  Fusion des deux versions du 15/09/2025
//

import SwiftUI

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

enum Filter: String, CaseIterable, Hashable {
    case interior = "Plantes d’intérieur"
    case aromatic = "Plantes aromatiques"
    case lowWater = "Faible arrosage"
    case fullSun = "Plein soleil"
    case airPurifier = "Plantes dépolluantes"
    case beginnerFriendly = "Débutant"
    case edible = "Plantes comestibles"
}

enum RepeatInterval: String, CaseIterable, Hashable {
    case none = "Aucune"
    case daily = "Tous les jours"
    case every2Days = "Tous les 2 jours"
    case weekly = "1 fois par semaine"
    case biweekly = "Toutes les 2 semaines"
    case every10Days = "Tous les 10 jours"
}

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
    var comments: [Comment]
}

struct Comment: Identifiable {
    var id = UUID()
    var commentText: String
    var date: String
    var author: Profile
}

struct Profile: Identifiable {
    var id = UUID()
    var username: String
    var profilePic: String
}

class Plant: Identifiable, ObservableObject, Hashable {
    var id = UUID()
    @Published var name: String
    @Published var imageName: String?
    @Published var soilType: SoilType
    @Published var watering: WateringFrequency
    @Published var sunlight: Sunlight
    @Published var isIndoor: Bool
    @Published var note: String

    init(
        name: String,
        imageName: String? = nil,
        soilType: SoilType,
        watering: WateringFrequency,
        sunlight: Sunlight,
        isIndoor: Bool,
        note: String
    ) {
        self.name = name
        self.imageName = imageName
        self.soilType = soilType
        self.watering = watering
        self.sunlight = sunlight
        self.isIndoor = isIndoor
        self.note = ""
    }

    static func == (lhs: Plant, rhs: Plant) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

class PlantTask: Identifiable, ObservableObject, Hashable {
    var id = UUID()
    @Published var name: String
    @Published var date: String
    @Published var isDone: Bool
    @Published var plantID: UUID
    @Published var repeatInterval: RepeatInterval

    init(
        name: String,
        date: String,
        isDone: Bool,
        plantID: UUID,
        repeatInterval: RepeatInterval = .none
    ) {
        self.name = name
        self.date = date
        self.isDone = isDone
        self.plantID = plantID
        self.repeatInterval = repeatInterval
    }

    static func == (lhs: PlantTask, rhs: PlantTask) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    func nextDate() -> Date? {
        guard let currentDate = taskDateFormatter.date(from: self.date) else { return nil }
        switch repeatInterval {
        case .daily:       return Calendar.current.date(byAdding: .day, value: 1,  to: currentDate)
        case .every2Days:  return Calendar.current.date(byAdding: .day, value: 2,  to: currentDate)
        case .weekly:      return Calendar.current.date(byAdding: .day, value: 7,  to: currentDate)
        case .biweekly:    return Calendar.current.date(byAdding: .day, value: 14, to: currentDate)
        case .every10Days: return Calendar.current.date(byAdding: .day, value: 10, to: currentDate)
        case .none:        return nil
        }
    }
}

class PlantListClass: ObservableObject {
    @Published var plantList: [Plant]
    
    init(listPlants: [Plant] = plantListInitVar) {
        self.plantList = listPlants
    }
    
    func removePlant(_ plant: Plant) {
        if let index = plantList.firstIndex(where: { $0.id == plant.id }) {
            plantList.remove(at: index)
        }
    }
}

class TaskListClass: ObservableObject {
    @Published var taskList: [PlantTask]
    
    init(listTasks: [PlantTask] = taskListInitVar) {
        self.taskList = listTasks
    }
    
    func removeTask(_ myTask: PlantTask) {
        if let index = taskList.firstIndex(where: { $0.id == myTask.id }) {
            taskList.remove(at: index)
        }
    }
    
    func pendingTasks(for date: Date) -> [PlantTask] {
        taskList.filter { $0.date == date.formatted(date: .numeric, time: .omitted) && !$0.isDone }
    }
    
    func doneTasks(for date: Date) -> [PlantTask] {
        taskList.filter { $0.date == date.formatted(date: .numeric, time: .omitted) && $0.isDone }
    }
    
}

class PostListClass: ObservableObject {
    @Published var postsList: [Post]

    init(listPosts: [Post] = posts) {
        self.postsList = listPosts
    }

    func addPost(_ newPost: Post) {
        postsList.insert(newPost, at: 0)
    }

    func addComment(to postId: UUID, comment: Comment) {
        if let index = postsList.firstIndex(where: { $0.id == postId }) {
            postsList[index].comments.append(comment)
        }
    }
}

// MARK: - Date formatter
let taskDateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "dd/MM/yyyy"
    return formatter
}()
