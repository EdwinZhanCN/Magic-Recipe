//
//  IngredientCardView.swift
//  Culinex
//
//  Created by 詹子昊 on 6/20/25.
//

import SwiftUI

struct SkillCardView: View {
    @Environment(\.colorScheme) var colorScheme
    @State var toggleARQuickLookView: Bool = false
    @State private var selectedModelFileName: String = ""
    @State private var showFullText = false

    var skill: Skill
    
    private var skillImage: Image {
        return Image(systemName: skill.icon)
    }
    
    var body: some View {
        HStack {
            Text(skill.name)
                .font(.body)
                .bold()
                .lineLimit(3)
                .onTapGesture {
                    // 点击时显示浮窗
                    showFullText.toggle()
                }
                .popover(isPresented: $showFullText, arrowEdge: .leading) {
                    // 这是浮窗中显示的内容
                    VStack {
                        Text(skill.name)
                            .font(.headline)
                            .padding()
                        Button("Close") {
                            showFullText = false
                        }
                        .padding(.bottom)
                    }
                    // 在 iOS 16.4+ 上可以设置浮窗的大小
                    .presentationCompactAdaptation(.popover)
                }
            Spacer()
            if let arFile = skill.ARFileName{
                Button {
                    toggleARQuickLookView.toggle()
                    selectedModelFileName = arFile
                } label: {
                    Image(systemName: "cube.transparent")
                        .font(.system(size: 15, weight: .medium))
                        .foregroundColor(.accentColor)
                        .padding(14)
                        .background(Circle().fill(Color.accentColor.opacity(0.15)))
                        .shadow(color: .accentColor.opacity(0.25), radius: 4, x: 0, y: 2)
                        .accessibilityLabel("View in AR")
                }
            }
            skillImage
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
                .cornerRadius(8)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(colorScheme == .dark ? UIColor.systemGray5 : UIColor.systemGray6))
                .shadow(radius: 2)
        )
        #if os(iOS)
        .fullScreenCover(isPresented: $toggleARQuickLookView) {
            ZStack {
                // Add a subtle dark material background for better AR focus
                Color.black.opacity(0.7)
                    .ignoresSafeArea()
                
                QLModel(name: selectedModelFileName)
                    .edgesIgnoringSafeArea(.all)
                    .zIndex(0)

                VStack {
                    HStack {
                        Button(action: {
                            withAnimation(.spring()) {
                                toggleARQuickLookView = false
                            }
                        }) {
                            Label("Back", systemImage: "chevron.backward.circle.fill")
                                .font(.title2.bold())
                                .foregroundColor(.white)
                                .padding(10)
                                .background(BlurView(style: .systemUltraThinMaterialDark))
                                .clipShape(Capsule())
                                .shadow(radius: 8, y: 3)
                                .accessibilityLabel("Close AR View")
                        }
                        Spacer()
                    }
                    .padding([.top, .horizontal], 24)
                    Spacer()
                }
            }
        }
        #endif
    }
}




#if canImport(UIKit)
import UIKit
struct BlurView: UIViewRepresentable {
    var style: UIBlurEffect.Style = .systemMaterial
    func makeUIView(context: Context) -> UIVisualEffectView {
        UIVisualEffectView(effect: UIBlurEffect(style: style))
    }
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {}
}
#endif
