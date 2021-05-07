typedef FilterChangedCallback<T> = void Function(T newValue);

class Filter {
  final String formatted_address;
  final String categorie;
 /* final String compound_code;*/
  final String name;
  final String rating;
  final String coumpound;


  bool get isDefault {
    return (formatted_address== null && categorie == null && /* compound_code == null && */name== null &&rating ==null && coumpound== null);
  }

  Filter({this.formatted_address, this.categorie, /*this.compound_code, */this.name, this.rating, this.coumpound});
}
