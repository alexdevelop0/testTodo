import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todoApp/model/todo.dart';
import 'package:todoApp/page/edit_todo_page.dart';
import 'package:todoApp/provider/todos.dart';
import 'package:todoApp/utils.dart';
import 'package:translator/translator.dart';

class TodoWidget extends StatelessWidget {
  final Todo todo;

  const TodoWidget({
    @required this.todo,
    Key key,
  }) : super(key: key);
 

  @override
  Widget build(BuildContext context) => ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Slidable(
          actionPane: SlidableDrawerActionPane(),
          key: Key(todo.id),
          actions: [
            IconSlideAction(
              color: Colors.green,
              onTap: () => editTodo(context, todo),
              caption: 'Edit',
              icon: Icons.edit,
            )
          ],
          secondaryActions: [
            IconSlideAction(
              color: Colors.red,
              caption: 'Delete',
              onTap: () => deleteTodo(context, todo),
              icon: Icons.delete,
            )
          ],
          child: buildTodo(context),
        ),
      );

  Widget buildTodo(BuildContext context) => GestureDetector(
        onTap: () => editTodo(context, todo),
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.all(20),
          child: Row(
            children: [
              Checkbox(
                activeColor: Theme.of(context).primaryColor,
                checkColor: Colors.white,
                value: todo.isDone,
                onChanged: (_) {
                  final provider =
                      Provider.of<TodosProvider>(context, listen: false);
                  final isDone = provider.toggleTodoStatus(todo);

                  Utils.showSnackBar(
                    context,
                    isDone ? 'Tarea completada' : 'Tarea incompleta',
                  );
                },
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      todo.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                    if (todo.description.isNotEmpty)
                      Container(
                        margin: EdgeInsets.only(top: 2),
                        child: Text(
                          todo.description,
                          style: TextStyle(fontSize: 18, height: 1.5,color:Colors.grey),
                        ),
                      )


                      ,
                      GestureDetector(onTap: (){
                        final translator = GoogleTranslator();
                  
                      
executeTraslate(String code){
  Navigator.pop(context);
  translator.translate(todo.title, to: code).then((valueTitle) {

 translator.translate(todo.description, to: code).then((valueDescription) {


   showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title:  Text("Titulo: "+valueTitle.toString()),
          content:  Text("Descripción: "+valueDescription.toString()),
          actions: <Widget>[
          
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      );
 });


   });


}
   // set up the list options
  Widget optionOne = SimpleDialogOption(
    child: const Text('Español'),
    onPressed: () {


      executeTraslate("es");
    },
  );
  Widget optionTwo = SimpleDialogOption(
    child: const Text('Ingles'),
    onPressed: () {
         executeTraslate("en");
    },
  );
  Widget optionThree = SimpleDialogOption(
    child: const Text('chino'),
    onPressed: () {


         executeTraslate('zh-cn');
    },
  );
  Widget optionFour = SimpleDialogOption(
    child: const Text('portuges'),
    onPressed: () {

          executeTraslate('pt');
    },
  );
 

  // set up the SimpleDialog
  SimpleDialog dialog = SimpleDialog(
    title: const Text("Seleccionar idioma"),
    children: <Widget>[
      optionOne,
      optionTwo,
      optionThree,
      optionFour,
      
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return dialog;
    },
  );
                      },child:
                      Container(
                        margin: EdgeInsets.only(top: 2),
                        child: Text(
                          "Traducir",
                          
                          style: TextStyle(fontSize: 20, height: 1.5,color:Colors.grey,  decoration: TextDecoration.underline,),
                        ),
                      ))
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  void deleteTodo(BuildContext context, Todo todo) {
    final provider = Provider.of<TodosProvider>(context, listen: false);
    provider.removeTodo(todo);

    Utils.showSnackBar(context, 'Deleted the task');
  }

  void editTodo(BuildContext context, Todo todo) => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => EditTodoPage(todo: todo),
        ),
      );
}
