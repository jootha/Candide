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
        isIndoor: false,
        plantTask: []
    ),
    Plant(
        name: "Tomate",
        soilType: .rich,
        watering: .every2Days,
        sunlight: .fullSun,
        isIndoor: false,
        plantTask: []
    ),
    Plant(
        name: "Aloe Vera",
        imageName: "aloevera",
        soilType: .cactusMix,
        watering: .biweekly,
        sunlight: .indirectLight,
        isIndoor: true,
        plantTask: []
    ),
    Plant(
        name: "Ficus",
        soilType: .wellDrained,
        watering: .weekly,
        sunlight: .indirectLight,
        isIndoor: true,
        plantTask: []
    ),
    Plant(
        name: "Basilic",
        imageName: "basilic",
        soilType: .rich,
        watering: .every2Days,
        sunlight: .fullSun,
        isIndoor: false,
        plantTask: []
    ),
    Plant(
        name: "Monstera",
        imageName: "monstera",
        soilType: .wellDrained,
        watering: .weekly,
        sunlight: .mediumLight,
        isIndoor: true,
        plantTask: []
    ),
    Plant(
        name: "Romarin",
        imageName: "romarin",
        soilType: .dry,
        watering: .weekly,
        sunlight: .fullSun,
        isIndoor: false,
        plantTask: []
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
        comments: comments[2],
        category: .plantes
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
        comments: comments[0],
        category: .engrais
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
        comments: comments[2],
        category: .medecine
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

var plantListGlobalVar = PlantListClass()

var defaultPlant = Plant(
    name: "",
    soilType: .wellDrained,  // premier de SoilType
    watering: .daily,  // premier de WateringFrequency
    sunlight: .fullSun,  // premier de Sunlight
    isIndoor: true,
    plantTask: []
)
