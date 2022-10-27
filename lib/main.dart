import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; // Firebase를 사용하기 위한 임포트
import 'package:cloud_firestore/cloud_firestore.dart'; // DB에 저장된 할 일 목록 가져오기

void main() async {
  // Firebase와 연동
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Firebase 초기화
  runApp(MyApp());
}

// 할 일 클래스
class Todo {
  bool isDone;
  String title;

  Todo(this.title, {this.isDone = false}); // 할 일 목록 가져오기
}

// 할 일 관리
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '할 일 관리',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TodoListPage(),
    );
  }
}

class TodoListPage extends StatefulWidget {
  const TodoListPage({Key? key}) : super(key: key);

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  // final _items =
  //     <Todo>[]; // 할 일 목록을 저장할 리스트(리스트 작성시 <Todo>를 앞에 작성하여 Todo 객체를 담는 것을 명시)
  var _todoController = TextEditingController(); // 할 일 문자열 조작을 위한 컨트롤러

  @override
  void dispose() {
    _todoController.dispose(); // 사용이 끝나면 해제
    super.dispose();
  }

  // 할 일 객체를 ListTile 형태로 변경하는 메서드
  Widget _buildItemWidget(DocumentSnapshot doc) {
    // Firestore 문서는 DocumentSnapshot 클래스의 인스턴스이기 때문에 이를 받아서 Todo 객체를 생성
    final todo = Todo(doc['title'], isDone: doc['isDone']);

    return ListTile(
      onTap: () => _toggleTodo(doc), // Todo: 클릭 시 완료/미완료되도록 수정
      title: Text(
        todo.title, // 할 일
        style: todo.isDone // 완료일 때는 스타일 적용
            ? TextStyle(
                decoration: TextDecoration.lineThrough, // 취소선
                fontStyle: FontStyle.italic, // 이탤릭체
              )
            : null, // 아무 스타일도 적용 안함
      ),
      trailing: IconButton(
        icon: Icon(Icons.delete_forever),
        onPressed: () => _deleteTodo(doc), // Todo: 쓰레기통 클릭시 삭제되도록 수정
      ),
    );
  }

  // 할 일 추가 메서드
  void _addTodo(Todo todo) {
    // 할 일 추가하기
    FirebaseFirestore.instance.collection('todo').add({
      'title': todo.title,
      'isDone': todo.isDone
    }); // add() 메서드에는 Map 형식으로 데이터를 작성함
    _todoController.text = '';

    // setState(() {
    //   _items.add(todo);
    //   _todoController.text=''; // 할 일 입력 필드를 비움
    // });
  }

  // 할 일 삭제 메서드
  void _deleteTodo(DocumentSnapshot doc) {
    FirebaseFirestore.instance.collection('todo').doc(doc.id).delete();

    // setState(() {
    //   _items.remove(todo);
    // });
  }

  // 할 일 완료/미완료 메서드
  void _toggleTodo(DocumentSnapshot doc) {
    // 특정 문서를 업데이트하려면 문서 ID가 필요한데 DocumentSnapshot을 통해 문서 ID를 얻을 수 있으며 doc() 메서드에 인수로 전달하고 update()메서드에 수정하고자 하는 내용을 Map형태로 전달하면 자료가 업데이트됨
    FirebaseFirestore.instance.collection('todo').doc(doc.id).update({
      'isDone': !doc['isDone'],
    });

    // setState(() {
    //   todo.isDone = !todo.isDone;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('남은 할 일'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _todoController,
                  ),
                ),
                ElevatedButton(
                  onPressed: () => _addTodo(Todo(_todoController.text)),
                  // 기능과 UI 연결
                  child: Text('추가'),
                ),
              ],
            ),
            StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection('todo').snapshots(),
                // todo 컬렉션에 있는 모든 문서를 스트림으로 얻음 스트림은 자료가 변경되었을 때 반응하여 화면을 다시 그려줌
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    // snapshot에는 데이터를 포함하여 다양한 정보가 들어있음
                    return CircularProgressIndicator();
                  }
                  final documents = snapshot.data!.docs; // 모든 문서를 얻음
                  return Expanded(
                    child: ListView(
                      children: documents
                          .map((doc) => _buildItemWidget(doc))
                          .toList(), // 전체 UI와 할 일 목록 UI 결합
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
