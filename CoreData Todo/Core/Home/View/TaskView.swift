import SwiftUI

struct TaskView: View
{
    let taskTitle: String
    let taskIsDone: Bool
    
    var body: some View {
        
        HStack(spacing: 20) {
            
            Image(systemName: taskIsDone ? "checkmark.circle" : "circle")
                .foregroundColor(taskIsDone ? .green : .primary)
            
            Text(taskTitle)
                .strikethrough(taskIsDone)
            
        }
        
    }
}

#Preview {
    TaskView(taskTitle: "One", taskIsDone: false)
}
