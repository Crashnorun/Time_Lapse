/* //<>// //<>//
 This Processing sketch is meant to take a series of sequential JPG files and 
 stitch them together to create a single image-timelape. The images should all be the same size in order
 for expected results. It is prefered if the image names are sequential, but if there are any missing images
 it won't prevent the application from running. 
 There are are four files that are generated:
 1) One JPG image that contains vertical stripes
 2) One JPG image that contains horizontal stripes
 3) One JPG image that contains diagonal stripes
 4) One JPG image that contains square swatches. The first image in the sequence is the top left square, the last image is the bottom right square
 */

/*
TO DO:
 1) Radial Image1: center is the fist image, edges are the last image
 2) Radial Image2: (similar as above) with checker pattern
 3) ScaneLine Image1: Stitch together the same vertical column of pixels from each image
 4) ScaneLine Image2: (similar as above) Stitch together the same horizontal row of pixels from each image
 5) Make file extension dynamic character sequence. Currently app needs to be explecitly stated if original files are ".jpg" or ".JPG"
 */


import java.io.*;
import java.util.*;
import java.lang.*;
import java.lang.System;
//import java.util.Comparator;


//----GLOBAL VARIABLES----
String[] values;
PrintWriter output;
boolean PrintLine;            // Debugging tools
boolean PrintStats;           // Debugging with more detail
boolean PrintOutputFile;      // Output txt file with debugging values for the diagonal images

//String path = "C:\\Users\\charl\\Documents\\Personal\\Photos\\170924_Empire_State_Time_Lapse\\JPG's";
String path = "E:\\_Flux\\08_Laptop_Download\\GitHub\\Time_Lapse\\Compile_Images_01\\Test Images\\Images_01";
File folder = new File(path);                                   // folder where all the original JPG's are stored
ArrayList<File> files = new ArrayList<File>();                  // will hold all the original JPG files
ArrayList<PImage> images = new ArrayList<PImage>();
cls_CompareImages compareImages = new cls_CompareImages();

int w, h, ImageStep;
//----GLOBAL VARIABLES----


/*
  In order to set the canvas size by parameters, it needs to be done in the SETTINGS function
 */
void settings() {
  // populate the list with all the files
  files.addAll( new ArrayList <File> (Arrays.asList(folder.listFiles())));

  // set the canvas size equal to image width and height
  w = loadImage(files.get(0).getPath()).width;                 
  h = loadImage(files.get(0).getPath()).height;
  size(w, h);
}
//----------------------------------------------------------------------------


/*
  SETUP function runs after SETTINGS function
 */
void setup() {

  PrintLine = false;                                         // debugging tools
  PrintStats = true;
  PrintOutputFile = false;
  ImageStep = 1;                                             // process only every n'th image

  //CharSequence cs1 = ".JPG";                               // create a character sequence for file extension
  CharSequence cs1 = ".jpg";                                 // create a character sequence

  if (PrintOutputFile) 
    output = createWriter("Values.txt");                     // create output text file for debugging


  for (int i = files.size ()-1; i >=0; i--) {                // go through all the files
    if (!files.get(i).getName().contains(cs1)) {             // if the file isn't a JPG

      if (PrintStats) println("Removed: " + files.get(i));                 
      if (PrintOutputFile) output.println("Removed: " + files.get(i));

      files.remove(i);                                       // remove any files that don't have a .jpg extension
    } else {
      //images.add(loadImage(files.get(i).getPath()));       // load the images into a list
    }
  }

  if (PrintStats) {
    PImage img = loadImage(files.get(0).getPath());          // load the image
    println("Width: " + w + " | Height: " + h + " | " + 
      files.size() + " Files" + " | Image Step: " + ImageStep + " | Number of Pixels: " + img.pixels.length);
  }

  if (PrintOutputFile) {
    output.println("Width = " + w);
    output.println("Height = " + h);
    output.println(files.size() + " Files");
  }
  //println(files.get(0).getName());

  GetPixelsVertically();                                     // create image with vertical stripes
  GetPixelsHorizontally();                                   // create image with horizontal stripes
  GetPixelsDiagonalally();                                   // create image with diagonal stripes
  GetPixelsSquares();                                        // create image with square swatches
  // Glitch_01();
}
//----------------------------------------------------------------------------


void draw() {
}


/* 
 Compile sequence of jpg images into a single image by stitching vertical stripes from left to right
 */
void GetPixelsVertically() {

  println("----STARTING VERTICAL IMAGE----");
  PImage newImg = createImage(w, h, RGB);                    // create new image
  float stripeWidth = w / (float)files.size();               // calculate width of the stripes

  if (PrintStats) println("Stripe Width: " + stripeWidth);

  for (int i = 0; i < files.size (); i = i + ImageStep)      // go through all the images
  {
    PImage img = loadImage(files.get(i).getPath());          // load the image
    int start = (int)(i * stripeWidth);                      // set the start and stop values for pixels to compile
    int stop = (int)((i * stripeWidth) + (stripeWidth * ImageStep));

    if (PrintStats) 
      println("Loaded Image: " + files.get(i).getName() + " | Image Number: " + i + " of: " + files.size());

    if (PrintLine) 
      println("  Start: " + start + " | Stop: " + stop);

    for (int j = start; j < stop; j++)                       // start copying vertical stripes (X direction)
    {
      for (int k = 0; k < img.pixels.length; k = k + w)      // (Y direction)
      {
        if (PrintLine) println("i: " + i + " | j: " + j + " | k: " + k);

        if ((k + j) < img.pixels.length) {
          newImg.pixels[k + j] = img.pixels[k + j];
        }
      }    // close for K
    }      // close for J
  }        // close for I

  image(newImg, 0, 0);                                       // create new vertical image
  save("01_Vertical_ImageStep_" + ImageStep +".jpg");        // save vertical image
  println("----FINISH VERTICAL IMAGE----");
}
//----------------------------------------------------------------------------


/* 
 Compile sequence of jpg images into a single image by stitching horizontal stripes from top to bottom
 */
void GetPixelsHorizontally() {

  println("----STARTING HORIZONTAL IMAGE----");
  PImage newImg = createImage(w, h, RGB);                    // create new image
  float stripSize = (w * h)/ (float)files.size();            // calculate height of the stripes

  if (PrintStats) 
    println("Step: " + stripSize);

  for (int i = 0; i < files.size (); i = i + ImageStep)      // go through all the images 
  {
    PImage img = loadImage(files.get(i).getPath());          // load the image
    int start = (int)(i * stripSize);                        // set the start and stop values for the pixes to compile
    int stop = (int)((i * stripSize) + (stripSize * ImageStep));

    if (PrintStats)     
      println("Loaded Image: " + files.get(i).getName() + " | Image Number: " + i + " of: " + files.size());

    if (PrintLine) 
      println("Start: " + start + " | Stop: " + stop);

    for (int j = start; j < stop; j++) 
    {
      if (PrintLine) println("i: " + i + " | j: " + j);

      if (j < img.pixels.length) {                           // just in case
        newImg.pixels[j] = img.pixels[j];
      }
    }
  }

  image(newImg, 0, 0);                                       // create new vertical image
  save("02_Horizontal_ImageStep_" + ImageStep +".jpg");      // save horizontal image
  println("----FINISHED HORIZONTAL IMAGE----");
}
//----------------------------------------------------------------------------


void GetPixelsSquares() {
  println("----STARTING SQUARE IMAGE----");

  PImage newImg = createImage(w, h, RGB);

  float diagonalLength = CalcHypotenus(w, h);            // calculate hypotenuse, diagonal length of image
  float diagonalStep = diagonalLength / (files.size() / ImageStep);    // divide the diagonal length by the number of images

  float OppositeAngle = asin(h / diagonalLength);        // angle calculated in radians, acute angle
  float AdjacentAngle = acos(h / diagonalLength);        // larger angle

  float Hstep = diagonalStep / cos(OppositeAngle);       // find horozontal step
  float Vstep = diagonalStep / cos(AdjacentAngle);       // find vertical step

  float numRows = h / Vstep;                             // number of rows
  float numCols = w / Hstep;                             // number of columns

  ArrayList<cls_Image> imageRanges = new ArrayList<cls_Image>();
  imageRanges = CalculateImageRanges(numRows, numCols, Hstep, Vstep, ImageStep);    // calculate the range of pixels needed from each image

  if (PrintStats) {
    println("Number of rows: " + numRows + " | Number of columns: " + numCols + " | Hstep: " + Hstep + " | Vstep: " + Vstep);
  }

  for (int i = 0; i < imageRanges.size(); i++) {
    cls_Image tempImage = imageRanges.get(i);
    PImage img = loadImage(files.get(tempImage.indexNumber).getPath());           // load an image

    if (PrintStats) {
      println("Reading image: " + i + " of: " + imageRanges.size() +" | " + files.get(tempImage.indexNumber).getName());
    }

    for (int j = 0; j < tempImage.ranges.size(); j++) {
      cls_Range range = tempImage.ranges.get(j);
      for (int x = (int)range.Hrange.x; x < (int)range.Hrange.y; x++) {
        for (int y = (int)range.Vrange.x; y < (int)range.Vrange.y; y++) {
          try {
            newImg.pixels[(y * w) + x] = img.pixels[(y * w) + x];
          } 
          catch (Exception e) {
            println("Exception: " + e + " Image: " + i + " X: " + x + " | Y: " + y);
          }
        }
      }
    }
  }

  image(newImg, 0, 0);
  save("04_Square_ImageStep_" + ImageStep +".jpg");
  println("----SQUARE IMAGE DONE----");
}
//----------------------------------------------------------------------------


/*
  Compile sequence of jpg images into a single image by stitching diagonal stripes from top left to bottom right.
 This one was tricky at first, hence the debugging features.
 */
void GetPixelsDiagonalally() {

  println("----STARTING DIAGONAL IMAGE----");
  PImage newImg = createImage(w, h, RGB);                    // create new image
  float diagonalLength = CalcHypotenus(w, h);                // calculate hypotenuse of image
  float diagonalStipeSize = diagonalLength / (files.size() / ImageStep);    // divide the diagonal length by the number of images

  float OppositeAngle = asin(h / diagonalLength);            // angle calculated in radians, acute angle
  float AdjacentAngle = acos(h / diagonalLength);            // larger angle

  float HStep = diagonalStipeSize / cos(OppositeAngle);      // find horizontal step
  float VStep = diagonalStipeSize / cos(AdjacentAngle);      // find vertical step

  float ShortDiagonal = 0; 
  float LongDiagonal = HStep / sin(OppositeAngle);           // this is the length of the first diagonal

  if (PrintStats) {
    println("Diagonal Length: " + diagonalLength + " | Diagonal Step: " + diagonalStipeSize);
    println("OppositeAngle: " + OppositeAngle + " Radians | AdjacentAngle: " + AdjacentAngle + " Radians");
    println("OppositeAngle: " + degrees(OppositeAngle) + " Deg | AdjacentAngle: " + degrees(AdjacentAngle) + " Deg");
    println("HStep: " + HStep + " | VStep: " + VStep);
    println("ShortDiagonal: " + ShortDiagonal + " | LongDiagonal: " + LongDiagonal);
  }

  if (PrintOutputFile) {
    output.println("Diagonal Length: " + diagonalLength + " | Diagonal Step: " + diagonalStipeSize);
    output.println("OppositeAngle: " + OppositeAngle + " Radians | AdjacentAngle: " + AdjacentAngle + " Radians");
    output.println("OppositeAngle: " + degrees(OppositeAngle) + " Deg | AdjacentAngle: " + degrees(AdjacentAngle) + " Deg");
    output.println("HStep: " + HStep + " | VStep: " + VStep);
    output.println("ShortDiagonal: " + ShortDiagonal + " | LongDiagonal: " + LongDiagonal);
  }

  int Hstart = 0;                                            // horizontal start and stop   
  int Hstop = (int)HStep;
  int Vstart = 0;                                            // vertical start and stop
  int Vstop = (int)VStep;

  for (int i = 0; i < files.size (); i = i + ImageStep) 
  {
    PImage img = loadImage(files.get(i).getPath());          // load an image

    if (PrintStats) 
      println("First Variable Set: Image: " + i + " of: " + files.size() + 
        " | Hstart: " + Hstart + " | Hstop: " + Hstop + " | Vstart: " + Vstart + " | Vstop: " + Vstop);

    if (PrintOutputFile) 
      output.println("First Variable Set: Image: " + i + " of: " + files.size() + 
        " | Hstart: " + Hstart + " | Hstop: " + Hstop + " | Vstart: " + Vstart + " | Vstop: " + Vstop);

    for (int j = Vstart; j <= Vstop; j++) {
      for (int k = Hstart; k <= Hstop; k++) {

        if ((k + (j * w)) < img.pixels.length) {
          newImg.pixels[k + (j * w)] = img.pixels[k + (j * w)];  // save the pixels
        }
      }    // close k loop

      if (i == 0) {                                              // the first image is a triangle
        Hstop = (int)(tan(OppositeAngle) * (VStep - (j + 1)));   // at every row calculate the Hstop
      } else if (i == files.size() - 1) {
        // the last image is a triangle
      } else {                                                   // all other images are stripes
        Hstart = (int) ( tan(OppositeAngle) * ( ( VStep * (i/ImageStep) ) - (j+1) ) );       // calculate the horizontal start
        if (Hstart > w) Hstart = w;

        Hstop = (int)(Hstart + HStep);                           // calculate the horizontal stop

        if (PrintOutputFile) output.println("Image: " + i + " | Hstart: " + Hstart + " | Hstop: " + Hstop);

        if (Hstart < 0) Hstart = 0;
      }    // close if
    }      // close j loop

    if (PrintLine) 
      println("Second Variable Set: Image #: " + i + " | Hstart: " + Hstart + " | Hstop: " + Hstop + " | Vstart: " + Vstart + " | Vstop: " + Vstop);

    if (PrintOutputFile) 
      output.println("Second Variable Set: Image #: " + i + " | Hstart: " + Hstart + " | Hstop: " + Hstop + " | Vstart: " + Vstart + " | Vstop: " + Vstop);

    Vstart = 0;                           // calculate the vertical start and stop, assuming infinite space, not limited to the size of the image
    Vstop = (int)(VStep * (i + 2));
    Hstart = (int)(HStep * (i + 1));      // calculate the horizontal start and stop, assuming infinite space, not limited to the size of the image
    Hstop = (int)(HStep * (i + 2));

    if (Hstop >= w) {                     // if the Hstop is greater then the width
      Hstop = w;
    }

    if (Hstart >=w) {                     // if the Hstart is greater then the width
      Hstart = w;
    }

    if (Vstop >= h) {                     // if the Vstop is greater then the height
      Vstop = h;
    }
  }      // close I loop

  if (PrintOutputFile) {
    output.flush();
    output.close();
  }

  image(newImg, 0, 0);
  save("03_Diagonal_ImageStep_" + ImageStep +".jpg");
  println("----FINISHED DIAGONAL IMAGE----");
}
//----------------------------------------------------------------------------



/*
  Calculate the diagonal length of a right angle triangle. 
 Used to calculate the diagonal length of the image
 */
float CalcHypotenus(int Opposite, int Adjacent) {
  // A^2 + B^2 = C^2
  return sqrt(pow(Opposite, 2) + pow(Adjacent, 2));
}
//----------------------------------------------------------------------------


ArrayList<cls_Image> CalculateImageRanges(float numRows, float numCols, float Hstep, float Vstep, int ImageStep) {

  int shiftIndex = 0;
  float Hstart, Hstop;
  float Vstart, Vstop;
  ArrayList<cls_Image> images = new ArrayList<cls_Image>();

  for (int i = 0; i < numRows; i++) {
    Vstart = (i * Vstep);
    Vstop = (i * Vstep) + Vstep;
    if (Vstop > h)
      Vstop = h;

    for (int j = 0; j < numCols; j++) {

      if (PrintStats) {
        println("Row: " + i + " | Column: " + j +" | Eval image: "+ (shiftIndex + (j * ImageStep)));
      }
      cls_Image tempImg = new cls_Image(shiftIndex + (j * ImageStep));

      int ReturnIndex = compareImages.compare(images, tempImg);              // if image exists in list, return index number. if images does not exist return -1
      if (ReturnIndex == -1) {
        images.add(tempImg);                                                 // image does not exist, add image
      } else {
        tempImg = images.get(ReturnIndex);                                   // image exists, get image
      }

      Hstart = j * Hstep;
      Hstop = (j * Hstep) + Hstep;
      if (Hstop > w)
        Hstop = w;

      PVector HRange = new PVector(Hstart, Hstop);                            // horizontal range
      PVector VRange = new PVector(Vstart, Vstop);                            // vertical range
      cls_Range tempRange = new cls_Range(HRange, VRange);
      tempImg.ranges.add(tempRange);                                          // add range to image range list
    }    // close j
    shiftIndex++;
  }   // close i

  if (PrintStats)
    println("ImageRanges.size = " + images.size());
  return images;
}
//----------------------------------------------------------------------------


void Glitch_01() {

  PImage newImg = createImage(w, h, RGB);              // create a new image
  float diagonalLength = CalcHypotenus(w, h);          // calculate hypotenuse
  int step = (int)diagonalLength/files.size();         // divide the diagonal length by the number of images
  println("Diagonal Length = " + diagonalLength + " | Diagonal Step = " + step);

  float Hfactor = w / step;  
  float stepH = diagonalLength / Hfactor;              // this will be the horizontal step per stripe
  println("Horizontal Step = " + stepH);

  float Vfactor = h / step;
  float stepV = diagonalLength / Vfactor;              // this will be the vertical step per stripe 
  println("Vertical Step = " + stepV);

  int pixelCount = 0;
  int imageCount = 0;
  int rowCount = 0;
  int shiftFactor = 0;
  PImage img = loadImage(files.get(imageCount).getPath());    // load the first image

  int startMin = minute();
  int startSec = second();

  for (int i = 0; i < newImg.pixels.length; i++) {    // go through all the pixels

    if (i % stepH < 1) {  // load a new image at every horizontal step
      //println("Pixel Num = " + i + " | Image Count = " + imageCount + " | I mod w = " + i % w + " | Row Count = " + rowCount + " | Image Name = " + files.get(imageCount).getPath());
      img = loadImage(files.get(imageCount).getPath());      // load an image
      imageCount++;
    }

    newImg.pixels[i] = img.pixels[i]; 

    if (i % w == 0) {  // when I gets to the end of each row
      if (i > 0) {
        imageCount = 0;
        //imageCount = (int)(rowCount % stepV);
        //imageCount = (int) ((rowCount / stepV) % h) ;
        //println("Image Count = " + imageCount + " - Pixel# = " + i);
      }
    }

    // image count is dependent on the row that is being processed and the horizontal step 
    // when the row number >= vertical step then image count starts at 1

    if (i % w ==0) {
      int stopMin = minute();
      int stopSec = second();
      rowCount++;
      println("Row Count = " + rowCount + " | Delta Time = " + (startMin - stopMin) + " : " + (startSec - stopSec));
      startMin = minute();
      startSec = second();
    }

    if (rowCount < stepV) {
      shiftFactor++;
    }
    System.gc();
  }

  image(newImg, 0, 0);
  save("Glitch_01.jpg");
}      // close diagonally
//----------------------------------------------------------------------------





void Glitch_02() {

  PImage newImg = createImage(w, h, RGB);
  float diagonalLength = CalcHypotenus(w, h);          // calculate hypotenuse
  int step = (int)diagonalLength/files.size();         // divide the diagonal length by the number of images
  println("Diagonal Length = " + diagonalLength + " | Diagonal Step = " + step);

  float Hfactor = w / step;  
  float stepH = diagonalLength / Hfactor;              // this will be the horizontal step per stripe
  println("Horizontal Step = " + stepH);

  float Vfactor = h / step;
  float stepV = diagonalLength / Vfactor;              // this will be the vertical step per stripe 
  println("Vertical Step = " + stepV);

  int pixelCount = 0;
  int imageCount = 0;
  int rowCount = 0;
  int shiftFactor = 0;
  PImage img = loadImage(files.get(imageCount).getPath());

  int startMin = minute();
  int startSec = second();

  for (int i = 0; i < newImg.pixels.length; i++) {    // go through all the pixels


    if (i % stepH < 1) {  // load a new image at every horizontal step
      //println("Pixel Num = " + i + " | Image Count = " + imageCount + " | I mod w = " + i % w + " | Row Count = " + rowCount + " | Image Name = " + files.get(imageCount).getPath());
      img = loadImage(files.get(imageCount).getPath());      // load an image
      imageCount++;
    }

    newImg.pixels[i] = img.pixels[i]; 

    if (i % w == 0) {  // reset the image counter at every row
      if (i > 0) {
        if (rowCount < stepV) {  // 
          imageCount = 0;
        }

        if (rowCount % stepV < 1) {
          //imageCount =  (int)(rowCount / stepV);
          imageCount = 0;
        }
      }
    }

    if (i % w ==0) {
      int stopMin = minute();
      int stopSec = second();
      rowCount++;
      println("Row Count = " + rowCount + " | Delta Time = " + (startMin - stopMin) + " : " + (startSec - stopSec));
      startMin = minute();
      startSec = second();
    }

    if (rowCount < stepV) {
      shiftFactor++;
    }
    System.gc();
  }

  image(newImg, 0, 0);
  save("Glitch.jpg");
}      // close diagonally
//----------------------------------------------------------------------------