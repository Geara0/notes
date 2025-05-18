allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

subprojects {
    afterEvaluate {
        // Для Application модулей
        extensions.findByType<com.android.build.api.dsl.ApplicationExtension>()?.apply {
            compileSdk = 34
            buildToolsVersion = "34.0.0"

            if (namespace == null) {
                namespace = project.group.toString()
            }
        }

        // Для Library модулей
        extensions.findByType<com.android.build.api.dsl.LibraryExtension>()?.apply {
            compileSdk = 34
            buildToolsVersion = "34.0.0"

            if (namespace == null) {
                namespace = project.group.toString()
            }
        }
    }
}


val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
