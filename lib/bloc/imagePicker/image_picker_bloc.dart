import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

part 'image_picker_event.dart';
part 'image_picker_state.dart';

class ImagePickerBloc extends Bloc<ImagePickerEvent, ImagePickerState> {
  ImagePickerBloc() : super(const ImagePickerState()) {
    on<CameraCaptureEvent>(_cameraCaptureImage);
    on<GalleryPickEvent>(_galleryPickImage);
    on<RemoveImageEvent>(_removeImage);
  }

  void _cameraCaptureImage(CameraCaptureEvent event, Emitter<ImagePickerState> emit) async{
    final picker = ImagePicker();
    var galleryFile;
    final pickedFile = await picker.pickImage(
      source: ImageSource.camera,
    );
    XFile? xfilePick = pickedFile;
        if (xfilePick != null) {
          galleryFile =pickedFile!.path;
        } else {
          print("error");
        }


    emit(ImagePickerState(path: galleryFile));
  }
  void _galleryPickImage(GalleryPickEvent event, Emitter<ImagePickerState> emit)async{
    final picker = ImagePicker();
    var galleryFile;
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    XFile? xfilePick = pickedFile;
    if (xfilePick != null) {
      galleryFile =pickedFile!.path;
    } else {
      print("error");
    }


    emit(ImagePickerState(path: galleryFile));
  }

  void _removeImage(RemoveImageEvent event, Emitter<ImagePickerState> emit){
    emit(const ImagePickerState(path: ''));

  }

}
