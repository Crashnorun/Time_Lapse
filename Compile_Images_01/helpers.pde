 //<>// //<>//

class cls_Image {

  int indexNumber;
  ArrayList<cls_Range> ranges;

  cls_Image(int index) {
    ranges = new ArrayList<cls_Range>();
    this.indexNumber = index;
  }

  void AddRange(cls_Range range) {
    ranges.add(range);
  }

  void AddRange(int Hstart, int Hstop, int Vstart, int Vstop) {
    cls_Range range = new cls_Range(Hstart, Hstop, Vstart, Vstop);
    ranges.add(range);
  }

  boolean Compare( int imageIndex) {
    println("Comparing");
    if (this.indexNumber == imageIndex) {
      print(" true");
      return true;
    } else {
      print(" false");
      return false;
    }
  }
}
//-------------------------------------------

class cls_Range {

  PVector Hrange;
  PVector Vrange;

  cls_Range(int Hstart, int Hstop, int Vstart, int Vstop) {
    Hrange = new PVector(Hstart, Hstop);
    Vrange = new PVector(Vstart, Vstop);
  }

  cls_Range(PVector HRange, PVector VRange) {
    Hrange = HRange;
    Vrange = VRange;
  }
}
//-------------------------------------------


/*reference: https://docs.oracle.com/javase/7/docs/api/java/util/Comparator.html
 *  returns -1 if first object is less then second object
 *  returns 0 if objects are equal
 *  returns 1 if first object is greater then second object
 */
class cls_CompareImages {
  int compare(ArrayList<cls_Image> images, cls_Image another) {
    int ReturnVal = -1;

    for (int i = 0; i < images.size(); i ++) {
      if (images.get(i).indexNumber == another.indexNumber) {
        ReturnVal = i;
        return ReturnVal;
      }
    }
    return ReturnVal;
  }
}
//-------------------------------------------