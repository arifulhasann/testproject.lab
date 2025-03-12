import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Interactive Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.yellow),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _sliderValue = 20.0;
  TextEditingController _controller = TextEditingController();
  String _inputText = "";

  void _updateInputText() {
    setState(() {
      _inputText = _controller.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Interactive Flutter Demo')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/my.jpg', height: 100),
                SizedBox(width: 20),
                Image.asset('assets/images/my.jpg', height: 100),
              ],
            ),
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Naam den',
              ),
              onChanged: (text) {
                _updateInputText();
              },
            ),
            SizedBox(height: 30),
            Text(
              'Hello, $_inputText!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            // Navigate to SecondPage, passing sliderValue
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SecondPage(sliderValue: _sliderValue),
                  ),
                );
              },
              child: Text('Go to Second Page'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ThirdPage()),
                );
              },
              child: Text('Go to Third Page'),
            ),
          ],
        ),
      ),
    );
  }
}

class SecondPage extends StatefulWidget {
  final double sliderValue;

  SecondPage({required this.sliderValue});

  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  late double _sliderValue;

  @override
  void initState() {
    super.initState();
    _sliderValue = widget.sliderValue; // Initialize sliderValue from passed parameter
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Second Page - Slider')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            SizedBox(height: 20),
            // Slider Widget to update the value
            Slider(
              value: _sliderValue,
              min: -20,
              max: 400,
              divisions: 20,
              label: _sliderValue.toStringAsFixed(1),
              onChanged: (double value) {
                setState(() {
                  _sliderValue = value;
                });
              },
            ),
            SizedBox(height: 20),
            Text(
              'Slider Value: ${_sliderValue.toStringAsFixed(1)}',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to ThirdPage
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ThirdPage()),
                );
              },
              child: Text('Go to Third Page'),
            ),
            SizedBox(height: 20),
            Image.asset('assets/images/my.jpg', height: 100),
          ],
        ),
      ),
    );
  }
}

class ThirdPage extends StatefulWidget {
  @override
  _ThirdPageState createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  List<String> _items = [];
  TextEditingController _itemController = TextEditingController();

  void _addItem() {
    if (_itemController.text.isNotEmpty) {
      setState(() {
        _items.add(_itemController.text);
        _itemController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Third Page - List of Items')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _itemController,
              decoration: InputDecoration(hintText: 'Enter item to add'),
            ),
            SizedBox(height: 10),
            ElevatedButton(onPressed: _addItem, child: Text('Add Item')),
            Expanded(
              child: ListView.builder(
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_items[index]),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        setState(() {
                          _items.removeAt(index);
                        });
                      },
                    ),
                  );
                },
              ),
            ),
            // Image is now placed after the list
            SizedBox(height: 20),
            Image.asset('assets/images/my.jpg', height: 200),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Proper navigation back
              },
              child: Text('Back to Home Page'),
            ),
          ],
        ),
      ),
    );
  }
}
