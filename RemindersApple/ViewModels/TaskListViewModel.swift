//
//  TaskListViewModel.swift
//  Reminders
//
//  Created by ishba on 12/07/2021.
//

import Foundation


class TaskListViewModel: ObservableObject {
    
    @Published var taskCellViewModels = [TaskCellViewModel]()
    
    init() {
        taskCellViewModels = testDataTasks.map { task in
            TaskCellViewModel(task: task)
        }
    }
    
    func removeTasks(atOffsets indexSet: IndexSet){
        taskCellViewModels.remove(atOffsets: indexSet)
    }
    
    func addTask(task: Task){
        taskCellViewModels.append(TaskCellViewModel(task: task))
    }
    
}



//struct TaskListViewModel_Previews: PreviewProvider {
//    static var previews: some View {
//        TaskListViewModel()
//    }
//}
