//
//  MainView.swift
//  SummerSchool
//
//  Created by Juan Carlos Sánchez Gutiérrez on 18/05/22.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var sVM: SchoolViewModel
    @State var showRegisterView: Bool = false
    @State var subjectSelected : Group = Group(curso: "", nombre: "", lugares: 0, alumnos: nil)
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(spacing: 20) {
                NavigationLink(isActive: self.$showRegisterView) {
                    RegisterView(group: self.subjectSelected, showRegisterView: self.$showRegisterView)
                        .padding()
                        .environmentObject(self.sVM)
                } label: {  EmptyView() }

                if self.sVM.availableGroups != [] {
                    ForEach(self.sVM.availableGroups, id: \.self) { group in
                        if sVM.availableGroups[0] != group {
                            Divider()
                        }
                        GroupDetailView(group: group) {
                            self.subjectSelected = group
                            self.showRegisterView.toggle()
                        }

                    }
                } else {
                    Text("No hay clases disponibles")
                        .font(.title2)
                        .fontWeight(.semibold)
                }
                Spacer()
            }
            .padding()
        }
        .navigationTitle("Cursos de Verano")
        .onAppear {
            self.sVM.getGroups()
        }
    }
}
