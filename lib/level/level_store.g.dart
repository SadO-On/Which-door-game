// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'level_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LevelStore on _LevelStore, Store {
  late final _$levelAtom = Atom(name: '_LevelStore.level', context: context);

  @override
  int get level {
    _$levelAtom.reportRead();
    return super.level;
  }

  @override
  set level(int value) {
    _$levelAtom.reportWrite(value, super.level, () {
      super.level = value;
    });
  }

  late final _$saveNewLevelAsyncAction =
      AsyncAction('_LevelStore.saveNewLevel', context: context);

  @override
  Future<dynamic> saveNewLevel(int level) {
    return _$saveNewLevelAsyncAction.run(() => super.saveNewLevel(level));
  }

  late final _$_LevelStoreActionController =
      ActionController(name: '_LevelStore', context: context);

  @override
  void updateLevel(int newLevel) {
    final _$actionInfo = _$_LevelStoreActionController.startAction(
        name: '_LevelStore.updateLevel');
    try {
      return super.updateLevel(newLevel);
    } finally {
      _$_LevelStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
level: ${level}
    ''';
  }
}
