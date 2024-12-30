import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vemech/bloc/appointment/appointment_bloc.dart';

class Appointment extends StatefulWidget {
  const Appointment({
    super.key,
  });

  @override
  State<Appointment> createState() => _AppointmentState();
}

class _AppointmentState extends State<Appointment> {
  @override
  void initState() {
    final appointmentState = context.read<AppointmentBloc>().state;
    if (appointmentState is! AppointmentSuccessState) {
      BlocProvider.of<AppointmentBloc>(context).add(const WorkshopsLsit());
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AppointmentBloc, AppointmentState>(
        builder: (context, appointmentState) {
          return SingleChildScrollView(
            child: Column(
              children: [
                if (appointmentState is AppointmentSuccessState)
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
              itemCount: appointmentState.workshoplist.length,
              itemBuilder: (context, index) {
                var profile =  appointmentState.workshoplist[index];

                return Column(
                  children: [
                    ListTile(
                      title: Text(profile.user.username),
                      subtitle: Text(profile.user.email),
                      onTap: () {
                        // You can handle navigation or any other action here
                      },
                    ),
        //              SingleChildScrollView(
        //   scrollDirection: Axis.horizontal,
        //   child: Row(
        //     children: List.generate(
        //       profile.,
        //       (index) => Padding(
        //         padding: const EdgeInsets.all(8.0),
        //         child: Container(
        //           width: 250,
        //           padding: EdgeInsets.all(10),
        //           decoration: BoxDecoration(
        //               color: Colors.white,
        //               borderRadius: BorderRadius.circular(10),
        //               border: Border.all(color: Colors.green, width: 2)),
        //           child:  Column(
        //             mainAxisAlignment: MainAxisAlignment.start,
        //             crossAxisAlignment: CrossAxisAlignment.start,
        //             children: [
        //               Text(
        //                 workshopRecommendation[index].workshopName,
        //                 style: TextStyle(
        //                     fontSize: 15, fontWeight: FontWeight.w700),
        //               ),
        //               Text("Owner: ${workshopRecommendation[index].user.firstName} ${workshopRecommendation[index].user.lastName}",),
        //               Text("Category: ${workshopRecommendation[index].category}"),
        //               Text("Book now."),
        //             ],
        //           ),
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
                 
                  ],
                );
              },
            )
              ],
            ),
          );
        }
      ),
    );
  }
}
