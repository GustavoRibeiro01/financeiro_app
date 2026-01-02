import 'package:mobx/mobx.dart';
import 'package:flutter/material.dart';

part 'home_store.g.dart';

class HomeStore = _HomeStoreBase with _$HomeStore;

abstract class _HomeStoreBase with Store {
  @observable
  int currentIndex = 0;

  @observable
  PageController pageController = PageController(initialPage: 0);

  @action
  void setCurrentIndex(int index) {
    currentIndex = index;
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @action
  void onPageChanged(int index) {
    currentIndex = index;
  }

  void dispose() {
    pageController.dispose();
  }
}
