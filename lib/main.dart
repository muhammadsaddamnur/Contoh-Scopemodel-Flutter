import 'package:contohscopemodel/models/user.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

void main() => runApp(new MyApp(
      user: User(),
    ));

class MyApp extends StatelessWidget {
  final User user;

  const MyApp({Key key, this.user}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScopedModel<User>(
        model: user,
        child: new MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: new MyHomePage(title: 'Flutter Demo Home Page'),
    ));
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: Center(
        child: ScopedModelDescendant<User>(
            builder: (context, child, model){
              return Text(model.name);
            }
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ChangeNamePage())),
          child: Icon((Icons.navigate_next)),
      ),
    );
  }
}


class ChangeNamePage extends StatefulWidget {
  @override
  _ChangeNamePageState createState() => _ChangeNamePageState();
}

class _ChangeNamePageState extends State<ChangeNamePage> {
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ScopedModelDescendant<User>(
            builder: (context, child, model){
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: model.name
                    ),
                  ),
                  RaisedButton(
                    onPressed: (){
                      model.changeName(_nameController.text);
                      setState(() {
                        _nameController.text = '';
                      });
                      Scaffold.of(context).showSnackBar(
                        SnackBar(content: Text('Name Change to ${model.name}'))
                      );
                    },
                    child: Text('change name'),
                  )
                ],
              );
            },
          ),
      ),
    );
  }
}

