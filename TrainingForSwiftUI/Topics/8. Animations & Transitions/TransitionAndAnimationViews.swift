//
//  TransitionAndAnimationViews.swift
//  TrainningForSwiftUI
//
//  Created by Otabek Tuychiev on 4/23/25.
//

import SwiftUI

// MARK: - 21. View Transition & Animation

struct TransitionAndAnimationViews: View {
    var body: some View {
        Text("Hello, World!")
    }
}

// 1.  withAnimation – oddiy animatsiya

struct SimpleAnimationView: View {
    @State private var isVisible = false
    
//   withAnimation — o‘zgarish animatsiya bilan yuz bersin degani.
//   .transition(.scale) — ko‘rinish/yo‘qolishda hajmi o‘zgaradi.

    var body: some View {
        VStack {
            Button("Toggle Box") {
                withAnimation(.easeInOut(duration: 0.5)) { 
                    isVisible.toggle()
                }
            }

            if isVisible {
                Rectangle()
                    .fill(Color.blue)
                    .frame(width: 100, height: 100)
                    .transition(.scale)
            }
        }
    }
}

// 2.       Transition(_:) – ko‘rinishdagi o‘tish effekti

//.transition(.opacity) // Fade in/out
//.transition(.slide)   // Yon tomondan chiqib/ketadi
//.transition(.move(edge: .bottom)) // Pastdan kiradi/chiqadi

// Kombinatsiya qilish ham mumkin:
// .transition(.asymmetric(insertion: .move(edge: .leading), removal: .opacity))


// 3. animation(_:) – doimiy animatsiyalar

struct AnimationModifierExample: View {
    @State private var scale: CGFloat = 1

    var body: some View {
        VStack {
            Circle()
                .frame(width: 100, height: 100)
                .scaleEffect(scale)
                .animation(.spring(response: 0.3, dampingFraction: 0.5), value: scale)

            Button("Animate") {
                scale += 0.2
            }
        }
    }
}
//    .animation(..., value:) har gal value o‘zgarsa animatsiya bo‘ladi.


// 4.

// matchedGeometryEffect — SwiftUI’da ikki yoki undan ortiq view’lar bir xil ID orqali bog‘lanib, ular orasida silliq transformatsiya qilish imkonini beradi.
// Bu effekt View'lar joylashuvi, hajmi, shakli, rotation, opacity kabi xususiyatlarni silliq o‘zgartiradi.

struct MatchedGeometryExample: View {
    @Namespace private var animation
    @State private var isExpanded = false

    var body: some View {
        VStack {
            if isExpanded {
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color.blue)
                    .matchedGeometryEffect(id: "card", in: animation)
                    .frame(width: 300, height: 300)
                    .onTapGesture {
                        withAnimation(.spring()) {
                            isExpanded.toggle()
                        }
                    }
            } else {
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color.blue)
                    .matchedGeometryEffect(id: "card", in: animation)
                    .frame(width: 100, height: 100)
                    .onTapGesture {
                        withAnimation(.spring()) {
                            isExpanded.toggle()
                        }
                    }
            }
        }
    }
}

// Note:
//    @Namespace — bu identifikatorlar makonini aniqlaydi (ikkala View bir-biriga tegishli bo‘lishi uchun kerak).
//    .matchedGeometryEffect(id:in:) — bu ikkita view'ni bog‘laydi.
//    Har safar isExpanded o‘zgarsa, SwiftUI view’lar orasidagi farqni animatsiya qiladi.

//Practice.....

struct ArcadeCardTransitionView: View {
    @Namespace private var animation
    @State private var showDetail = false

    var body: some View {
        ZStack {
            if !showDetail {
                VStack(alignment: .center) {
                    Spacer()
                    HStack(alignment: .center) {
                        Spacer()
                        VStack(alignment: .center, spacing: 8) {
                            Image("image_07")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 120, height: 120)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                .matchedGeometryEffect(id: "image", in: animation)

                            Text("Arcade Game")
                                .font(.headline)
                                .matchedGeometryEffect(id: "title", in: animation)
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(.ultraThinMaterial)
                                .matchedGeometryEffect(id: "background", in: animation)
                        )
                        .onTapGesture {
                            withAnimation(.spring()) {
                                showDetail.toggle()
                            }
                        }
                        Spacer()
                    }
                    Spacer()
                }
            } else {
                VStack(alignment: .center, spacing: 20) {
                    Image("image_07")
                        .resizable()
                        .scaledToFill()
                        .frame(width: .infinity, height: 300)
                        .clipShape(RoundedRectangle(cornerRadius: 0))
                        .matchedGeometryEffect(id: "image", in: animation)

                    Text("Arcade Game")
                        .font(.title.bold())
                        .matchedGeometryEffect(id: "title", in: animation)

                    Text("Play your favorite Arcade games with amazing graphics and sound.")
                        .padding(.horizontal)

                    Button("Close") {
                        withAnimation(.spring()) {
                            showDetail.toggle()
                        }
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .clipShape(Capsule())

                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 0)
                        .fill(.ultraThinMaterial)
                        .matchedGeometryEffect(id: "background", in: animation)
                )
                .ignoresSafeArea()
            }
        }
    }
}


struct Game: Identifiable {
    let id = UUID()
    let title: String
    let imageName: String
}

let games = [
    Game(title: "Space Run", imageName: "image_01"),
    Game(title: "Rocket X", imageName: "image_02"),
    Game(title: "Arcade Hero", imageName: "image_07"),
    Game(title: "Rocket X", imageName: "image_05")
]

struct ArcadeCardGridView: View {
    @Namespace private var animation
    @State private var selectedGame: Game? = nil
    @State private var showDetail = false
    
    var body: some View {
        ZStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                    ForEach(games) { game in
                        VStack {
                            Image(game.imageName)
                                .resizable()
                                .scaledToFill()
                                .frame(width: UIScreen.main.bounds.width / 2 - 50, height: 150)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                .matchedGeometryEffect(id: game.id.uuidString + "image", in: animation)
                            
                            Text(game.title)
                                .font(.headline)
                                .matchedGeometryEffect(id: game.id.uuidString + "title", in: animation)
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(.ultraThinMaterial)
                                .matchedGeometryEffect(id: game.id.uuidString + "bg", in: animation)
                        )
                        .onTapGesture {
                            selectedGame = game
                            withAnimation(.spring()) {
                                showDetail = true
                            }
                        }
                    }
                }
                .padding()
            }
            
            // 🔍 Detail View
            if let selected = selectedGame, showDetail {
                VStack(spacing: 20) {
                    ScrollView {
                        Image(selected.imageName)
                            .resizable()
                            .scaledToFill()
                            .frame(height: 300)
                            .clipShape(RoundedRectangle(cornerRadius: 0))
                            .matchedGeometryEffect(id: selected.id.uuidString + "image", in: animation)
                        
                        Text(selected.title)
                            .font(.largeTitle.bold())
                            .matchedGeometryEffect(id: selected.id.uuidString + "title", in: animation)
                        
                        Text("Enjoy next-gen arcade gameplay with incredible action and design!")
                            .padding(.horizontal)
                        
                        Button("Close") {
                            withAnimation(.spring()) {
                                showDetail = false
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                                    selectedGame = nil
                                }
                            }
                        }
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                        
                        Spacer()
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 0)
                        .fill(.ultraThinMaterial)
                        .matchedGeometryEffect(id: selected.id.uuidString + "bg", in: animation)
                )
                .ignoresSafeArea()
                .transition(.opacity)
            }
        }
    }
}

// MARK: - Card View
// Reusable ArcadeCard View

struct ArcadeCard: View {
    let imageName: String
    let title: String

    var body: some View {
        VStack(spacing: 0) {
            Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(width:  UIScreen.main.bounds.width / 2 - 16, height: 120)
                .clipped()
            Text(title)
                .font(.headline)
                .padding(.vertical, 8)
        }
        .frame(maxWidth: .infinity)
        .background(.ultraThinMaterial)
        .cornerRadius(16)
        .shadow(radius: 4)
    }
}

struct ArcadeCardGridView2: View {
    @Namespace var namespace
    @State private var selectedCard: Int? = nil
    let items = [("image_01", "Game 1"), ("image_02", "Game 2"),
                 ("image_03", "Game 3"), ("image_04", "Game 4"),
                 ("image_01", "Game 1"), ("image_02", "Game 2"),
                 ("image_03", "Game 3"), ("image_04", "Game 4")]

    var body: some View {
        ScrollView {
            ZStack {
                if let selected = selectedCard {
                    DetailCardView(imageName: items[selected].0,
                                   title: items[selected].1,
                                   namespace: namespace)
                    .onTapGesture {
                        withAnimation() {
//                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                                selectedCard = nil
//                            }
                        }
                    }
                } else {
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 16), count: 2), spacing: 16) {
                        ForEach(items.indices, id: \.self) { i in
                            ArcadeCard(imageName: items[i].0, title: items[i].1)
                                .matchedGeometryEffect(id: i, in: namespace)
                                .onTapGesture {
                                    withAnimation() {
                                        selectedCard = i
                                    }
                                }
                        }
                    }
                    .padding()
                }
            }
            
        }
    }
}

struct DetailCardView: View {
    let imageName: String
    let title: String
    var namespace: Namespace.ID

    var body: some View {
        ScrollView {
            VStack {
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .matchedGeometryEffect(id: title.hashValue, in: namespace)
                Text(title)
                    .font(.largeTitle)
                    .bold()
                    .padding()
            }
            .background(.ultraThinMaterial)
            .cornerRadius(20)
            .padding()
            .shadow(radius: 10)
            .transition(.scale)
        }
        
    }
}


#Preview {
//    VStack(spacing: 20) {
//        TransitionAndAnimationViews()
//        SimpleAnimationView()
//        AnimationModifierExample()
//        MatchedGeometryExample()
//    }
//    ArcadeCardTransitionView()
    ArcadeCardGridView2()
    
}
