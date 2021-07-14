//
//  TaskCellViewModel.swift
//  Reminders
//
//  Created by ishba on 12/07/2021.
//

import Foundation
import Combine


class TaskCellViewModel:ObservableObject,Identifiable {
    
    @Published var task:Task
    @Published var completeIcon = ""
    var id:String = ""
    
    private var cancellables = Set<AnyCancellable>()
    
    static func newTask() -> TaskCellViewModel {
        TaskCellViewModel(task: Task(title: "", priority: .medium, completed: false))
    }
    
    //The value of the id attribute will be updated whenever the task attribute is changed. To make this possible, we annotate the task attribute as @Published,
    init(task: Task){
        self.task = task
        
        $task
            .map{$0.completed ? "checkmark.circle.fill" : "circle"}
            .assign(to: \.completeIcon, on: self)
            .store(in: &cancellables)
        
        $task
            .compactMap{ $0.id}
            .assign(to: \.id, on: self)
            .store(in: &cancellables)
        
    }
}



//struct TaskCellViewModel_Previews: PreviewProvider {
//    static var previews: some View {
//        TaskCellViewModel()
//    }
//}
