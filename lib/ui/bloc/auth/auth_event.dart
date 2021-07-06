import 'package:meta/meta.dart';

@immutable
abstract class AuthEvent {}
class DeomAuthEvent extends AuthEvent{}

class LoginEvent extends AuthEvent {
  final String login;
  final String password;

  LoginEvent(this.login, this.password);
}

class RegisterEvent extends AuthEvent {
  final String login;
  final String email;
  final String password;
  final String first_name;
  final String last_name;
  final String phone; //phone
  final String gender; //gender
  final String age; //age
  final String designation; //designation
  final String organization; //organization
  final String district; //district

  RegisterEvent(
      this.login,
      this.email,
      this.password,
      this.first_name,
      this.last_name,
      this.phone,
      this.gender,
      this.age,
      this.designation,
      this.organization,
      this.district);

}

class CloseDialogEvent extends AuthEvent {}
class DemoAuthEvent extends AuthEvent {}
