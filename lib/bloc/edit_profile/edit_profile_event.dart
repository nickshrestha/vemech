part of 'edit_profile_bloc.dart';

abstract class EditProfileEvent {
  const EditProfileEvent();
}


class EditUserProfile extends EditProfileEvent {
  final String? role;
  final String? address;
  final String? phoneNo;
  final String? dob;
  final String? workshopname;
  final String? catagory;
  // final String? panNo;

  const EditUserProfile({
    this.role,
    this.address,
    this.phoneNo,
    this.dob,
    this.workshopname,
    this.catagory,
    // this.panNo,
  });
}
