import 'package:flutter/material.dart';
import 'package:preferences/preference_service.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reproduce',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
        body: FutureBuilder(
          future: PrefService.init(prefix: 'prefix'),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SettingWidget();
            } else if (snapshot.hasError) {
              return ErrorWidget(snapshot.error);
            } else {
              return LoaderWidget();
            }
          },
        ),
      ),
    );
  }
}

class ErrorWidget extends StatelessWidget {
  final Object error;
  ErrorWidget(this.error);

  @override
  Widget build(BuildContext context) {
    return Container(child: Center(child: Text(error.toString(), style: Theme.of(context).textTheme.body1,)));
  }
}

class LoaderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(child: Center(child: Text('Loading..', style: Theme.of(context).textTheme.body1,)));
  }
}

class SettingWidget extends StatefulWidget {
  @override
  _SettingWidgetState createState() => _SettingWidgetState();
}

class _SettingWidgetState extends State<SettingWidget> {

  static const SettingKey = 'setting';

  bool setting = false;

  @override
  void initState() {
    if (PrefService.get(SettingKey) != null) {
      setting = PrefService.getBool(SettingKey);
    } else {
      PrefService.setBool(SettingKey, setting);
    }
    print ("Setting is now $setting");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text("Setting is ${this.setting}", key: Key('text'), style: Theme.of(context).textTheme.body1),
              FlatButton(key: Key('button'), color: Colors.blue, textColor: Colors.white, child: Text('Toggle setting'), onPressed: toggleSetting)
            ],
          )
      ),
    );
  }

  toggleSetting() {
    setState(() {
      setting = !setting;
      print("Setting changed to $setting");
      PrefService.setBool(SettingKey, setting);
    });
  }
}