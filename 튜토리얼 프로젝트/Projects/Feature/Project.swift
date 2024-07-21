//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by Jeong Deokho on 7/18/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let porject = Project.makeModule(
    name: "Feature",
    product: .staticFramework,
    dependencies:  [
        .Project.Service
    ],
    resources: ["Resources/**"]
)
