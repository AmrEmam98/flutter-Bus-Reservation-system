import 'package:bus_reservation_systerm/FirebaseServices/authentcation.dart';
import 'package:bus_reservation_systerm/FirebaseServices/set_data_to_firestore.dart';
import 'package:bus_reservation_systerm/Models/user.dart';
import 'package:reactive_forms/reactive_forms.dart';

class SignUpViewModel {
  static String userName = "userName",
      email = "email",
      password = 'password',
      confirmPassword = 'confirmPassword',
      phoneNumber = 'phoneNumber';

  final form = FormGroup({
    email: FormControl<String>(
      validators: [Validators.required, Validators.email],
    ),
    userName: FormControl<String>(validators: [
      Validators.required,
    ]),
    password: FormControl<String>(validators: [
      Validators.required,
      Validators.minLength(6),
    ]),
    confirmPassword: FormControl<String>(validators: [
      Validators.required,
    ]),
  }, validators: [
    Validators.mustMatch(password, confirmPassword)
  ]);

  signUp(String branch)async {
    if(form.valid){
      String uid=await Auth.signUp(form.value[email], form.value[password]);
      UserModel user=UserModel(userId:uid,email: form.value[email],userName: form.value[userName],branch: branch);
      SetDataToFireStore.addUserToFireStore(user);
    }

  }
}
