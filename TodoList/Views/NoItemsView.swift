//
//  NoItemsView.swift
//  TodoList
//
//  Created by Manuel Parcon on 9/30/24.
//

import SwiftUI

struct NoItemsView: View {
    
    @State var animate: Bool = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                Text("There are no items!")
                    .font(.title)
                    .fontWeight(.semibold)
                Text("Are you a productive person? I think you should click the add button and add a bunch of items to your todo list!")
                    .padding(.bottom, 20)
                NavigationLink {
                    AddView()
                } label: {
                    Text("Add Something 😉")
                        .foregroundStyle(.white)
                        .font(.headline)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(animate ? Color.secondaryAccentcolor : Color.accentColor)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                .padding(.horizontal, animate ? 30 : 40)
                .shadow(
                    color: animate ? Color.secondaryAccentcolor.opacity(0.7) : Color.accentColor.opacity(0.7),
                    radius: animate ? 30 : 10,
                    x: 0,
                    y: animate ? 50 : 30)
                .scaleEffect(animate ? 1.1 : 1.0)
                .offset(y: animate ? -7 : 0)

            }
            .multilineTextAlignment(.center)
            .padding(40)
            .onAppear(perform: {
                addAnimation()
            })
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    func addAnimation() {
        // To not call the animation twice: guard makes sure that animate is false, otherwise return
        guard !animate else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            withAnimation(
                Animation
                    .easeInOut(duration: 2.0)
                    .repeatForever()
            ) {
                animate.toggle()
            }
        }
    }
}

#Preview {
    NavigationStack {
        NoItemsView()
            .navigationTitle("Title")
    }
}
