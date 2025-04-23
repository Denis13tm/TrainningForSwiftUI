//
//  Conditional.swift
//  TrainningForSwiftUI
//
//  Created by Otabek Tuychiev on 4/22/25.
//

import SwiftUI

// MARK: - Conditional Views -> if, switch, group, anyView

struct ConditionalViews: View {
    var body: some View {
        Text("Hello, World!")
    }
}


// if, if + else

struct IfElseExample: View {
    @State private var score = Int.random(in: 1..<100)

    var body: some View {
        VStack {
            if score > 90 {
                Text("Excellent")
            } else if score > 60 {
                Text("Good")
            } else {
                Text("So bad \nTry again")
            }
        }
    }
}

// switch -

struct SwitchExample: View {
    enum Page { case home, profile, settings }

    @State private var currentPage: Page = .home

    var body: some View {
        VStack(spacing: 20) {
            switch currentPage {
            case .home:
                Text("Home View")
            case .profile:
                Text("Profile View")
            case .settings:
                Text("Settings View")
            }

            HStack {
                Button("Home") { currentPage = .home }
                Button("Profile") { currentPage = .profile }
                Button("Settings") { currentPage = .settings }
            }
        }
    }
}

// group - ichidagi barcha view’ga umumiy modifierlar qo‘llanadi.

struct GroupExample: View {
    var body: some View {
        Group {
            Text("Line 1")
            Text("Line 2")
            Text("Line 3")
        }
        .foregroundColor(.blue)
        .font(.title)
    }
}

// MARK: -  AnyView -  turini yashirish/ type erasure (rare case)
//🔷 AnyView nima?
//SwiftUI’da View — bu associatedtypega ega protocol, ya’ni har bir Viewning aniq turi bor. Lekin ba'zida bir nechta turdagi View’larni bitta container ichida saqlash yoki return qilish kerak bo‘ladi.

//⚠️ Swift bunday holatlarda xatolik beradi, chunki View turi aniq bo‘lishi kerak.

//Shu joyda AnyView yordam beradi: u har qanday View turini o‘ziga “o‘rab” oladi, va shunchaki AnyView sifatida ko‘rish mumkin bo‘ladi. Bu type erasure deyiladi.


//@ViewBuilder — bu SwiftUI’da View’larni ko‘plikda qaytarish uchun ishlatiladigan special atribut. Bu yordamida biz if, switch, yoki Group kabi ko‘p holatli view’larni yozganimizda return bilan muammoga uchramaymiz.

struct AnyViewExample: View {
    @State private var toggle = true

    var body: some View {
        VStack(spacing: 20) {
            getView()
            Button("Toggle") { toggle.toggle() }
        }
    }

    @ViewBuilder // ⚠️ Eslatma: AnyView kamdan-kam holatlarda kerak bo‘ladi, chunki u performance’ga salbiy ta’sir qilishi mumkin. @ViewBuilder yordamida ko‘p hollarda AnyView o‘rnini bosish mumkin.
    func getView() -> some View {
        if toggle {
            AnyView(Text("First View").foregroundColor(.red))
        } else {
            AnyView(Image(systemName: "star").foregroundColor(.blue))
        }
    }
}


#Preview {
//    ConditionalViews()
//    IfElseExample()
//    SwitchExample()
//    GroupExample()
    AnyViewExample()
}
