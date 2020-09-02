import 'package:sailor/sailor.dart';
import 'package:todo_app/screens/todo_create_screen.dart';
import 'package:todo_app/screens/todo_details_screen.dart';
import 'package:todo_app/screens/todo_screen.dart';

class Routes {
  static final sailor = Sailor();

  static const String ROUTE_CREATE_TODO = "/create_todo";
  static const String ROUTE_EDIT_TODO = "/edit_todo";
  static const String ROUTE_DETAILS_TODO = "/details_todo";

  static void createRoutes() {
    sailor.addRoutes([
          SailorRoute(
            name: ROUTE_CREATE_TODO,
            builder: (context, args, params) {
                return ToDoCreateScreen();
              },
            ),
          SailorRoute(
              name: ROUTE_EDIT_TODO,
              builder: (context, args, params) {
                return ToDoScreen();
              },
          ),
          SailorRoute(
            name: ROUTE_DETAILS_TODO,
            builder: (context, args, params) {
              return ToDoDetailsScreen();
            },
          )
  ]);
  }
}