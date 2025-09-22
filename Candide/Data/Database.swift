//
//  Database.swift
//  LeaDEMOexo
//
//  Created by apprenant95 on 15/09/2025.
//

import SwiftUI

// Liste des plantes
var plantListInitVar: [Plant] = [
    Plant(
        name: "Lavande",
        imageName: "lavande",
        soilType: .calcareous,
        watering: .every10Days,
        sunlight: .fullSun,
        isIndoor: false
    ),
    Plant(
        name: "Tomate",
        soilType: .rich,
        watering: .every2Days,
        sunlight: .fullSun,
        isIndoor: false
    ),
    Plant(
        name: "Aloe Vera",
        imageName: "aloevera",
        soilType: .cactusMix,
        watering: .biweekly,
        sunlight: .indirectLight,
        isIndoor: true
    ),
    Plant(
        name: "Ficus",
        soilType: .wellDrained,
        watering: .weekly,
        sunlight: .indirectLight,
        isIndoor: true
    ),
    Plant(
        name: "Basilic",
        imageName: "basilic",
        soilType: .rich,
        watering: .every2Days,
        sunlight: .fullSun,
        isIndoor: false
    ),
    Plant(
        name: "Monstera",
        imageName: "monstera",
        soilType: .wellDrained,
        watering: .weekly,
        sunlight: .mediumLight,
        isIndoor: true
    ),
    Plant(
        name: "Romarin",
        imageName: "romarin",
        soilType: .dry,
        watering: .weekly,
        sunlight: .fullSun,
        isIndoor: false
    ),
]

//ID des plantes
let lavandeID = plantListInitVar.first(where: { $0.name == "Lavande" })?.id
let basilicID = plantListInitVar.first(where: { $0.name == "Basilic" })?.id
let ficusID = plantListInitVar.first(where: { $0.name == "Ficus" })?.id
let aloeveraID = plantListInitVar.first(where: { $0.name == "Aloe Vera" })?.id
let monsteraID = plantListInitVar.first(where: { $0.name == "Monstera" })?.id
let romarinID = plantListInitVar.first(where: { $0.name == "Romarin" })?.id

//Liste des tâches
var tasks: [PlantTask] = [
    PlantTask(name: "Arroser", date: "26/09/2025", isDone: false,plantID: lavandeID!),
    PlantTask(name: "Rajouter de l'engrais", date: "26/09/2025", isDone: true, plantID: aloeveraID!),
    PlantTask(name: "Tailler", date: "26/09/2025", isDone: false, plantID: ficusID!) ]


//Liste des tâches
var taskListInitVar: [PlantTask] = [
    PlantTask(
        name: "Arroser",
        date: "26/01/2025",
        isDone: false,
        plantID: lavandeID!
    ),
    PlantTask(
        name: "Rajouter de l'engrais",
        date: "26/01/2025",
        isDone: true,
        plantID: aloeveraID!
    ),
    PlantTask(
        name: "Tailler",
        date: "26/01/2025",
        isDone: false,
        plantID: ficusID!
    )
]


//Liste des postes
var posts: [Post] = [
    Post(
        title: "Comment arroser vos plantes efficacement",
        image: "plant.fill",
        contentText: "L'arrosage est crucial pour la santé de vos plantes...",
        description: "Conseils d’arrosage pour plantes d’intérieur",
        author: users[0],
        date: "26/01/2025",
        nbLike: 42,
        filter: .beginnerFriendly,
        comments: comments[2]
    ),
    Post(
        title: "DIY : Construire une jardinière en bois",
        image: "hammer.fill",
        contentText: "Voici comment construire une belle jardinière en quelques étapes...",
        description: "Tutoriel pour fabriquer une jardinière simple",
        author: users[2],
        date: "26/01/2025",
        nbLike: 29,
        filter: .beginnerFriendly,
        comments: comments[0]
    ),
    Post(
        title: "Les meilleures plantes dépolluantes",
        image: "leaf.fill",
        contentText: "Certaines plantes peuvent améliorer la qualité de l'air chez vous...",
        description: "Top 5 des plantes purificatrices",
        author: users[1],
        date: "26/01/2025",
        nbLike: 78,
        filter: .airPurifier,
        comments: comments[2]
    ),
]

//Liste des commentaires
var comments = [
    Comment(
        commentText: "Super article, merci !",
        date: "26/01/2025",
        author: users[0]
    ),
    Comment(
        commentText: "Très bien écrit 👏",
        date: "26/01/2025",
        author: users[1]
    ),
    Comment(
        commentText: "J’ai hâte de lire la suite.",
        date: "26/01/2025",
        author: users[0]
    ),
]

//Liste des profils utilisateurs
var users = [
    Profile(username: "alice_garden", profilePic: "person.circle"),
    Profile(username: "bob_the_planter", profilePic: "hammer.fill"),
    Profile(username: "clara_leaf", profilePic: "paintbrush.fill"),
]

// Liste élargie des symboles SF courants, regroupés par thèmes
let symbolsNature = [
    "leaf", "leaf.fill", "tree", "tree.fill", "camera.macro", "camera.macro.circle.fill",
    "tortoise", "tortoise.fill", "hare", "hare.fill", "ant", "ladybug", "fish", "pawprint.fill",
    "drop", "drop.fill", "cloud", "cloud.fill", "cloud.sun", "cloud.sun.fill", "cloud.rain", "cloud.rain.fill",
    "sun.max", "sun.max.fill", "moon", "moon.fill", "sparkles", "snow", "wind", "flame", "flame.fill",
    "bolt", "bolt.fill", "bolt.circle", "bolt.circle.fill", "humidity", "humidity.fill",
    "leaf.arrow.triangle.circlepath"
]
let symbolsGardening = [
    "sprinkler", "sprinkler.fill", "drop.triangle", "drop.triangle.fill",
    "leaf.circle", "leaf.circle.fill", "globe.americas.fill", "globe.europe.africa.fill",
    "camera.filters", "thermometer", "thermometer.sun", "thermometer.low",
    "figure.walk", "figure.run", "figure.stand", "figure.flexibility"
]
let symbolsTools = [
    "hammer", "hammer.fill", "wrench", "wrench.fill", "screwdriver", "screwdriver.fill",
    "paintbrush", "paintbrush.fill", "scissors", "scissors.badge.ellipsis",
    "ruler", "ruler.fill", "level", "level.fill", "screwdriver.and.wrench", "screwdriver.and.wrench.fill",
    "trash", "trash.fill", "trash.circle", "trash.circle.fill", "folder", "folder.fill"
]
let symbolsObjects = [
    "book", "book.fill", "text.book.closed.fill", "magazine", "magazine.fill",
    "cart", "cart.fill", "bag", "bag.fill", "creditcard", "creditcard.fill",
    "gift", "gift.fill", "shippingbox", "shippingbox.fill", "cube", "cube.fill", "cube.box.fill"
]
let symbolsMedia = [
    "camera", "camera.fill", "photo", "photo.fill", "video", "video.fill",
    "music.note", "music.note.list", "speaker", "speaker.fill", "mic", "mic.fill",
    "play.circle", "play.circle.fill", "pause.circle", "pause.circle.fill"
]
let symbolsPeople = [
    "person", "person.fill", "person.2", "person.2.fill", "person.3", "person.3.fill",
    "person.crop.circle", "person.crop.circle.fill", "person.crop.square", "person.crop.square.fill",
    "hand.raised", "hand.raised.fill", "hand.thumbsup", "hand.thumbsup.fill", "hands.sparkles.fill"
]
let symbolsComm = [
    "message", "message.fill", "bubble.left", "bubble.left.fill", "bubble.right", "bubble.right.fill",
    "at", "envelope", "envelope.fill", "paperplane", "paperplane.fill",
    "phone", "phone.fill", "link", "link.circle.fill"
]
let symbolsArrowsUI = [
    "plus", "plus.circle", "plus.circle.fill", "minus", "minus.circle.fill",
    "xmark", "xmark.circle", "xmark.circle.fill", "checkmark", "checkmark.circle.fill",
    "chevron.right", "chevron.left", "chevron.up", "chevron.down",
    "arrow.up.right", "arrow.up.right.circle.fill", "arrow.down", "arrow.left", "arrow.right",
    "ellipsis", "ellipsis.circle", "ellipsis.circle.fill", "gear", "gearshape.fill",
    "magnifyingglass", "bookmark", "bookmark.fill", "star", "star.fill", "flag", "flag.fill",
    "info.circle", "info.circle.fill", "questionmark.circle", "questionmark.circle.fill",
    "exclamationmark.triangle", "exclamationmark.triangle.fill"
]
let symbolsTransport = [
    "bicycle", "bicycle.circle.fill", "car", "car.fill", "tram", "tram.fill",
    "bus", "bus.fill", "ferry", "ferry.fill", "airplane", "airplane.circle.fill"
]
let symbolsHome = [
    "house", "house.fill", "building.2", "building.2.fill", "leaf.house", "leaf.house.fill",
    "lightbulb", "lightbulb.fill", "powersocket.type.e.fill", "shield.lefthalf.filled",
    "bed.double.fill", "sofa.fill", "refrigerator.fill", "washer.fill"
]

// Limité aux symboles liés aux plantes et au jardinage
let availableSFSymbols: [String] = (
    symbolsNature + symbolsGardening
)

var taskListGlobalVar = TaskListClass()
var plantListGlobalVar = PlantListClass()

let defaultPlant = Plant(
    name: "",
    soilType: .wellDrained,  // premier de SoilType
    watering: .daily,  // premier de WateringFrequency
    sunlight: .fullSun,  // premier de Sunlight
    isIndoor: true
)
