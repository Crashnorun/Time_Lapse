


public static class cls_TimeLapseCamera {

  Capture cameras;

 private void  cls_TimeLapseCamera() {
  }

 public static void CameraInfo() {
    String[] cameraNames = Capture.list();

    if (cameraNames.length==0) {
      println("There are no cameras available.");
    } else {
      println("Available cameras: ");
      for (int i = 0; i < cameraNames.length; i++) {
        println(cameraNames[i]);
      }  // close for
    }    // close if
  }
  

}                // close class
//------------------------------------------------

