import 'package:flutter/material.dart';
import '../models/wsa_image.dart';
import '../providers/database.dart';
import '../screens/image_viewer.dart' show ImageViewer;

class Gallery extends StatefulWidget {
  const Gallery({Key? key}) : super(key: key);

  @override
  State<Gallery> createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Galeria'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pushReplacementNamed('/welcome')
        )
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: FutureBuilder<List<WSAImage>>(
            future: MyDatabase.getAllImages(),
            builder: (BuildContext context, AsyncSnapshot<List<WSAImage>> snapshot) {
              if(!snapshot.hasData)
                return CircularProgressIndicator();
              return snapshot.data!.isEmpty ? Center(child: Text('Sem fotos disponíveis...')) :
              GridView.count(
                crossAxisCount: 2,
                children: snapshot.data!.map((wsaImage) {
                  return GestureDetector(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) => ImageViewer(
                          image: wsaImage.image,
                          audio: wsaImage.audio,
                          title: wsaImage.title,
                          location: wsaImage.location,
                          date: wsaImage.date,
                          time: wsaImage.time
                        )
                      )
                    ),
                    child: Container(child: Image.memory(wsaImage.image))
                  );
                }).toList()
              );
            }
          )
        )
      )
    );
  }
}