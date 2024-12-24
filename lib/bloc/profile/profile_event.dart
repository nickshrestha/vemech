part of 'profile_bloc.dart';

abstract class ProfileEvent {
  const ProfileEvent();
}

class UserProfile extends ProfileEvent {}

// class EditUserProfile extends ProfileEvent {
//   final String? role;
//   final String? address;
//   final String? phoneNo;
//   final String? dob;
//   final String? workshopname;
//   final String? catagory;
//   // final String? panNo;

//   const EditUserProfile({
//     this.role,
//     this.address,
//     this.phoneNo,
//     this.dob,
//     this.workshopname,
//     this.catagory,
//     // this.panNo,
//   });
// }
