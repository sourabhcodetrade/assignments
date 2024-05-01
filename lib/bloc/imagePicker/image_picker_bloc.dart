import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

part 'image_picker_event.dart';
part 'image_picker_state.dart';

class ImagePickerBloc extends Bloc<ImagePickerEvent, ImagePickerState> {
  ImagePickerBloc() : super(const ImagePickerState()) {
    on<CameraCaptureEvent>(_cameraCaptureImage);
    on<GalleryPickEvent>(_galleryPickImage);
    on<RemoveImageEvent>(_removeImage);
  }

  void _cameraCaptureImage(
      CameraCaptureEvent event, Emitter<ImagePickerState> emit) async {
    final picker = ImagePicker();
    String galleryFile = '';
    final pickedFile = await picker.pickImage(
      source: ImageSource.camera,
    );
    if (pickedFile != null) {
      emit(ImagePickerState(path: pickedFile.path));
    } else {
      Fluttertoast.showToast(
        msg: "No image selected",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.SNACKBAR,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black87,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      emit(ImagePickerState(path: state.path));
    }

  }

  void _galleryPickImage(
      GalleryPickEvent event, Emitter<ImagePickerState> emit) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      emit(ImagePickerState(path: pickedFile.path));
    } else {
      Fluttertoast.showToast(
        msg: "No image selected",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.SNACKBAR,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black87,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      emit(ImagePickerState(path: state.path));
    }
  }

  void _removeImage(RemoveImageEvent event, Emitter<ImagePickerState> emit) {
    emit(const ImagePickerState(path: ''));
  }
}
