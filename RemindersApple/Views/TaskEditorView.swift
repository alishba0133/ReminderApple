//
//  TaskEditorView.swift
//  ReminderApple
//
//  Created by ishba on 14/07/2021.
//

import SwiftUI

struct TaskEditorView: View {
    //Instead, our modal view’s environment has a property called presentation mode, which tells us whether the sheet is visible and, more importantly, gives us a command to close it
   // @Environment(\.presentationMode) var presentation
    
    @State var showDatePicker:Bool = false
    @State var showTimePicker:Bool = false
    @State private var date  = Date()
    
    var body: some View {
        Form {
            Section {
                Text("Task title")
                Text("Notes")
                Text("URL")
            }
            Section {
                VStack {
                    HStack {
                        Image(systemName: "calendar")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.red)
                            .padding([.trailing], 5)
                        Toggle("Date", isOn: $showDatePicker)
                    }
                        
                    if showDatePicker {
                        DatePickerView(date: $date  )
                    }
                    
                    HStack {
                        Image(systemName: "timer.square")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(Color(UIColor.systemBlue))
                            .padding([.trailing], 5)
                        Toggle("Time", isOn: $showTimePicker)
                    }
                    if showTimePicker {
                       TimePickerView(date: $date)
                    }
                }
            }
        }
    }
}


struct TimePickerView: View {
    
    @Binding var date: Date
    
    var body: some View {
        DatePicker ("", selection: $date, displayedComponents: [.hourAndMinute])
            .datePickerStyle(GraphicalDatePickerStyle())
            .font(.system(.body, design: .serif))
        
    }
}


struct DatePickerView:View {
    
    @Binding var date: Date
    
    var body: some View {
        DatePicker ("", selection: $date, displayedComponents: [.date])
            .datePickerStyle(GraphicalDatePickerStyle())
    }
    
}


struct TaskEditorView_Previews: PreviewProvider {
    static var previews: some View {
        TaskEditorView()
    }
}
