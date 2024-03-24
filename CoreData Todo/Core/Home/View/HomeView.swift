import SwiftUI

struct HomeView: View 
{
    @ObservedObject var viewModel = CoreDataViewModel.shared
    @State var showAddTaskViewSheet: Bool = false
    
    var body: some View {
        ZStack {
            Color(hue:0.086, saturation: 0.141, brightness: 0.972).ignoresSafeArea(edges: .all)
            VStack {
                HStack {
                    Text("My Tasks")
                        .foregroundStyle(.black)
                        .font(.title)
                        .fontWeight(.heavy)
                    Spacer()
                }
                .padding()
                
                
                List {
                    ForEach(viewModel.tasks) { task in
                        TaskView(taskTitle: task.title!, taskIsDone: task.isDone)
                            .onTapGesture {
                                viewModel.updateTask(entity: task)
                            }
                    }
                    .onDelete { indexSet in
                        withAnimation {
                            viewModel.deleteTask(offsets: indexSet)
                        }
                    }
                    .listRowSeparator(.hidden)
                    .listRowBackground(.some(Color.white))
                    
                    
                }
                .scrollContentBackground(.hidden)
                .listStyle(.sidebar)
                .onAppear {
                    UITableView.appearance().backgroundColor = UIColor.clear
                    UITableViewCell.appearance().backgroundColor = UIColor.clear
                }
            
                HStack {
                    Spacer()
                    
                    Button {
                        showAddTaskViewSheet.toggle()
                    } label: {
                        ZStack {
                            Circle()
                                .frame(width: 60, height: 60)
                                .foregroundStyle(Color(.systemGreen))
                            Image(systemName: "plus")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .bold()
                                .foregroundStyle(.white)
                        }
                    }
                    
                }
                .padding()
                
                Spacer()
            }
        }
        .sheet(isPresented: $showAddTaskViewSheet, content: {
            AddTaskView()
        })
    }
}

#Preview {
    HomeView()
}
