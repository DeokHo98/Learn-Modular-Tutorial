//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by Jeong Deokho on 7/18/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: "Tutorial",
    product: .app,
    dependencies: [
        .Project.Feature
    ],
    resources: ["Resources/**"],
    infoPlist: .file(path: "Support/Info.plist"),
    isNotTests: true

    // Tuist에서 만들어주는 Info.Plist는 자동화 되지 않는다. 그래서 Source Code에서 직접 Key를 찾고 Value를 넣어줘야 한다.
    // 하지만 만약 Xcode로 프로젝트를 만들때의 Info.plist를 직접넣어 .extendingDefault로 추가 옵션을 넣어주는게 아닌
    // 경로를 지정해줘서 InfoPlist를 지정해준다면 에디터 내에서 Property List로 보면서 자동완성이 사용 가능하다.
)
