import 'package:flutter/material.dart';
import 'package:resources/resources.dart';
import 'package:shared/shared.dart';

enum InitialAppRoute {
  login,
  main,
}

enum Gender {
  male(ServerRequestResponseConstants.male),
  female(ServerRequestResponseConstants.female),
  other(ServerRequestResponseConstants.other),
  unknown(ServerRequestResponseConstants.unknown);

  const Gender(this.serverValue);
  final int serverValue;

  static const defaultValue = unknown;
}

enum LanguageCode {
  en(
    localeCode: LocaleConstants.en,
    serverValue: ServerRequestResponseConstants.en,
  ),
  vi(
    localeCode: LocaleConstants.vi,
    serverValue: ServerRequestResponseConstants.vi,
  );

  const LanguageCode({
    required this.localeCode,
    required this.serverValue,
  });
  final String localeCode;
  final String serverValue;

  static const defaultValue = vi;
}

enum NotificationType {
  wait,
  success,
  cancel,
  update;
  static const defaultValue = wait;
}

enum BottomTab {
  home(icon: Icon(Icons.home), activeIcon: Icon(Icons.home)),
  notify(
      icon: Icon(Icons.notifications_none),
      activeIcon: Icon(Icons.notifications_none)),
  appointment(
      icon: Icon(Icons.calendar_month_outlined),
      activeIcon: Icon(Icons.calendar_month_outlined)),
  store(activeIcon: Icon(Icons.store), icon: Icon(Icons.store)),
  profile(icon: Icon(Icons.person_sharp), activeIcon: Icon(Icons.person_sharp));

  const BottomTab({
    required this.icon,
    required this.activeIcon,
  });
  final Icon icon;
  final Icon activeIcon;

  String get title {
    switch (this) {
      case BottomTab.home:
        return S.current.home;
      case BottomTab.notify:
        return S.current.notification;
      case BottomTab.appointment:
        return S.current.appointment;
      case BottomTab.profile:
        return S.current.profile;
      case BottomTab.store:
        return S.current.store;
    }
  }
}
