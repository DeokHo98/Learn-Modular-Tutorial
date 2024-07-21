//
//  Project+Extension.swift
//  ProjectDescriptionHelpers
//
//  Created by Jeong Deokho on 7/18/24.
//

import ProjectDescription

extension TargetDependency {
    public enum Project { }
}

public extension TargetDependency.Project {
    static let Feature = TargetDependency.project(target: "Feature", path: .relativeToRoot("Projects/Feature"))
    static let Service = TargetDependency.project(target: "Service", path: .relativeToRoot("Projects/Service"))
    static let ThirdParty = TargetDependency.project(target: "ThirdParty", path: .relativeToRoot("Projects/ThirdParty"))
}
