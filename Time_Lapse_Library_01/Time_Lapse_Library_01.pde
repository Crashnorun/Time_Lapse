// Import video library
import processing.video.*;
//http://docs.oracle.com/javase/7/docs/api/java/io/File.html
import java.io.*;
//import javax.swing.filechooser.*;


// call camera
// get camera settings

void setup() {

  size(640, 480);
 // cls_TimeLapseCamera.CameraInfo();
  //cls_TimeLapseCamera.ReadLoadImages("C:\\Users\\cportelli\\Pictures\\2015_08_02_Sunset_Time_Lapse\\", ".jpg");
 
 cls_Camera_Selection camSel = new cls_Camera_Selection();
 camSel.CameraInfo();
 
  
}      // close setup
//--------------------------------------------------------------------


void draw() {
}      // close draw
//--------------------------------------------------------------------

