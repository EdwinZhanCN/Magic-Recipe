//
//  SkillARQuickLook.swift
//  iCooking
//
//  Created by 詹子昊 on 11/4/24.
//
// ARQuickLookView.swift
import SwiftUI
import QuickLook
import ARKit

#if os(iOS)
struct QLModel: UIViewControllerRepresentable {
    var name: String
    var allowScaling: Bool = true
    
    func makeCoordinator() -> QLModel.Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> QLPreviewController {
        let controller = QLPreviewController()
        controller.modalPresentationStyle = .fullScreen
        controller.dataSource = context.coordinator
        return controller
    }
    
    func updateUIViewController(_ controller: QLPreviewController, context: Context) { }
    
    class Coordinator: NSObject, QLPreviewControllerDataSource {
        let parent: QLModel
        
        init(_ parent: QLModel) {
            self.parent = parent
            super.init()
        }
        
        func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
            return 1
        }
        
        func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
            guard let fileURL = Bundle.main.url(forResource: parent.name, withExtension: "usdz") else {
                fatalError("Unable to load \(parent.name).usdz from main bundle")
            }
            let item = ARQuickLookPreviewItem(fileAt: fileURL)
            item.allowsContentScaling = parent.allowScaling
            return item
        }
    }
}
#endif
