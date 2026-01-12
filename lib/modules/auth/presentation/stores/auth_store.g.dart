// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AuthStore on _AuthStoreBase, Store {
  Computed<String?>? _$userEmailComputed;

  @override
  String? get userEmail => (_$userEmailComputed ??= Computed<String?>(
    () => super.userEmail,
    name: '_AuthStoreBase.userEmail',
  )).value;
  Computed<String?>? _$userIdComputed;

  @override
  String? get userId => (_$userIdComputed ??= Computed<String?>(
    () => super.userId,
    name: '_AuthStoreBase.userId',
  )).value;
  Computed<String?>? _$userNameComputed;

  @override
  String? get userName => (_$userNameComputed ??= Computed<String?>(
    () => super.userName,
    name: '_AuthStoreBase.userName',
  )).value;
  Computed<bool>? _$needsEmailVerificationComputed;

  @override
  bool get needsEmailVerification =>
      (_$needsEmailVerificationComputed ??= Computed<bool>(
        () => super.needsEmailVerification,
        name: '_AuthStoreBase.needsEmailVerification',
      )).value;

  late final _$currentUserAtom = Atom(
    name: '_AuthStoreBase.currentUser',
    context: context,
  );

  @override
  User? get currentUser {
    _$currentUserAtom.reportRead();
    return super.currentUser;
  }

  @override
  set currentUser(User? value) {
    _$currentUserAtom.reportWrite(value, super.currentUser, () {
      super.currentUser = value;
    });
  }

  late final _$isAuthenticatedAtom = Atom(
    name: '_AuthStoreBase.isAuthenticated',
    context: context,
  );

  @override
  bool get isAuthenticated {
    _$isAuthenticatedAtom.reportRead();
    return super.isAuthenticated;
  }

  @override
  set isAuthenticated(bool value) {
    _$isAuthenticatedAtom.reportWrite(value, super.isAuthenticated, () {
      super.isAuthenticated = value;
    });
  }

  late final _$isEmailVerifiedAtom = Atom(
    name: '_AuthStoreBase.isEmailVerified',
    context: context,
  );

  @override
  bool get isEmailVerified {
    _$isEmailVerifiedAtom.reportRead();
    return super.isEmailVerified;
  }

  @override
  set isEmailVerified(bool value) {
    _$isEmailVerifiedAtom.reportWrite(value, super.isEmailVerified, () {
      super.isEmailVerified = value;
    });
  }

  late final _$isLoadingAtom = Atom(
    name: '_AuthStoreBase.isLoading',
    context: context,
  );

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$errorMessageAtom = Atom(
    name: '_AuthStoreBase.errorMessage',
    context: context,
  );

  @override
  String? get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String? value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  late final _$signOutAsyncAction = AsyncAction(
    '_AuthStoreBase.signOut',
    context: context,
  );

  @override
  Future<void> signOut() {
    return _$signOutAsyncAction.run(() => super.signOut());
  }

  late final _$reloadUserAsyncAction = AsyncAction(
    '_AuthStoreBase.reloadUser',
    context: context,
  );

  @override
  Future<void> reloadUser() {
    return _$reloadUserAsyncAction.run(() => super.reloadUser());
  }

  late final _$deleteAccountAsyncAction = AsyncAction(
    '_AuthStoreBase.deleteAccount',
    context: context,
  );

  @override
  Future<void> deleteAccount() {
    return _$deleteAccountAsyncAction.run(() => super.deleteAccount());
  }

  late final _$sendEmailVerificationAsyncAction = AsyncAction(
    '_AuthStoreBase.sendEmailVerification',
    context: context,
  );

  @override
  Future<void> sendEmailVerification() {
    return _$sendEmailVerificationAsyncAction.run(
      () => super.sendEmailVerification(),
    );
  }

  late final _$_AuthStoreBaseActionController = ActionController(
    name: '_AuthStoreBase',
    context: context,
  );

  @override
  void clearError() {
    final _$actionInfo = _$_AuthStoreBaseActionController.startAction(
      name: '_AuthStoreBase.clearError',
    );
    try {
      return super.clearError();
    } finally {
      _$_AuthStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentUser: ${currentUser},
isAuthenticated: ${isAuthenticated},
isEmailVerified: ${isEmailVerified},
isLoading: ${isLoading},
errorMessage: ${errorMessage},
userEmail: ${userEmail},
userId: ${userId},
userName: ${userName},
needsEmailVerification: ${needsEmailVerification}
    ''';
  }
}
