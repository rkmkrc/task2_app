//
//  HourAndMinutePicker.swift
//  task2_app
//
//  Created by Erkam Karaca on 28.08.2023.
//

import SwiftUI

struct HourAndMinutePicker: View {
    @Binding var selectedHour: Int
    @Binding var selectedMinute: Int
    
    var body: some View {
        HStack {
            VStack {
                Text("Hour:")
                Picker("Select Hour", selection: $selectedHour) {
                    ForEach(0..<24, id: \.self) { hour in
                        Text("\(formattedHourAndMinute(hour))")
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .frame(maxWidth: 100, maxHeight: 100)
            }
            VStack {
                Text("Minute:")
                Picker("Select Minute", selection: $selectedMinute) {
                    ForEach(0..<60, id: \.self) { minute in
                        Text("\(formattedHourAndMinute(minute))")
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .frame(maxWidth: 100, maxHeight: 100)
            }
        }
    }
}

func formattedHourAndMinute(_ hour: Int) -> String {
    return String(format: "%02d", hour)
}
