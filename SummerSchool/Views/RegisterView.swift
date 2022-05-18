//
//  RegisterView.swift
//  SummerSchool
//
//  Created by Juan Carlos Sánchez Gutiérrez on 18/05/22.
//

import SwiftUI

struct RegisterView: View {
    @EnvironmentObject var sVM: SchoolViewModel
    @State var matricula: String = ""
    @State var nombre: String = ""
    @State var showAlert: Bool = false
    @State var alertText: String = "Esto es un error"
    var group: Group
    @Binding var showRegisterView: Bool
    var body: some View {
        VStack(spacing: 20) {
            CustomTextField(placeholder: "matricula", textValue: self.$matricula)
            CustomTextField(placeholder: "nombre", textValue: self.$nombre)
            Button {
                self.enrollStudent()
            } label: {
                Text("Registrar Alumno")
                    .foregroundColor(Color.white)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .foregroundColor(Color.blue)
                    )
            }
            Spacer()
        }
        .navigationTitle("\(self.group.nombre)")
        .alert(isPresented: self.$showAlert) {
            Alert(title: Text("Error"), message: Text(self.alertText), dismissButton: .default(Text("Ok")))
        }
    }
    
    func setAlert(message: String) {
        self.alertText = message
        self.showAlert.toggle()
    }
    
    func validateFields() -> Bool {
        return ( self.matricula != "" && self.nombre != "" )
    }
    
    func enrollStudent() {
        if self.validateFields() {
            let student = Student(matricula: self.matricula, nombre: self.nombre)
            sVM.enrollStudent(body: student, subject: self.group.curso) { result in
                if !result.errorStatus {
                    self.setAlert(message: result.errorMessage)
                } else {
                    self.sVM.getGroups()
                    self.showRegisterView.toggle()
                }
            }
        } else {
            self.setAlert(message: "Todos los campos tienen que tener datos")
        }
    }
    
}
