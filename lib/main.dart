import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double slider1val = 0;
  double slider2val = 0;
  double slider3val = 0;
  double slider4val = 0;

  String resValue = "";

  List<double> multiplier = [
    1,
    10,
    100,
    1000,
    10000,
    100000,
    1000000,
    10000000,
    0.1,
    0.01
  ];
  List<String> tolerance = ['1%', '2%', '5%', '10%'];

  @override
  void initState() {
    super.initState();
    calcResistorValue();
  }

  void calcResistorValue() {
    double calcValue = (slider1val * 10) + (slider2val);
    calcValue *= multiplier[slider3val.toInt()];

    setState(() {
      if (calcValue < 1000)
        resValue = calcValue.toStringAsFixed(2) + " ";
      else if (calcValue < 1000000)
        resValue = (calcValue / 1000).toStringAsFixed(2) + " k";
      else
        resValue = (calcValue / 1000000).toStringAsFixed(2) + " M";

      resValue += "Ω - " + tolerance[slider4val.toInt()];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Resistor Calculator'),
        ),
        body: Column(
          children: <Widget>[
            Card(
              margin: EdgeInsets.all(24.0),
              child:
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(resValue.toString(), style: TextStyle(fontSize: 40.0)),
                  ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ResistorColorStrip(
                  stripColors: [
                    Colors.black,
                    Colors.brown,
                    Colors.red,
                    Colors.orange,
                    Colors.yellow,
                    Colors.green,
                    Colors.blue,
                    Colors.purple,
                    Colors.grey,
                    Colors.white
                  ],
                  value: this.slider1val,
                  onChanged: (value) {
                    setState(() {
                      this.slider1val = value;
                      calcResistorValue();
                    });
                  },
                ),
                ResistorColorStrip(
                  stripColors: [
                    Colors.black,
                    Colors.brown,
                    Colors.red,
                    Colors.orange,
                    Colors.yellow,
                    Colors.green,
                    Colors.blue,
                    Colors.purple,
                    Colors.grey,
                    Colors.white
                  ],
                  value: this.slider2val,
                  onChanged: (value) {
                    setState(() {
                      this.slider2val = value;
                      calcResistorValue();
                    });
                  },
                ),
                ResistorColorStrip(
                  stripColors: [
                    Colors.black,
                    Colors.brown,
                    Colors.red,
                    Colors.orange,
                    Colors.yellow,
                    Colors.green,
                    Colors.blue,
                    Colors.purple,
                    Color(0xFFd4af37),
                    Color(0xFFaaa9ad)
                  ],
                  value: this.slider3val,
                  onChanged: (value) {
                    setState(() {
                      this.slider3val = value;
                      calcResistorValue();
                    });
                  },
                ),
                ResistorColorStrip(
                  stripColors: [
                    Colors.brown,
                    Colors.red,
                    Color(0xFFd4af37),
                    Color(0xFFaaa9ad)
                  ],
                  value: this.slider4val,
                  onChanged: (value) {
                    setState(() {
                      this.slider4val = value;
                      calcResistorValue();
                    });
                  },
                ),
              ],
            ),
          ],
        ));
  }
}

class ResistorColorStrip extends StatelessWidget {
  final List<Color> stripColors;
  final Function onChanged;
  final double value;

  ResistorColorStrip({this.stripColors, this.onChanged, this.value});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        Container(
          decoration:
              BoxDecoration(border: Border.all(color: Colors.blueAccent)),
          child: SizedBox(
            width: 50,
            height: (this.stripColors.length * 50).toDouble(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                for (var color in stripColors)
                  ResistorColorBand(colorBand: color),
              ],
            ),
          ),
        ),
        SizedBox(
          width: 50,
          height: (this.stripColors.length * 50).toDouble(),
          child: RotatedBox(
            quarterTurns: 1,
            child: SliderTheme(
              data: SliderThemeData(
                trackShape: CustomTrackShape(),
                activeTrackColor: Color(0x00000000),
                inactiveTrackColor: Color(0x00000000),
                thumbColor: (stripColors[this.value.toInt()] == Colors.white)
                    ? Colors.black
                    : Colors.white,
                activeTickMarkColor: Color(0x00000000),
                inactiveTickMarkColor: Color(0x00000000),
              ),
              child: Slider(
                divisions: (this.stripColors.length - 1),
                min: 0,
                max: this.stripColors.length - 1.toDouble(),
                value: this.value,
                onChanged: this.onChanged,
              ),
            ),
          ),
        )
      ],
    );
  }
}

class CustomTrackShape extends RoundedRectSliderTrackShape {
  Rect getPreferredRect({
    @required RenderBox parentBox,
    Offset offset = Offset.zero,
    @required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight;

    final double trackLeft = offset.dx + 25;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width - 50;
    print(trackWidth);
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}

class ResistorColorBand extends StatelessWidget {
  final Color colorBand;

  ResistorColorBand({this.colorBand});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: this.colorBand,
      child: SizedBox(
        width: 50,
        height: 50,
      ),
    );
  }
}
