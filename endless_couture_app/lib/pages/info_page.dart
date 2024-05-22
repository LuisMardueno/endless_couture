
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:ml_algo/ml_algo.dart';
import 'package:ml_dataframe/ml_dataframe.dart';
import 'package:csv/csv.dart';
import 'dart:core';

  List<dynamic> dataEstampado = [];
  List<dynamic> dataPrecio = [];
  List<dynamic> dataVentas  = [];
  
Future<DataFrame> loadAndCleanData() async {
  final myData = await rootBundle.loadString('assets/one_hot_modelo.csv');
  List<List<dynamic>> csvTable = const CsvToListConverter().convert(myData);

  // Limpieza de datos: eliminar caracteres no numéricos de los precios
  for (var row in csvTable.skip(1)) { // Saltar el encabezado
    row[5] = row[5].toString().replaceAll(RegExp(r'[^\d.]'), ''); // Eliminar símbolos no numéricos
  }

  // Convertir todo a numérico donde sea posible
  List<List<dynamic>> cleanedData = csvTable.map((row) {
    return row.map((value) {
      if (value is String && double.tryParse(value) != null) {
        return double.parse(value);
      }
      return value;
    }).toList();
  }).toList();

  // Crear el DataFrame
  final header = cleanedData[0].map((e) => e.toString()).toList();
  final rows = cleanedData.skip(1).toList();
  return DataFrame([header, ...rows]);
}


Future<List<List<int>>> runAnalysis() async {
    try {
      final dataFrame = await loadAndCleanData();

      // Train and test split
      const targetName = 'Ventas';
      final splits = splitData(dataFrame, [0.8]);
      final trainData = splits[0];
      final testData = splits[1];

      log('Training model...');
      final model = LinearRegressor(trainData, targetName, fitIntercept: true);
      log('Model training completed.');

      final error = model.assess(testData, MetricType.mape);
      log('Model assessment completed. Error (MAPE): $error');

      final coefficients = model.coefficients;
      log('Coefficients: $coefficients');

      // Example of making a prediction
      final unlabelledData = DataFrame([
        ['Combinado', 'Floral', 'Generico', 'Geometrico', 'Liso', 'Precio'],
        [0, 1, 0, 0, 0, 250], // Example input data
      ]);

      final prediction = model.predict(unlabelledData);

      final predictionValues = prediction.toMatrix().map((row) => row.map((value) => value.abs().round()).toList()).toList();
      log('Prediction: $predictionValues');
      return predictionValues;
    } catch (e) {
      log('An error occurred: $e');
      return [];
    }
  }



class InfoPage extends StatefulWidget {
  const InfoPage({super.key});

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  List<List<int>>? prediction;

  @override
  void initState() {
    super.initState();
    _loadPrediction();
  }

  Future<void> _loadPrediction() async {
    final result = await runAnalysis();
    setState(() {
      prediction = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    int selectedCombinado = 0;
    int selectedFloral = 0;
    int selectedGenerico = 0;
    int selectedGeometrico = 0;
    int selectedLiso = 0;
    String selectedPrecio = '';
    return Scaffold(
      appBar: AppBar(
        title: const Text("Informacion de Endless couture"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            RichText(
              text:  TextSpan(
                style: const TextStyle(
                  fontFamily: "Ubuntu",
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
                children: [
                  const TextSpan(
                    style: TextStyle(
                      fontFamily: 'Custom',
                      fontSize: 40,
                      fontWeight: FontWeight.w500,
                    ),
                    text: 'Endless Couture\n\n',
                  ),
                  const TextSpan(
                    text: 'Es un proyecto de uso de inteligencia artificial donde se usa machine learning.\n',),
                  const TextSpan(
                    text: 'Que nos permite analizar una serie de datos y hacer prediciones de las cantidades de ventas que podra tener un articulo\n',),
                  const TextSpan(
                    text: 'para este proyecto se recopilo exahustivamente informacion de listados de vestidos en los cuales recabamos distinta informacion\n',),
                  const TextSpan(
                    text: 'Recopilamos la siguente informacion para el modelo:\n \n Tipo de estampado,  Precio,  Ventas\n\n',),
                  const TextSpan(text: ' Para que el modelo pueda hacer una predcion nesecitamos que todas las columnas de los datos que ingresemos sean valores numericos \n'),
                  const TextSpan(text: 'Existen dos tipos de variables categoricas las Nominales y las ordinales, las nominales  se diferencian de que no llevan un orden intrínseco\n'),
                  const TextSpan(text: 'esto quiere decir que no es mejor un tipo de estampado que otro por ello debemos recurrir a un metodo de codificacion llamado One Hot Encoding \n'),
                  const TextSpan(text: 'el cual nos deja con diferentes columnas con los distintos valores en estas se agrega un 1 en la columna que era el valor original y en las nuevas 0\n'),
                  const TextSpan(text: '\n Por ejemplo si cargamos al modelo los siguientes valores: \n'),
                  TextSpan(text: '${['Combinado', 'Floral', 'Generico', 'Geometrico', 'Liso', 'Precio'].toString()} \n ${[0, 1, 0, 0, 0, 250].toString()}',),
                  const TextSpan(text: '\n Tenemos la siguente predccion del valor que nos hace falta de Ventas')
                ],
              ),
            ),
            if (prediction != null)
              Text(prediction.toString()),
            const SizedBox(height: 20,),
           Row(
             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
             children: [
               DropdownButton<int>(
                 value: selectedCombinado,
                 onChanged: (newValue) {
                   setState(() {
                     selectedCombinado = newValue!;
                   });
                 },
                 items: const [
                   DropdownMenuItem<int>(
                     value: 0,
                     child: Text('0'),
                   ),
                   DropdownMenuItem<int>(
                     value: 1,
                     child: Text('1'),
                   ),
                 ],
               ),
               DropdownButton<int>(
                 value: selectedGenerico,
                 onChanged: (newValue) {
                   setState(() {
                     selectedGenerico = newValue!;
                   });
                 },
                 items: const [
                   DropdownMenuItem<int>(
                     value: 0,
                     child: Text('0'),
                   ),
                   DropdownMenuItem<int>(
                     value: 1,
                     child: Text('1'),
                   ),
                 ],
               ),
               DropdownButton<int>(
                 value: selectedLiso,
                 onChanged: (newValue) {
                   setState(() {
                     selectedLiso = newValue!;
                   });
                 },
                 items: const [
                   DropdownMenuItem<int>(
                     value: 0,
                     child: Text('0'),
                   ),
                   DropdownMenuItem<int>(
                     value: 1,
                     child: Text('1'),
                   ),
                 ],
               ),
               DropdownButton<int>(
                 value: selectedGeometrico,
                 onChanged: (newValue) {
                   setState(() {
                     selectedGeometrico = newValue!;
                   });
                 },
                 items: const [
                   DropdownMenuItem<int>(
                     value: 0,
                     child: Text('0'),
                   ),
                   DropdownMenuItem<int>(
                     value: 1,
                     child: Text('1'),
                   ),
                 ],
               ),
               DropdownButton<int>(
                 value: selectedFloral,
                 onChanged: (newValue) {
                   setState(() {
                     selectedFloral = newValue!;
                   });
                 },
                 items: const [
                   DropdownMenuItem<int>(
                     value: 0,
                     child: Text('0'),
                   ),
                   DropdownMenuItem<int>(
                     value: 1,
                     child: Text('1'),
                   ),
                 ],
               ),
               const SizedBox(width: 10),
               Expanded(
                 child: TextFormField(
                   initialValue: selectedPrecio,
                   onChanged: (value) {
                     setState(() {
                       selectedPrecio = value;
                     });
                   },
                   keyboardType: TextInputType.number,
                   decoration: const InputDecoration(
                     labelText: 'Precio',
                     border: OutlineInputBorder(),
                   ),
                 ),
               ),
             ],
           ),
            const SizedBox(height: 20,),
            ElevatedButton(
              onPressed: _loadPrediction,
              child: const Text('Hacer prediccion'),
            ),
          ],
        ),
      ),
    );
  }
}