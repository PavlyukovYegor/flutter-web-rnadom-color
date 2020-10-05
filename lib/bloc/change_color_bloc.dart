import 'package:colorGenerator/services/background_color_service.dart';
import 'package:colorGenerator/services/text_color_service.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class ChangeColorBloc {
  final BehaviorSubject<ChangeColorState> _stateSubject = BehaviorSubject<ChangeColorState>();
  final BackgroundColorService _backgroundColorService;
  final TextColorService _textColorService;

  ChangeColorBloc(this._backgroundColorService, this._textColorService);

  Stream<ChangeColorState> get stateStream => _stateSubject;

  ChangeColorState get currentState => _stateSubject.value;

  set _currentState(ChangeColorState state) {
    _stateSubject.add(state);
  }

  void generateBackgroundColor() {
    _currentState = ChangeColorState._calculated();
    Color newBackgroundColor = _backgroundColorService.generateRandomColor();
    Color newTextColor = _textColorService.getTextColor(newBackgroundColor);
    _currentState = ChangeColorState._success(newBackgroundColor, newTextColor);
  }

  dispose() {
    _stateSubject.close();
  }
} 

enum ChangeColorType { complete, calculated }

class ChangeColorState {
  
  final ChangeColorType _type;
  final Color backgroundColor;
  final Color textColor;
  
  ChangeColorState._(this._type, this.backgroundColor, this.textColor);
  
  ChangeColorState._calculated(): this._(ChangeColorType.calculated, null, null);

  ChangeColorState._success(Color backgroundColor, Color textColor): this._(ChangeColorType.complete, backgroundColor, textColor);

  bool get isCalculated => _type == ChangeColorType.calculated;

  bool get isComplete => _type == ChangeColorType.complete && this.backgroundColor != null && this.textColor != null;
}
