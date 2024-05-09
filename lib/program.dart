class vechicle {
  late String a;
  vechicle(this.a) {
    print("Contructor Called $a");
  }
}

class bike extends vechicle {
  bike(super.a);

}

main() {
  bike ob1 = bike("ABC");

}
