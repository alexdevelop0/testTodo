import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoApp/provider/todos.dart';
import 'package:todoApp/widget/todo_widget.dart';

class TodoListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TodosProvider>(context);
    final todos = provider.todos;

    return 
    
   Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
      SizedBox(height: 60,),
Container(margin: EdgeInsets.only(left: 20,right: 20),child:Text(
              'Tareas',
              style: TextStyle(fontSize: 45,color: Colors.black),
            )),
                        SizedBox(height: 10,),
            Container(margin: EdgeInsets.only(left: 20,right: 20),child:Text(
            "Disponibles",
              style: TextStyle(fontSize: 20,color: Colors.black),
            )),
            SizedBox(height: 40,),
 Container(
       decoration: BoxDecoration(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(40),
        topLeft: Radius.circular(40),
      ),
      color: Colors.white
    
    ),
       child:Container(child:todos.isEmpty
        ? Center(
            child: Text(
              'No hay tareas pendientes :)',
              style: TextStyle(fontSize: 20),
            ),
          )
        : ListView.separated(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.all(16),
            shrinkWrap: true,
            
            separatorBuilder: (context, index) => Container(height: 8),
            itemCount: todos.length,
            itemBuilder: (context, index) {
              final todo = todos[index];

              return TodoWidget(todo: todo);
            },
          ) ,))

   ],) 
    ;
  }
}
