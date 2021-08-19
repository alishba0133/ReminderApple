//
//  TaskListView.swift
//  Reminders
//
//  Created by ishba on 13/07/2021.
//

import SwiftUI

struct TaskListView: View {
    @ObservedObject var taskListVM = TaskListViewModel()
    @State var presentAddNewItem = false

    
    var body: some View {
      NavigationView {
        VStack(alignment: .leading) {
          List {
            //taskcellviewmodel identifiable karou
            ForEach(taskListVM.taskCellViewModels) { taskListVM in
                TaskCell(taskCellVM: taskListVM)
            }
            .onDelete { indexSet in
              self.taskListVM.removeTasks(atOffsets: indexSet)
            }
            if presentAddNewItem { // (5)
                TaskCell(taskCellVM: TaskCellViewModel.newTask()) { result in // (2)
                if case .success(let task) = result {
                  self.taskListVM.addTask(task: task) // (3)
                }
                self.presentAddNewItem.toggle() // (4)
              }
            }
          }
          Button(action: { self.presentAddNewItem.toggle() }) { // (6)
            HStack {
              Image(systemName: "plus.circle.fill")
                .resizable()
                .frame(width: 20, height: 20)
              Text("New Task")
            }
          }
          .padding()
          .accentColor(Color(UIColor.systemRed))
        }
        .navigationBarTitle("Tasks")
      }
    }
}

struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView()
    }
}

enum InputError: Error {
    case empty
}

struct TaskCell: View  {
    
    @State private var isEditing:Bool = false
    @State private var isPresented:Bool = false
    @ObservedObject var taskCellVM: TaskCellViewModel
    var onCommit: (Result<Task, InputError>) -> Void = { _ in }
    
    var body: some View {
        HStack{
            Image(systemName: taskCellVM.completeIcon)
                .resizable()
                .frame(width: 20, height: 20)
                .onTapGesture {
                    taskCellVM.task.completed.toggle()
                }
            TextField("Enter task title", text: $taskCellVM.task.title,
                      onEditingChanged :{ (editingChanged) in
                        if editingChanged {
                            isEditing=true
                        } else {
                            isEditing=false
                        }
                      },
                      //on commit is called when user presser return key
                      onCommit: {
                        if !self.taskCellVM.task.title.isEmpty{
                            self.onCommit(.success(taskCellVM.task))
                        } else {
                            onCommit(.failure(.empty))
                        }
                      }).id(taskCellVM.id)
            if isEditing {
                Button(action: {
                    isPresented.toggle()
                }, label: {
                    Image(systemName: "info.circle")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(Color(UIColor.systemBlue))
                })
            }
        }
        .sheet(isPresented: $isPresented){
            NavigationView {
                TaskEditorView()
                    .navigationBarTitle(Text("Details"), displayMode: .inline)
                    .navigationBarItems(leading: Button("Cancel"){
                        isPresented = false
                    },trailing: Button("Done"){
                        isPresented = false
                    })
            }
        }

    }
}

