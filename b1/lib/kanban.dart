import 'package:flutter/material.dart';

// void main() {
//   runApp(const MyApp());
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kanban Board',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const KanbanBoard(),
    );
  }
}

class KanbanBoard extends StatefulWidget {
  const KanbanBoard({super.key});

  @override
  State<KanbanBoard> createState() => _KanbanBoardState();
}

class _KanbanBoardState extends State<KanbanBoard> {
  final List<String> toDo = ['Task 1', 'Task 2'];
  final List<String> inProgress = ['Task 3'];
  final List<String> done = ['Task 4'];
  String? selectedTask;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kanban Board'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _displayAddTaskDialog(context),
          ),
        ],
      ),
      body: Row(
        children: [
          buildColumn('To Do', toDo, 0),
          buildColumn('In Progress', inProgress, 1),
          buildColumn('Done', done, 2),
        ],
      ),
    );
  }

  Widget buildColumn(String title, List<String> tasks, int columnIndex) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            Expanded(
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedTask = tasks[index];
                      });
                    },
                    child: Container(
                      color: selectedTask == tasks[index]
                          ? Colors.blue[100]
                          : null,
                      child: buildTaskCard(tasks[index]),
                    ),
                  );
                },
              ),
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (columnIndex > 0)
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => moveTaskBack(tasks),
                  ),
                if (columnIndex < 2)
                  IconButton(
                    icon: const Icon(Icons.arrow_forward),
                    onPressed: () => moveTaskForward(tasks),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void moveTaskBack(List<String> tasks) {
    if (selectedTask != null && tasks.contains(selectedTask)) {
      setState(() {
        if (inProgress.contains(selectedTask)) {
          inProgress.remove(selectedTask);
          toDo.add(selectedTask!);
        } else if (done.contains(selectedTask)) {
          done.remove(selectedTask);
          inProgress.add(selectedTask!);
        }
      });
    }
  }

  void moveTaskForward(List<String> tasks) {
    if (selectedTask != null && tasks.contains(selectedTask)) {
      setState(() {
        if (toDo.contains(selectedTask)) {
          toDo.remove(selectedTask);
          inProgress.add(selectedTask!);
        } else if (inProgress.contains(selectedTask)) {
          inProgress.remove(selectedTask);
          done.add(selectedTask!);
        }
      });
    }
  }

  Widget buildTaskCard(String task) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(task),
      ),
    );
  }

  Future<void> _displayAddTaskDialog(BuildContext context) async {
    String newTask = '';

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add a new task'),
          content: TextField(
            onChanged: (value) {
              setState(() {
                newTask = value;
              });
            },
            decoration: const InputDecoration(hintText: "Enter task name"),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Add'),
              onPressed: () {
                setState(() {
                  toDo.add(newTask);
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
