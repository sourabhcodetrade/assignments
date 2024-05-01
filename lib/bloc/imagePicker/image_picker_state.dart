part of 'image_picker_bloc.dart';


class ImagePickerState extends Equatable {
 final String path;

 const ImagePickerState({this.path = ''});


 @override
 List<Object> get props => [path];
}

