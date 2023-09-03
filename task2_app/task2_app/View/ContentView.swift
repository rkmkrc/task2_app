//
//  ContentView.swift
//  task2_app
//
//  Created by Erkam Karaca on 28.08.2023.
//

import SwiftUI
import UserNotifications

struct ContentView: View {
    
    @State var selectedHour: Int = Calendar.current.component(.hour, from: Date())
    @State var selectedMinute: Int = Calendar.current.component(.minute, from: Date())
    @State private var showAlert = false
    
    var body: some View {
        VStack {
            Spacer()
            HourAndMinutePicker(selectedHour: $selectedHour, selectedMinute: $selectedMinute)
                .padding(30)
            Spacer()
            Button(action: {
                NotificationViewModel.shared.checkForPermission(selectedHour: selectedHour, selectedMinute: selectedMinute) { success in
                    if success {
                        showAlert = true
                    }
                }
            }) {
                Text("Set Alarm")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(25)
            }
            Spacer()
        }
        .padding()
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Success"),
                message: Text("Alarm scheduled successfully."),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}
