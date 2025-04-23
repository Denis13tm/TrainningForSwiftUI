//
//  ModifiersViews.swift
//  TrainningForSwiftUI
//
//  Created by Otabek Tuychiev on 4/23/25.
//

import SwiftUI

struct ModifiersViews: View {
    var body: some View {
        Button(action: {
            print("Tugma bosildi")
        }) {
            Text("Bosish")
        }
        .padding()
        .background(Color.green)
        .cornerRadius(8)
        .onTapGesture {
            print("View bosildi")
        }
    }
}

#Preview {
    ModifiersViews()
}
