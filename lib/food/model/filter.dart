typedef FilterChangedCallback<T> = void Function(T newValue);

class Filter {
  final String ville;
  final String type;
 /* final String compound_code;*/
  final String name;
  final String rating;
  final String coumpound;


  bool get isDefault {
    return (ville== null && type == null && /* compound_code == null && */name== null &&rating ==null && coumpound== null);
  }

  Filter({this.ville, this.type, /*this.compound_code, */this.name, this.rating, this.coumpound});
}
