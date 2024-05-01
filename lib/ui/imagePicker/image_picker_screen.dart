import 'dart:io';

import 'package:example_bloc/bloc/imagePicker/image_picker_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ImagePickerScreen extends StatefulWidget {
  const ImagePickerScreen({super.key});

  @override
  State<ImagePickerScreen> createState() => _ImagePickerScreenState();
}

class _ImagePickerScreenState extends State<ImagePickerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 100,
            ),
            BlocBuilder<ImagePickerBloc, ImagePickerState>(
              builder: (context, state) {
                return Container(
                  height: 300,
                  width: 350,
                  color: Colors.blueGrey,
                  child: state.path == ''
                      ? const Center(
                          child: Text(
                            'No media selected',
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      : AspectRatio(
                          aspectRatio: 16 / 9, // Set the aspect ratio to 16:9
                          child:
                              Image.file(File(state.path), fit: BoxFit.cover)),
                );
              },
            ),
            const SizedBox(
              height: 16,
            ),
            BlocBuilder<ImagePickerBloc, ImagePickerState>(
              builder: (context, state) {
                return ElevatedButton(
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.teal),
                  ),
                  onPressed: () {
                    context.read<ImagePickerBloc>().add(CameraCaptureEvent());
                  },
                  child: const Text(
                    "Camera Image",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                );
              },
            ),
            BlocBuilder<ImagePickerBloc, ImagePickerState>(
              builder: (context, state) {
                return ElevatedButton(
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.teal),
                  ),
                  onPressed: () {
                    context.read<ImagePickerBloc>().add(GalleryPickEvent());
                  },
                  child: const Text(
                    "Gallery Image",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                );
              },
            ),
            BlocBuilder<ImagePickerBloc, ImagePickerState>(
              builder: (context, state) {
                return ElevatedButton(
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.teal),
                  ),
                  onPressed: () {
                    context.read<ImagePickerBloc>().add(RemoveImageEvent());
                  },
                  child: const Text(
                    "Remove Image",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
