import ProjectDescription

extension Project {
   public static func makeModule(
        name: String, // 모듈의 이름
        platform: Platform = .iOS, // 모듈의 를랫폼
        product: Product, // 제품의 유형 ex: .app, .framework
        organizationName: String = "jeongDeokHo", // 조직 및 팀 이름
        packages: [Package] = [], // 외부 패키지
        deploymentTarget: DeploymentTarget? = .iOS(targetVersion: "15.0", devices: [.iphone]), // 배포 타겟
        dependencies: [TargetDependency] = [], // 외부 의존성
        sources: SourceFilesList = ["Sources/**"], // 소스파일 리스트
        resources: ResourceFileElements? = nil, // 리소스 파일 요소
        infoPlist: InfoPlist = .default, // Info.plist 설정
        isNotSources: Bool = false, // 소스가 있는지 없는지
        isNotResources: Bool = false, // 리소스가 있는지 없는지
        isNotTests: Bool = false // Test가 있는지 없는지
    ) -> Project {
        // 프로젝트 설정 정의
        let settings: Settings = .settings(
            base: [:],
            configurations: [
                .debug(name: .debug), // 디버그 설정
                .release(name: .release) // 릴리즈 설정
            ], defaultSettings: .recommended // 기본설정은 추천값
        )

        let appTarget = Target(
            name: name, // 타겟의 이름설정
            platform: platform, // 타겟이 빌드될 플랫폼을 설정
            product: product, // 타겟의 제품 유형을 설정 .app, .framework 등
            bundleId: "\(organizationName).\(name)", // 번들 식별자 설정
            deploymentTarget: deploymentTarget, // 배포 타겟 설정
            infoPlist: infoPlist, // Info.plist의 경로 내지 내용을 설정
            sources: isNotSources ? [] : sources, // 소스 파일의 경로 설정
            resources: isNotResources ? [] : resources, // 리소스 파일의 경로 설정
            dependencies: dependencies // 의존하는 다른 타겟 또는 프레임워크를 설정
        )
        var targets: [Target] = [appTarget]
        if !isNotTests {
            let testTarget = Target(
                name: "\(name)Tests",
                platform: platform,
                product: .unitTests,
                bundleId: "\(organizationName).\(name)Tests",
                deploymentTarget: deploymentTarget,
                infoPlist: .default,
                sources: ["Tests/**"],
                dependencies: [.target(name: name)]
            )
            targets.append(testTarget)
        }

        let schemes: [Scheme] = [.makeScheme(target: .debug, name: name)]

        return Project(
            name: name,
            organizationName: organizationName,
            packages: packages,
            settings: settings,
            targets: targets,
            schemes: schemes
        )
    }
}

extension Scheme {
    // Scheme은 Xcode에서 빌드 테스트 실행 분석 아카이브 등의 작업을 구성하는 방법을 정의한것이다.
    // 하나의 프로젝트에서 여러 작업 흐름을 관리하기위해 여러개의 스킴을 사용할 수 있다.
   public static func makeScheme(target: ConfigurationName, name: String) -> Scheme {
        return Scheme(
            name: name, // 스킴 이름
            shared: true, // 스킴 공유 설정
            buildAction: .buildAction(targets: ["\(name)"]), // 어떤 타겟을 빌드할지 저의
            testAction: .targets( // 어떤 타겟을 테스트할지 정의
                ["\(name)Tests"],
                configuration: target,
                options: .options(coverage: true, codeCoverageTargets: ["\(name)"])
            ),
            runAction: .runAction(configuration: target), // 빌드한 앱을 실행할때 사용자할 정의
            archiveAction: .archiveAction(configuration: target), // 배포를 위한 아카이브를 생성할때 사용할 정의
            profileAction: .profileAction(configuration: target), // 성능분석을 위한 프로파일링 설정 정의
            analyzeAction: .analyzeAction(configuration: target) // 코드 분석을 수행할때 사용할 설정 정의
        )
    }
}
