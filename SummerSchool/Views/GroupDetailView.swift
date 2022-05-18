//
//  GroupDetailView.swift
//  SummerSchool
//
//  Created by Juan Carlos Sánchez Gutiérrez on 18/05/22.
//

import SwiftUI

struct GroupDetailView: View {
    var group: Group
    var action: () -> Void
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 10) {
                Text(self.group.nombre)
                Text(self.group.lugares != 0 ? "Lugares Disponibles: \(self.group.lugares)" : "Clase llena")
                    .fontWeight(.light)
            }
            Spacer()
            Button {
                self.action()
            } label: {
                Text("Inscribirse")
                    .foregroundColor(Color.white)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .foregroundColor(Color.blue)
                    )
            }
        }
    }
}
