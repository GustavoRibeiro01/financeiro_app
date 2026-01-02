import 'package:mobx/mobx.dart';
import 'package:flutter/material.dart';

part 'home_store.g.dart';

class HomeStore = HomeStoreBase with _$HomeStore;

abstract class HomeStoreBase with Store {
  @observable
  int currentIndex = 0;

  @observable
  PageController pageController = PageController(initialPage: 0);

  @action
  void setCurrentIndex(int index) {
    currentIndex = index;
    pageController.jumpToPage(index);
  }

  @action
  void onPageChanged(int index) {
    currentIndex = index;
  }

  void dispose() {
    pageController.dispose();
  }
}
