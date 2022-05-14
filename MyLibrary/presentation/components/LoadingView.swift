//
//  LoadingView.swift
//  MyLibrary
//
//  Created by Leticia Echarri on 14/5/22.
//

import SwiftUI

struct LoadingView<Content>: View where Content: View {

    @Binding var isShowing: Bool  // should the modal be visible?
    var content: () -> Content

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {
                // the content to display - if the modal is showing, we'll blur it
                content()
                    .disabled(isShowing)
                    .blur(radius: isShowing ? 2 : 0)
                
                // all contents inside here will only be shown when isShowing is true
                if isShowing {
                    // this Rectangle is a semi-transparent black overlay
                    Rectangle()
                        .fill(Color.black).opacity(isShowing ? 0.2 : 0)
                        .edgesIgnoringSafeArea(.all)

                    // the magic bit - our ProgressView just displays an activity
                    // indicator, with some text underneath showing what we are doing
                    VStack {
                        ProgressView().scaleEffect(2.0, anchor: .center)
                            .progressViewStyle(CircularProgressViewStyle(tint: Color.black))
                    }
                }
            }
        }
    }
}
