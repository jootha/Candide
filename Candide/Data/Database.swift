//
//  Database.swift
//  LeaDEMOexo
//
//  Created by apprenant95 on 15/09/2025.
//

import SwiftUI

// Liste des plantes
var plants: [Plant] = [
    Plant(
        name: "Ficus",
        soilType: .wellDrained,
        watering: .weekly,
        sunlight: .indirectLight,
        isIndoor: true,
        plantTask: [] ),
    Plant(
        name: "Lavande",
        soilType: .calcareous,
        watering: .every10Days,
        sunlight: .fullSun,
        isIndoor: false,
        plantTask: [] ),
    Plant(
        name: "Aloe Vera",
        soilType: .cactusMix,
        watering: .biweekly,
        sunlight: .indirectLight,
        isIndoor: true,
        plantTask: [] ),
    Plant(
        name: "Basilic",
        soilType: .rich,
        watering: .every2Days,
        sunlight: .fullSun,
        isIndoor: false,
        plantTask: [] ),
    Plant(
        name: "Monstera",
        soilType: .wellDrained,
        watering: .weekly,
        sunlight: .mediumLight,
        isIndoor: true,
        plantTask: [] ),
    Plant(
        name: "Romarin",
        soilType: .dry,
        watering: .weekly,
        sunlight: .fullSun,
        isIndoor: false,
        plantTask: [] ) ]

//Liste des tâches
var tasks: [Task] = [
    Task(name: "Arroser", date: "26/01/2025", isDone: false),
    Task(name: "Rajouter de l'engrais", date: "26/01/2025", isDone: true),
    Task(name: "Tailler", date: "26/01/2025", isDone: false) ]

//Liste des postes
var posts: [Post] = [
    Post(
        title: "Comment arroser vos plantes efficacement",
        image: "plant.fill",
        contentText: "L'arrosage est crucial pour la santé de vos plantes...",
        description: "Conseils d’arrosage pour plantes d’intérieur",
        author: users[3],
        date: "26/01/2025",
        nbLike: 42,
        filter: .beginnerFriendly,
        comments: comments[2] ),
    Post(
        title: "DIY : Construire une jardinière en bois",
        image: "hammer.fill",
        contentText: "Voici comment construire une belle jardinière en quelques étapes...",
        description: "Tutoriel pour fabriquer une jardinière simple",
        author: users[2],
        date: "26/01/2025",
        nbLike: 29,
        filter: .beginnerFriendly,
        comments: comments[0] ),
    Post(
        title: "Les meilleures plantes dépolluantes",
        image: "leaf.fill",
        contentText: "Certaines plantes peuvent améliorer la qualité de l'air chez vous...",
        description: "Top 5 des plantes purificatrices",
        author: users[1],
        date: "26/01/2025",
        nbLike: 78,
        filter: .airPurifier,
        comments: comments[2] ) ]

//Liste des commentaires
var comments = [ Comment(
    commentText: "Super article, merci !",
    date: "26/01/2025",
    author: users[0]),
                 Comment(
    commentText: "Très bien écrit 👏",
    date: "26/01/2025",
    author: users[1]),
                 Comment(
    commentText: "J’ai hâte de lire la suite.",
    date: "26/01/2025",
    author: users[0]) ]

//Liste des profils utilisateurs
var users = [Profile(username: "alice_garden", profilePic: "person.circle"),
             Profile(username: "bob_the_planter", profilePic: "hammer.fill"),
             Profile(username: "clara_leaf", profilePic: "paintbrush.fill") ]
