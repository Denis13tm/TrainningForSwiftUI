//
//  GeoReaderView.swift
//  TrainningForSwiftUI
//
//  Created by Otabek Tuychiev on 4/20/25.
//

import SwiftUI

struct GeoReaderView: View {
    
    @Namespace var animation
    @State private var showCompactHeader = false
    @State private var toolbarOpacity: Double = 0
    
    var body: some View {
        
        VStack {
            GeometryReader { geo in
                let minY = geo.frame(in: .global).minY

                Image("image_01")
                    .resizable()
                    .scaledToFill()
                    .frame(height: 300)
                    .offset(y: minY > 0 ? -minY : 0) // 🔥 ScrollView tortganda tepaga suriladi
            }
            .frame(height: 300)

        }
        
    }
}

struct FrameComparison: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 40) {
                ForEach(0..<10) { i in
                    GeometryReader { geo in
                        let localY = geo.frame(in: .local).minY
                        let globalY = geo.frame(in: .global).minY
                        
                        VStack {
                            Text("Local Y: \(Int(localY))")
                            Text("Global Y: \(Int(globalY))")
                        }
                        .frame(height: 100)
                        .frame(maxWidth: .infinity)
                        .background(Color.blue.opacity(0.2))
                    }
                    .frame(height: 100)
                }
            }
        }
    }
}

struct ResponsiveBoxView: View {
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width

            VStack {
                if width > 500 {
                    HStack {
                        Color.red
                        Color.blue
                    }
                    .frame(height: 200)
                } else {
                    VStack {
                        Color.red
                        Color.blue
                    }
                    .frame(height: 200)
                }
            }
            .padding(.all, 5)
            .frame(width: width)
            .background(.brown)
        }
    }
}

struct ScrollOffsetExample: View {
    var body: some View {
        ScrollView {
            GeometryReader { geo in
                let offset = geo.frame(in: .named("scroll")).minY
                
                GeometryReader { geo in
                    let minY = geo.frame(in: .global).minY

                    Image("image_01")
                        .resizable()
                        .scaledToFill()
                        .frame(height: 300)
                        .offset(y: minY > 0 ? -minY : 0) // 🔥 ScrollView tortganda tepaga suriladi
                }
                .frame(height: 300)



                Text("Offset: \(Int(offset))")
                    .frame(height: 50)
                    .frame(maxWidth: .infinity)
                    .background(Color.yellow)
                    .offset(y: -offset) // move with scroll
            }
            .frame(height: 50)

            ForEach(0..<30) { i in
                Text("Row \(i)")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(8)
                    .padding(.horizontal)
            }
        }
        .coordinateSpace(name: "scroll") // 📍 kerakli scroll pozitsiya uchun
    }
}

struct CenteredCircleView: View {
    var body: some View {
        GeometryReader { geo in
            let size = geo.size

            ZStack {
                VStack {
                    Text("width: \(Int(size.width)), height: \(Int(size.height))")
                        .padding()
                    Spacer()
                }
                Circle()
                    .fill(Color.blue)
                    .frame(width: 100, height: 100)
                    .position(x: size.width / 2, y: size.height / 2)
            }
            .background(.brown)
        }
    }
}



struct ParallaxHeaderView: View {
    var body: some View {
        ScrollView {
            // 🔻 Header with scroll effect
            GeometryReader { geo in
                let minY = geo.frame(in: .global).minY
                
                Image("image_06")
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width,
                           height: minY > 0 ? 300 + minY : 300) // 🔥 scroll pastga bo'lsa, cho'ziladi
                    .clipped()
                    .offset(y: minY > 0 ? -minY : 0)// 🔥 scroll yuqoriga bo'lsa, tepaga chiqadi
                    
                VStack {
                    Spacer()
                    Text("Header offset: \(Int(minY))")
                        .foregroundStyle(.white)
                        .font(.title2)
                        .fontWeight(.bold)
                        .position(x: geo.size.width / 2, y: geo.size.height * 0.8)
                }
                .padding()
            }
            .frame(height: 300) // Asl banner balandligi
            
            // 🔻 Quyidagi content
            VStack(spacing: 20) {
                ForEach(0..<15) { i in
                    Text("Content \(i)")
                        .font(.title3)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(10)
                }
            }
            .padding()
        }
        .ignoresSafeArea() // Image status bar orqasiga chiqishi uchun
    }
}


struct ArcadeStickyHeader2View: View {
    @State private var showToolbar: Bool = false
    @State private var opacity: Double = 0

    var body: some View {
        NavigationStack {
            ScrollView {
                GeometryReader { geo in
                    let minY = geo.frame(in: .global).minY
                    
                    ZStack(alignment: .bottom) {
                        GeometryReader { geo in
                            let localMinY = geo.frame(in: .global).minY
                            
                            // 🔻 Banner Image: Scroll pastga – cho‘ziladi
                            Image("image_07")
                                .resizable()
                                .scaledToFill()
                                .frame(width: UIScreen.main.bounds.width,
                                       height: localMinY > 0 ? 400 + localMinY : 400)
                                .clipped()
                                .offset(y: localMinY > 0 ? -localMinY : 0) // 🔥 Scroll pastga – yuqoriga tortiladi
                        }
                        // 🔻 Title va Button
                        if !showToolbar {
                            VStack(spacing: 12) {
                                Text("Arcade")
                                    .font(.largeTitle.bold())
                                    .foregroundColor(.white)
                                
                                Button("Play Now") {
                                    // action
                                }
                                .padding(.horizontal, 24)
                                .padding(.vertical, 10)
                                .background(.white)
                                .foregroundColor(.blue)
                                .clipShape(Capsule())
                            }
//                            .transition(.opacity)
//                            .animation(.easeInOut(duration: 0.9), value: showToolbar)
                            .padding(.bottom, 30)
                        }
                    }
                    .frame(height: 400)
                    .onChange(of: minY < -300) { oldValue, newValue in
//                        withAnimation(.easeInOut(duration: 0.2)) {
//                            showToolbar = newValue
//                            opacity = newValue ? 1 : 0
//                        }
                        showToolbar = newValue
                        opacity = newValue ? 1 : 0
                    }
                }
                .frame(height: 400)
                
                // 🔻 Content
                ForEach(0..<15) { i in
                    Text("Game Content \(i)")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
            }
            .background(.brown)
            .ignoresSafeArea()
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                if showToolbar {
                    // 🔻 Title
                    ToolbarItem(placement: .navigationBarLeading) {
                        Text("Arcade")
                            .font(.headline)
    //                        .opacity(opacity) // 🔥 Fade in/out toolbar title
                    }
                    // 🔻 Button
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Play") {
                            // action
                        }
    //                    .opacity(opacity) // 🔥 Fade in/out toolbar button
                }
                
                }
            }
            // 🔻 Toolbar background rangi (blue or clear)
//            .toolbarBackground(Color.brown, for: .navigationBar)
            .toolbarBackground(showToolbar ? Color.brown.opacity(0.7) : .clear, for: .navigationBar)
                       
            

        }
    }
}

struct ArcadeStickyHeaderView: View {
    @State private var toolbarOpacity: Double = 0.0
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        
        NavigationStack {
            ScrollView {
                BannerView(toolbarOpacity: $toolbarOpacity)
                HorizontalCategoryView()
                // 🔻 Content
                Group {
                    VStack(alignment: .leading) {
                        Text("Top Arcade Games")
                            .font(.title3.bold())
                            .padding(.horizontal)
                        OneByThreePagingView()
                    }
                    VStack(alignment: .leading) {
                        Text("Top Arcade Games")
                            .font(.title3.bold())
                            .padding(.horizontal)
                        OneByThreePagingView()
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Top Arcade Games")
                            .font(.title3.bold())
                            .padding(.horizontal)
                        OneByThreePagingView()
                    }
                }
                .padding(.bottom, 32)
                

                // 🔻 Content
                
                VStack(alignment: .leading) {
                    Text("Top Arcade Games")
                        .font(.title2)
                        .foregroundStyle(.primary)
                        .fontWeight(.bold)
                        .padding(.horizontal)
                    
                    ForEach(0..<15) { i in
                        VStack {
                            Text("Game Content \(i)")
                                .padding(.vertical)
                                .frame(maxWidth: .infinity)
                                .background(Color(.secondarySystemBackground))
                                .cornerRadius(10)
                                .padding(.horizontal, 16)
                            
                            
                            Divider()
                        }
                    }
                }
                
                
            }
            .ignoresSafeArea()
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {

                ToolbarItem(placement: .navigationBarLeading) {
                    VStack(alignment: .leading) {
                        Text("Arcade")
                            .font(.callout)
                            .opacity(toolbarOpacity)
                            .animation(.easeInOut(duration: 0.3), value: toolbarOpacity)
                        Text("1 month free, then $19.99/month.")
                            .font(.caption2)
                            .opacity(toolbarOpacity)
                            .animation(.easeInOut(duration: 0.3), value: toolbarOpacity)
                    }
                    
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Accept Free Trial") {
                        // action
                    }
                    .padding(.horizontal, 12)
                    .foregroundStyle(.white)
                    .font(.caption)
                    .fontWeight(.bold)
                    .background(.blue)
                    .clipShape(Capsule())
                    .opacity(toolbarOpacity)
                    .animation(.easeInOut(duration: 0.3), value: toolbarOpacity)
                }
                
            }
            // 📌 Toolbar Background – fade + glass effekt (ultraThinMaterial)
            .toolbarBackground(
                toolbarOpacity > 0.01 ?
                AnyShapeStyle(Material.regular.opacity(toolbarOpacity)) :
                    AnyShapeStyle(Material.regular.opacity(0)),
                for: .navigationBar
            )
            .toolbarBackground(toolbarOpacity > 0.15 ? .visible : .hidden, for: .navigationBar)
            
            

            

        }
    }
}

// SubViews
struct BannerView: View {
    
    @Binding var toolbarOpacity: Double
    
    var body: some View {
        GeometryReader { geo in
            let minY = geo.frame(in: .global).minY
            let size = geo.size
            ZStack(alignment: .bottom) {
                GeometryReader { geo in
                    let localMinY = geo.frame(in: .global).minY
                    
                    Image("image_03")
                        .resizable()
                        .scaledToFill()
                        .frame(width: UIScreen.main.bounds.width,
                               height: localMinY > 0 ? 500 + localMinY : 500)
                        .clipped()
                        .offset(y: localMinY > 0 ? -localMinY : 0)
                    
                }
                // 🔹 Pastki soyali gradient overlay
                LinearGradient(
                    gradient: Gradient(colors: [.clear, .black.opacity(0.6)]), // yuqorisi shaffof, pasti qora
                    startPoint: .top,
                    endPoint: .bottom
                )
                .frame(height: 400) // faqat pastki qismga
                
                VStack(spacing: 12) {
                    Text("Arcade")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.white.opacity(0.7))
                    Text("Play 200+ Gmaes.\n No In-App Purchases.\n No Ads")
                        .font(.title3.bold())
                        .foregroundStyle(.white)
                        .multilineTextAlignment(.center)
                    
                    Button("Accept Free Trial") {
                        // action
                    }
                    .padding(.vertical, 8)
                    .padding(.horizontal, 42)
                    .foregroundStyle(.white)
                    .font(.body.bold())
                    .background(.blue)
                    .cornerRadius(8)
                    Text("1 month free, then $19.99/month.")
                        .font(.footnote)
                        .foregroundColor(.white.opacity(0.7))
                    
                }
                .padding(.bottom, 30)
            }
            .frame(height: 500)
            .onChange(of: minY) { _, newValue in
                let progress = min(max((abs(newValue) - (size.width * 0.7)) / (size.width * 0.7), 0), 1)
                withAnimation(.easeInOut(duration: 0.2)) {
                    toolbarOpacity = progress
                }
            }
        }
        .frame(height: 500)
    }
}


struct HorizontalCategoryView: View {
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(1..<10) { index in
                    RoundedRectangle(cornerRadius: 8)
                        .fill(colorScheme == .dark ? .gray.opacity(0.2) : .white)
                        .frame(width: 150, height: 35)
                        .overlay(
                            HStack {
                                Image(systemName: "gamecontroller.fill")
                                Text("Category \(index)")
                                    .font(.subheadline)
                                    .foregroundStyle(.primary)
                            }
                        )
                        .shadow(color: .black.opacity(0.15), radius: 3)
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            
        }
    }
}


//

struct OneByThreePagingView: View {
    
    let items = Array(1...20).map { "\($0)" }
    let itemsPerPage = 3

    var pages: [[String]] {
        stride(from: 0, to: items.count, by: itemsPerPage).map {
            Array(items[$0..<min($0 + itemsPerPage, items.count)])
        }
    }

    var body: some View {
        TabView {
            ForEach(pages.indices, id: \.self) { pageIndex in
                VStack(spacing: 16) {
                    ForEach(pages[pageIndex], id: \.self) { item in
                        HStack {
                            Image("image_01")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 50, height: 50)
                                .cornerRadius(8)
                            
                            VStack(alignment: .leading) {
                                HStack {
                                    VStack (alignment: .leading){
                                        Text(item)
                                            .font(.footnote)
                                            .foregroundColor(.primary)
                                            .bold()
                                            
                                        Spacer()
                                        
                                    }
                                    VStack(alignment: .leading) {
                                        Text("Apple Arcade")
                                            .font(.caption2)
                                        Text("MineCraft 2 - CrashSmash")
                                            .font(.subheadline)
                                        Text("Builing Creative Design")
                                            .font(.caption2)
                                            .foregroundStyle(.secondary)
                                    }
                                }
                                Divider()
                            }
                                
                            Button("Get") {
                                // action
                            }
                            .font(.subheadline.bold())
                            .foregroundColor(.accentColor)
                            .padding(.vertical, 6)
                            .padding(.horizontal, 20)
                            .background(.thinMaterial)
                            .clipShape(Capsule())
                            .padding(.bottom, 4)
                           
                        }
                        .frame(height: 50)
                        
                    }
                    
                }
                
                .padding(.horizontal)
            }
        }
        
        .tabViewStyle(.page(indexDisplayMode: .never))
        .frame(height: 190) // 3 x 100 + spacing + padding
        
    }
}


#Preview {
//    GeoReaderView()
//    FrameComparison()
//   ResponsiveBoxView()
 //   ScrollOffsetExample()
 //   CenteredCircleView()
//    ParallaxHeaderView()
//    OneByThreePagingView()
    ArcadeStickyHeaderView()
        .preferredColorScheme(.dark)
}
#Preview {
    ArcadeStickyHeaderView()
}
