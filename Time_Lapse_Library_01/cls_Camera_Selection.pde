import java.lang.Integer.*;


public class cls_Camera_Selection {

  public Capture Camera;
  public String[] AllCameras;

  //----BLANK CONSTRUCTOR----
  private void  cls_Camera_Selection() {
    AllCameras = new String[Capture.list().length];          // get the list of cameras
    AllCameras = Capture.list();
  }
  //----BLANK CONSTRUCTOR----




  public void SelectCameraByWidth(int WidthSize, int FrameRate) {
    int MinDelta = Integer.MAX_VALUE;
    //ArrayList<int> indicies = new ArrayList<int>();
    ArrayList<String> cameras = new ArrayList<String>();
    
    
    for (int i = 0; i < AllCameras.length; i++){
      Capture cam = new Capture(this,AllCameras[i]);
      println(cam.width);
    }
    
    // go through all the cameras and find the ones with the smallest difference between
    // the desired width and the actual width
    
    // go through the short list of cameras and find the one with the closest frame rate
  }



  //----PRINT OUT THE CAMERA INFORMATION----
  public  void CameraInfo() {
    String[] cameraNames = Capture.list();              // get the list of cameras available

    if (cameraNames.length==0) {
      println("There are no cameras available.");
    } else {
      println("Available cameras: ");
      for (int i = 0; i < cameraNames.length; i++) {    // print the vailable camera names
        println(cameraNames[i]);
      }  // close for
    }    // close if
  }
  //----PRINT OUT THE CAMERA INFORMATION----
}

