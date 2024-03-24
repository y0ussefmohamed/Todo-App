import SwiftUI

struct TaskView: View
{
    let taskTitle: String
    let taskIsDone: Bool
    
    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: taskIsDone ? "checkmark.circle" : "circle")
                .foregroundColor(taskIsDone ? .green : .black)
            
            Text(taskTitle)
                .strikethrough(taskIsDone)
                .foregroundColor(taskIsDone ? .green : .black)
        }
    }
}

#Preview {
    TaskView(taskTitle: "First Task", taskIsDone: false)
}
