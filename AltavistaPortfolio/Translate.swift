//
//  TranslateBr.swift
//  AltavistaPortfolio
//
//  Created by Ricardo Altavista on 08/07/24.
//

import Foundation
struct Translate {
    let experiencia: String
    let sobreMim: String
    let cursos: String
    let formacao: String
    let freelancer: String
    let contato: String
    
    static let PTBR = Translate(
        experiencia: "Experiência",
        sobreMim: "Sobre Mim",
        cursos: "Cursos",
        formacao: "Formação",
        freelancer: "Trabalhos Freelancer",
        contato: "Contato"
    )
    
    static let ENUS = Translate(
        experiencia: "Experience",
        sobreMim: "About Me",
        cursos: "Courses",
        formacao: "Training",
        freelancer: "Freelancer jobs",
        contato: "Contact"
    )
}

