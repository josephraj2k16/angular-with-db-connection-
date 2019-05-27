import './animated_fab.dart';
import './diagonal_clipper.dart';
import './initial_list.dart';
import './list_model.dart';
import './task_row.dart';
import 'package:flutter/material.dart';
import'./drawer.dart';



//void main() => runApp(new MyApp());


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        //backgroundColor: Colors.transparent,
        backgroundColor: Color.fromRGBO(225, 228, 229, 1.0),
        scaffoldBackgroundColor: Color.fromRGBO(225, 228, 229, 1.0),
        primarySwatch: Colors.lightGreen,
      ),
      home: new MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  MainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() => new _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final GlobalKey<AnimatedListState> _listKey =
      new GlobalKey<AnimatedListState>();
  final double _imageHeight = 256.0;
  ListModel listModel;
  bool showOnlyCompleted = false;

  @override
  void initState() {
    super.initState();
    listModel = new ListModel(_listKey, tasks);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      drawer:
        new DrawerOnly(),//imported from drawer.dart
      appBar: new AppBar(
        title: new Text("Medi Assist"),
        backgroundColor: Colors.transparent,
      ),
      body: new Stack(
        children: <Widget>[
          //_buildDrawer(),
          _buildTimeline(),
          _buildIamge(),
          //_buildTopHeader(),
          _buildProfileRow(),
          //_buildStepper(),
          _buildBottomPart(),

          //_buildFab(),
        ],
      ),
    );
  }

  Widget _buildTopHeader() {
    return new Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 32.0),
      child: new Row(
        children: <Widget>[

           GestureDetector(
              onTap: (){
                debugPrint("MenuGest is clicked");
              },
              child:new Icon(Icons.menu, size: 32.0, color: Colors.white),
          ),


          new Expanded(
            child: new Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: new Text(
                "Timeline",
                style: new TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w300),
              ),
            ),
          ),
          new Icon(Icons.linear_scale, color: Colors.white),
        ],
      ),
    );
  }

  Drawer _buildDrawer() {
    return new Drawer(
          elevation: 20.0,
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text('Hammad Tariq'),
                accountEmail: Text('developine.com@gmail.com'),
                currentAccountPicture:
                Image.network('https://hammad-tariq.com/img/profile.png'),
                decoration: BoxDecoration(color: Colors.blueAccent),
              ),
            ],
          ));


  }
  Widget _buildFab() {
    return new Positioned(
        top: _imageHeight - 100.0,
        right: -40.0,
        child: new AnimatedFab(
          onClick: _changeFilterState,
        ));
  }

  void _changeFilterState() {
    showOnlyCompleted = !showOnlyCompleted;
    tasks.where((task) => !task.completed).forEach((task) {
      if (showOnlyCompleted) {
        listModel.removeAt(listModel.indexOf(task));
      } else {
        listModel.insert(tasks.indexOf(task), task);
      }
    });
  }

  Widget _buildIamge() {
    return new Positioned.fill(
      bottom: null,
      child: new ClipPath(
        clipper: new DialogonalClipper(),
        child: new Image.asset(
          'images/medicationPill.jpg',
          fit: BoxFit.cover,
          height: _imageHeight,
          colorBlendMode: BlendMode.srcOver,
          color: new Color.fromARGB(120, 20, 10, 40),
        ),
      ),
    );
  }




//Widget menuButton() {
//    return Scaffold(
//      floatingActionButton: FloatingActionButton(onPressed: (){
//        debugPrint("menu clicked");
//      },
//      tooltip: 'Menu Bar',
//      child: new Icon(Icons.menu, size: 32.0, color: Colors.white),
//      ),
//    );
//
//}

  Widget _buildProfileRow() {
    return new Padding(
      padding: new EdgeInsets.only(left: 16.0, top: _imageHeight / 2.5),
      child: new Row(
        children: <Widget>[
          new CircleAvatar(
            minRadius: 28.0,
            maxRadius: 28.0,
            backgroundImage: new AssetImage('images/patientpic.jpg'),
          ),
          new Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                new Text(
                  'Patient Name',
                  style: new TextStyle(
                      fontSize: 26.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w400),
                ),
                new Text(
                  'Fever Patient',
                  style: new TextStyle(
                      fontSize: 14.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w300),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomPart() {
    return new Padding(
      padding: new EdgeInsets.only(top: _imageHeight),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildMyTasksHeader(),
          _buildTasksList(),
        ],
      ),
    );
  }

  Widget _buildTasksList() {
    return new Expanded(
      child: new AnimatedList(
        initialItemCount: tasks.length,
        key: _listKey,
        itemBuilder: (context, index, animation) {
          return new TaskRow(
            task: listModel[index],
            animation: animation,
          );
        },
      ),
    );
  }

  Widget _buildMyTasksHeader() {
    return new Padding(
      padding: new EdgeInsets.only(left: 64.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Text(
            'My Prescriptions',
            style: new TextStyle(fontSize: 30.0),
          ),
          new Text(
            'MAY 22, 2019',
            style: new TextStyle(color: Colors.grey, fontSize: 12.0),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeline() {
    return new Positioned(
      top: 0.0,
      bottom: 0.0,
      left: 32.0,
      child: new Container(
        width: 1.0,
        color: Colors.grey[300],
      ),
    );
  }

  Widget _buildStepper() {
    int current_step = 0;
    List<Step> my_steps = [
      new Step(
          // Title of the Step
          title: new Text("Step 1"),
          // Content, it can be any widget here. Using basic Text for this example
          content: new Text("Hello!"),
          isActive: true),
      new Step(
          title: new Text("Step 2"),
          content: new Text("World!"),
          // You can change the style of the step icon i.e number, editing, etc.
          state: StepState.editing,
          isActive: true),
      new Step(
          title: new Text("Step 3"),
          content: new Text("Hello World!"),
          isActive: true),
    ];

    return new Stepper(
      // Using a variable here for handling the currentStep
      currentStep: current_step,
      // List the steps you would like to have
      steps: my_steps,
      // Define the type of Stepper style
      // StepperType.horizontal :  Horizontal Style
      // StepperType.vertical   :  Vertical Style
      type: StepperType.vertical,
      // Know the step that is tapped
      onStepTapped: (step) {
        // On hitting step itself, change the state and jump to that step
        setState(() {
          // update the variable handling the current step value
          // jump to the tapped step
          current_step = step;
        });
        // Log function call
        print("onStepTapped : " + step.toString());
      },
      onStepCancel: () {
        // On hitting cancel button, change the state
        setState(() {
          // update the variable handling the current step value
          // going back one step i.e subtracting 1, until its 0
          if (current_step > 0) {
            current_step = current_step - 1;
          } else {
            current_step = 0;
          }
        });
        // Log function call
        print("onStepCancel : " + current_step.toString());
      },
      // On hitting continue button, change the state
      onStepContinue: () {
        setState(() {
          // update the variable handling the current step value
          // going back one step i.e adding 1, until its the length of the step
          if (current_step < my_steps.length - 1) {
            current_step = current_step + 1;
          } else {
            current_step = 0;
          }
        });
        // Log function call
        print("onStepContinue : " + current_step.toString());
      },
    );
  }
}
