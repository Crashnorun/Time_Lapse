//http://docs.oracle.com/javase/7/docs/api/javax/swing/filechooser/FileNameExtensionFilter.html

public static class cls_TimeLapseCamera {

  public float TimeInterval;
  public String[] ImageNames;
  public PImage[] Images;


  //----BLANK CONSTRUCTOR----
  private void  cls_TimeLapseCamera() {
  }
  //----BLANK CONSTRUCTOR----


  //----READ THE FILES IN THE FOLDER----
  public static void ReadLoadImages(String FolderLocation, String... FileExtension) {

    File folder = new File(FolderLocation);
    // java.io.FileFilter ext = new ExtensionFilter("JPEG file", "jpg", "jpeg");

    //File ext = new File(".jpg");
    //FileFilter filter = new FileFilter();
    //  http://stackoverflow.com/questions/5603966/how-to-make-filefilter-in-java
    //   http://docs.oracle.com/javase/7/docs/api/javax/swing/filechooser/FileFilter.html
    //   http://www.tutorialspoint.com/java/io/file_listfiles_file_filter.htm
    //   http://alvinalexander.com/blog/post/java/how-implement-java-filefilter-list-files-directory


    if (folder.isDirectory() && folder.exists()) {
      println("Number of files in folder: " + folder.listFiles().length);
      for (int i = 0; i < folder.listFiles ().length; i++) {
        /////////////////////////
      }
    } else {
      println("Folder path supplied cannot be found");
    }
  }
  //----READ THE FILES IN THE FOLDER----


  //----PRINT OUT THE CAMERA INFORMATION----
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
  //----PRINT OUT THE CAMERA INFORMATION----
}                // close class
//------------------------------------------------

