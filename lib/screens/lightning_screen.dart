import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:greenhouses/design/colors.dart';
import 'package:greenhouses/design/icons.dart';
import 'package:greenhouses/models/greenhouse.dart';

class LightningScreen extends StatefulWidget {
  static final route = 'lightning_screen';

  final Greenhouse greenhouse;

  LightningScreen(this.greenhouse);

  @override
  _LightningScreenState createState() => _LightningScreenState(greenhouse.lightningToggled);
}

class _LightningScreenState extends State<LightningScreen> {

  var toggled = false;
  _LightningScreenState(this.toggled);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Lightning'),
      ),
      body: Column(
        children: <Widget>[
          SwitchSection(
            toggled: toggled,
            onToggled: (value) {
              setState(() {
                toggled = value;
              });
            },
          ),
          LightningControl()
        ],
      ),
    );
  }
}

class SwitchSection extends StatelessWidget {
  final bool toggled;
  final Function(bool) onToggled;

  SwitchSection({this.toggled, this.onToggled});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: <Widget>[
          Icon(
            GreenhousesIcons.lightning,
            color: Colors.black,
          ),
          SizedBox(
            width: 12,
          ),
          Text(
            'On',
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
          Spacer(),
          CupertinoSwitch(
            value: toggled,
            activeColor: GreenhousesColors.green,
            onChanged: (value) {
              onToggled(value);
            },
          )
        ],
      ),
    );
  }
}

class LightningControl extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

