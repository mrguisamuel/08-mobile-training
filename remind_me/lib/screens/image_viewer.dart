import 'package:flutter/material.dart';
import '../models/wsa_image.dart';
import '../providers/database.dart';

class ImageViewer extends StatefulWidget {
  const ImageViewer({Key? key}) : super(key: key);

  @override
  State<ImageViewer> createState() => _ImageViewerState();
}

class _ImageViewerState extends State<ImageViewer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Galeria')),
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
                  return Container(child: Image.memory(wsaImage.image));
                }).toList()
              );
            }
          )
        )
      )
    );
  }
}