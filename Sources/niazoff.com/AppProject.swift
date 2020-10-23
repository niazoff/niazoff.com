import Foundation
import Files
import Publish
import Plot
import Ink

struct AppProject {
  let name: String
  let image: String
  let link: String?
  let descriptionHTML: String
  var order = 0
}

struct AppsPageFactory {
  func makePage(fromApps apps: [AppProject]) -> Page {
    .init(path: "apps", content: .init(title: "Apps", description: "", body: makeBody(fromApps: apps)))
  }
  
  private func makeBody(fromApps apps: [AppProject]) -> Content.Body { .init(
    node: .ul(.id("apps-list"), .forEach(apps.sorted { $0.order < $1.order }.enumerated()) { index, app in
      .li(.if(!(index + 1).isMultiple(of: 2), .class("reverse")),
        .div(.class("app-details"),
          .h2(.text(app.name)),
          .div(.class("app-description"), .raw(app.descriptionHTML)),
          .unwrap(app.link) { .a(.target(.blank), .href($0), .img(.src("/app-store-badge.svg"))) }
        ),
        .img(.class("app-image"), .src(app.image))
      )
    })
  )}
}

struct MarkdownAppFactory {
  var parser = MarkdownParser()
  
  enum MarkdownAppFactoryError: Error {
    case missingRequiredMetadata
  }
  
  func makeApp(fromFile file: File) throws -> AppProject {
    let markdown = try parser.parse(file.readAsString())
    guard let image = markdown.metadata["image"]
    else { throw MarkdownAppFactoryError.missingRequiredMetadata }
    return AppProject(
      name: markdown.metadata["name"] ?? file.nameExcludingExtension,
      image: image, link: markdown.metadata["link"],
      descriptionHTML: markdown.html,
      order: markdown.metadata["order"].flatMap(Int.init) ?? 0)
  }
}

struct AppMarkdownFileHandler<Site: Website> {
  var markdownAppFactory = MarkdownAppFactory()
  var appsPageFactory = AppsPageFactory()
  
  func addMarkdownFiles(in folder: Folder, to context: inout PublishingContext<Site>) throws {
    let apps = try folder.files.map(markdownAppFactory.makeApp)
    context.addPage(appsPageFactory.makePage(fromApps: apps))
  }
}

extension PublishingStep {
  static func addAppMarkdownFiles(at path: Path = "Apps") -> Self {
    step(named: "Add page with app Markdown files from '\(path)' folder") { context in
      let folder = try context.folder(at: path)
      try AppMarkdownFileHandler().addMarkdownFiles(in: folder, to: &context)
    }
  }
}
