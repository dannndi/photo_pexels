part of 'edit_photo_cubit.dart';

enum WidgetState { idle, editing, edited }
enum LayerState { idle, editing }

class EditPhotoState extends Equatable {
  const EditPhotoState({
    required this.photo,
    this.layerState = LayerState.idle,
    this.layerOpacity = 0,
    this.widgetState = WidgetState.idle,
    this.widgets = const [],
    this.statusDownload = StatusDownload.idle,
    this.statusShare = StatusDownload.idle,
  });

  final Photo photo;
  final LayerState layerState;
  final double layerOpacity;
  final WidgetState widgetState;
  final List<DragableWidget> widgets;
  final StatusDownload statusDownload;
  final StatusDownload statusShare;

  EditPhotoState copyWith({
    LayerState? layerState,
    double? layerOpacity,
    WidgetState? widgetState,
    List<DragableWidget>? widgets,
    StatusDownload? statusDownload,
    StatusDownload? statusShare,
  }) {
    return EditPhotoState(
      photo: photo,
      layerState: layerState ?? this.layerState,
      layerOpacity: layerOpacity ?? this.layerOpacity,
      widgetState: widgetState ?? this.widgetState,
      widgets: widgets ?? this.widgets,
      statusDownload: statusDownload ?? this.statusDownload,
      statusShare: statusShare ?? this.statusShare,
    );
  }

  @override
  List<Object> get props => [
        photo,
        layerState,
        layerOpacity,
        widgetState,
        widgets,
        statusDownload,
        statusShare,
      ];
}
