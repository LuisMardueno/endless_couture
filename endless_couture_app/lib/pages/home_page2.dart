import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final List<String> imgTemporadas = [
  'https://s7d2.scene7.com/is/image/aeo/20240422-aehp-nav-1-wsp-mx-sm?defaultImage=20240422-aehp-nav-1-wsp-mx-lg&scl=1&qlt=60&fmt=webp',
  'https://s7d2.scene7.com/is/image/aeo/20240422-aehp-nav-2-pre-mx-sm?defaultImage=20240422-aehp-nav-2-pre-mx-lg&scl=1&qlt=60&fmt=webp',
  'https://i5.walmartimages.com/seo/Women-s-Fashion-Spring-And-Autumn-Boho-Round-Neck-Dress_fe209e19-08ae-4519-99d9-f6c77d4e2b7b.68313ef10de215860b46e5b5119367fd.jpeg?odnHeight=768&odnWidth=768&odnBg=FFFFFF',
  'https://www.kosha.co/journal/wp-content/uploads/2022/07/winter-dresses-outfits-fashion-tips-to-stay-warm.jpeg',
  'https://s7d2.scene7.com/is/image/aeo/20240422-aehp-nav-1-wsp-mx-sm?defaultImage=20240422-aehp-nav-1-wsp-mx-lg&scl=1&qlt=60&fmt=webp',
  'https://s7d2.scene7.com/is/image/aeo/20240422-aehp-nav-2-pre-mx-sm?defaultImage=20240422-aehp-nav-2-pre-mx-lg&scl=1&qlt=60&fmt=webp',
];

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> dataLink = [];
  List<dynamic> dataImg = [];
  List<dynamic> dataTemporada = [];
  List<dynamic> dataColor = [];
  List<dynamic> dataEstilo = [];
  List<dynamic> dataEstampado = [];
  List<dynamic> dataPrecio = [];
  List<dynamic> dataVentas  = [];


  @override
  void initState() {
    super.initState();
    loadAsset();
  }

  loadAsset() async {
    final myData = await rootBundle.loadString("assets/Datos.csv");
    List<List<dynamic>> csvTable = const CsvToListConverter().convert(myData);

    // Extract the first column
    dataLink = csvTable.skip(1).map((row) =>      row[0]).toList();
    dataImg = csvTable.skip(1).map((row) =>       row[1]).toList();
    dataTemporada = csvTable.skip(1).map((row) => row[2]).toList();
    dataColor = csvTable.skip(1).map((row) =>     row[3]).toList();
    dataEstilo = csvTable.skip(1).map((row) =>    row[4]).toList();
    dataEstampado = csvTable.skip(1).map((row) => row[5]).toList();
    dataPrecio = csvTable.skip(1).map((row) =>    row[10]).toList();
    dataVentas = csvTable.skip(1).map((row) =>    row[11]).toList();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
   // double screenHeight = MediaQuery.of(context).size.height;
    double radius = screenWidth * 0.05; // 5% of screen width

    return Material(
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromARGB(255, 248, 171, 119),
                  Color.fromARGB(111, 233, 108, 139)
                ],
              ),
            ),
          ),
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              );
            },
          ),
          centerTitle: true,
          title: const Hero(
            tag: "titulo",
            child: Text(
              "Endless Couture",
              style: TextStyle(
                decoration: TextDecoration.none,
                color: Colors.black,
                fontSize: 40,
                fontFamily: "Custom",
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          actions: [
            Builder(builder: (context) {
              return IconButton(
                iconSize: 30,
                color: Colors.black,
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
                icon: const Icon(Icons.account_circle_outlined),
              );
            })
          ],
        ),
        endDrawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(color: Colors.deepPurple.shade200),
                child: const Text(
                  "User Info",
                  textAlign: TextAlign.center,
                ),
              ),
              ListTile(
                title: const Text("Cerrar Sesion"),
                onTap: () {},
              ),
              ListTile(
                title: const Text("item 2"),
                onTap: () {},
              ),
              ListTile(
                title: const Text("item 3"),
                onTap: () {},
              ),
            ],
          ),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(color: Colors.deepPurple.shade200),
                child: const Text(
                  "Tab Menu",
                  textAlign: TextAlign.center,
                ),
              ),
              ListTile(
                title: const Text("item 1"),
                onTap: () {},
              ),
              ListTile(
                title: const Text("item 2"),
                onTap: () {},
              ),
              ListTile(
                title: const Text("item 3"),
                onTap: () {},
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white
            ),
            child: Column(
  children: [
    const Text("Los Mas vendidos", textAlign: TextAlign.center, style: TextStyle(fontFamily: 'Custom', fontSize: 40),)
    ,
    dataImg.isEmpty
        ? const Center(child: CircularProgressIndicator())
        : CarouselSlider.builder(
            itemCount: dataImg.length,
            itemBuilder: (BuildContext context, int index, int realIndex) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.2,
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 187, 156, 201),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        offset: Offset(5.0, 5.0),
                        blurRadius: 10,
                        spreadRadius: 1,
                      ),
                      BoxShadow(
                        color: Colors.white,
                        offset: Offset(0, 0),
                        blurRadius: 0,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      FutureBuilder<void>(
                        future: Future.microtask(() {
                          CachedNetworkImageProvider(dataImg[index]);
                        }),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.done) {
                            return SizedBox(
                              width: MediaQuery.of(context).size.width * 0.2, // Adjust the width as needed
                              height: MediaQuery.of(context).size.height * 0.4, // Adjust the height as needed
                              child: CachedNetworkImage(
                                imageUrl: dataImg[index].toString(),
                                placeholder: (context, url) => const CircularProgressIndicator(),
                                errorWidget: (context, url, error) => const Icon(Icons.error),
                                fit: BoxFit.fitHeight,
                              ),
                            );
                          } else {
                            return const CircularProgressIndicator();
                          }
                        },
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          child: RichText(
                            text: TextSpan(
                              style:const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 255, 255, 255)),
                              children: [
                                TextSpan(text: 'Temporada: ${dataTemporada[index]}\n'),
                                TextSpan(text: 'Color: ${dataColor[index]}\n'),
                                TextSpan(text:  'Ventas: ${dataVentas[index]}\n'),
                                TextSpan(text: 'Precio: ${dataPrecio[index]}'),
                                ]
                            ) // Display corresponding text
                            
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
            options: CarouselOptions(
              enlargeCenterPage: true,
              enlargeFactor: 0.4,
              viewportFraction: 0.4,
              aspectRatio: 2.0,
              height: MediaQuery.of(context).size.height * 0.4,
              autoPlay: true,
            ),
          ),
                              const SizedBox(height: 20),
                              const Text(
                                "Temporadas",
                                style: TextStyle(fontFamily: 'Custom', fontSize: 30),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    children: [
                                      CircleAvatar(
                                        radius: radius, // Set the responsive radius
                                        backgroundImage: CachedNetworkImageProvider(imgTemporadas[0],
                                        ),

                                      ),
                                      const Text("Primavera"),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      CircleAvatar(
                                        radius: radius, // Set the responsive radius
                                        backgroundImage: CachedNetworkImageProvider(imgTemporadas[1]),
                                      ),
                                      const Text("Verano"),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      CircleAvatar(
                                        radius: radius, // Set the responsive radius
                                        backgroundImage: CachedNetworkImageProvider(imgTemporadas[2]),
                                      ),
                                      const Text("Otoño"),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      CircleAvatar(
                                        radius: radius, // Set the responsive radius
                                        backgroundImage: CachedNetworkImageProvider(imgTemporadas[3]),
                                      ),
                                      const Text("Invierno"),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              GridView.builder(
                                physics: const NeverScrollableScrollPhysics(), // Disable scrolling for the GridView
                                shrinkWrap: true, // Make the GridView take only the necessary space
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3, // Number of columns
                                  crossAxisSpacing: 10.0,
                                  mainAxisSpacing: 10.0,
                                  childAspectRatio: 1.5, // Adjust this to fit your design
                                ),
                                itemCount: (dataColor.length / 40).round(),
                                itemBuilder: (context, index) {
                                  return Padding(
  padding: const EdgeInsets.all(8.0),
  child: Container(
    width: MediaQuery.of(context).size.width * 2,
    color: const Color.fromARGB(15, 0, 0, 0),
    child: Stack(
      children: [
        FutureBuilder<void>(
          future: Future.microtask(() {
            CachedNetworkImageProvider(dataImg[index]);
          }),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return SizedBox(
                width: MediaQuery.of(context).size.width * 1, // Adjust the width as needed
                height: MediaQuery.of(context).size.height * 1, // Adjust the height as needed
                child: CachedNetworkImage(
                  imageUrl: dataImg[index].toString(),
                  placeholder: (context, url) => const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  fit: BoxFit.fitHeight,
                ),
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: const EdgeInsets.all(8.0), // Add padding to the text container
            width: MediaQuery.of(context).size.width * 0.35,
            color: const Color.fromARGB(90, 0, 0, 0),
            child: Text.rich(
              TextSpan(
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white, 
                ),
                children: [
                  TextSpan(text: 'Temporada: ${dataTemporada[index]}\n'),
                  TextSpan(text: 'Color: ${dataColor[index]}\n'),
                  TextSpan(text: 'Precio: ${dataPrecio[index]}'),
                ],
              ),
              overflow: TextOverflow.clip,
            ),
          ),
        ),
      ],
    ),
  ),
);
                                },
                              ),
                            ],
            ),
          ),
        ),
      ),
    );
  }
}
