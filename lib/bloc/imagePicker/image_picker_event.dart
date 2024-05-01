part of 'image_picker_bloc.dart';

abstract class ImagePickerEvent extends Equatable {

  const ImagePickerEvent();

  @override
  List<Object> get props => [];

}


class CameraCaptureEvent extends ImagePickerEvent{

}

class GalleryPickEvent extends ImagePickerEvent{

}
class RemoveImageEvent extends ImagePickerEvent{

}