import Foundation
import Publish
import Plot
import SplashPublishPlugin
import SwiftExtensions

enum niazoff {
  struct com: Website {
    var url = URL(string: "https://niazoff.com") ?? preconditionFailure()
    var name = "Natanel Niazoff"
    var description = "Sharing my interests in Swift, iOS, Apple & more"
    var language: Language { .english }
    var imagePath: Path? { nil }
    
    enum SectionID: String, WebsiteSectionID {
      case posts
    }
    
    struct ItemMetadata: WebsiteItemMetadata {}
  }
}

try niazoff.com().publish(withTheme: .default(
  additionalStylesheetPaths: ["/apps.css"],
  pagePaths: ["apps", "about"],
  contentPagePaths: ["about"],
  copyright: "Natanel Niazoff",
  twitterURL: "https://twitter.com/niazoff",
  githubURL: "https://github.com/niazoff"
), deployedUsing: .gitHub("niazoff/niazoff.com-release", useSSH: false),
additionalSteps: [
  .addAppMarkdownFiles()
], plugins: [
  .splash(withClassPrefix: "")
])
