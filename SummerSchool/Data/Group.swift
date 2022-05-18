//
//  Group.swift
//  SummerSchool
//
//  Created by Juan Carlos Sánchez Gutiérrez on 18/05/22.
//

import Foundation

struct Group: Codable, Equatable, Hashable {
    
    let curso: String
    let nombre: String
    let lugares: Int
    let alumnos: [Student]?
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(curso)
    }
}

typealias GroupsResponse = [Group]
