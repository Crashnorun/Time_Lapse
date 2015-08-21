// Import video library
import processing.video.*;
//http://docs.oracle.com/javase/7/docs/api/java/io/File.html
import java.io.*;
import javax.swing.filechooser.*;


// call camera
// get camera settings

void setup() {

  size(640, 480);
 // cls_TimeLapseCamera.CameraInfo();
  cls_TimeLapseCamera.ReadLoadImages("C:\\Users\\cportelli\\Pictures\\2015_06_14_GWB\\", ".jpg");
 
  
}      // close setup
//--------------------------------------------------------------------


void draw() {
}      // close draw
//--------------------------------------------------------------------

