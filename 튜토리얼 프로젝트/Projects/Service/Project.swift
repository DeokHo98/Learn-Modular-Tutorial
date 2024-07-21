//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by Jeong Deokho on 7/18/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: "Service",
    product: .staticFramework,
    dependencies: [
        .Project.ThirdParty
    ]
)
