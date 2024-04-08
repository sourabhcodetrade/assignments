import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageScreen extends StatelessWidget {
  const ImageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text("Image"),
            const SizedBox(
              height: 16,
            ),
            CachedNetworkImage(
              imageUrl: '''https://images.unsplash.com/photo-1626808642875-0aa545482dfb?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D''',

              imageBuilder: (context, imageProvider) => Container(
                height: MediaQuery.sizeOf(context).height * 0.6,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                    filterQuality: FilterQuality.high,
                  ),
                ),
              ),
              placeholder: (context, url) => Container(
                alignment: Alignment.center,
                child: const SizedBox(
                    width: 200,
                    height: 300,
                    child: Center(
                        child:
                            CircularProgressIndicator())), // you can add pre loader iamge as well to show loading.
              ), //show progress  while loading image
              errorWidget: (context, url, error) => Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.grey,
                  child: const Icon(Icons.error)),
            ),
          ],
        ),
      ),
    );
  }
}
