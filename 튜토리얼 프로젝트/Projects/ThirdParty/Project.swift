//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by Jeong Deokho on 7/18/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: "ThirdParty",
    product: .framework,
    packages: [],
    dependencies: [],
    isNotSources: true,
    isNotResources: true,
    isNotTests: true
)
