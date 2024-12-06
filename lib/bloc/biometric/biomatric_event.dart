part of 'biomatric_bloc.dart';


abstract class BiomatricEvent   {
    const BiomatricEvent();

  List<Object> get props => [];

  
}

class BiomatricLogin extends BiomatricEvent {
  final String token; 
  const BiomatricLogin (this.token);
  @override
  List<Object> get props => [token];

}
class BiomatricAccess extends BiomatricEvent {  
}
