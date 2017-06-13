//C:\Users\cportelli\Pictures\2015_08_02_Sunset_Time_Lapse

import java.io.*;
import java.util.*;
import java.lang.*;
import java.lang.System;


String path = "C:\\Users\\cportelli\\Pictures\\2015_08_02_Sunset_Time_Lapse - Copy";
//String path = "C:\\Users\\cportelli\\Pictures\\Temp images";
String[] values;
PrintWriter output;
boolean PrintLine;
boolean PrintOutputFile;
boolean PrintStats;

File folder = new File(path);
ArrayList<File> files = new ArrayList<File>();
ArrayList<PImage> images = new ArrayList<PImage>();

int w, h, ImageStep;


void setup() {

  PrintLine = true;
  PrintStats = true;
  PrintOutputFile = true;
  ImageStep = 4;

  // populate the list with all the files
  files.addAll( new ArrayList <File> (Arrays.asList(folder.listFiles())));
  CharSequence cs1 = ".JPG";                                  // create a character sequence
  //CharSequence cs1 = ".jpg";                                // create a character sequence

  if (PrintOutputFile) {
    output = createWriter("Values.txt");
  }

  for (int i = files.size ()-1; i >=0; i--) {                  // go through all the files
    if (!files.get(i).getName().contains(cs1)) {               // if the file isn't a JPG
      if (PrintStats) {
        println("Removed: " + files.get(i));
      }
      if (PrintOutputFile) {
        output.println("Removed: " + files.get(i));
      }

      files.remove(i);                                          // remove that file
    } else {
      //images.add(loadImage(files.get(i).getPath()));          // load the images into a list
    }
  }

  w = loadImage(files.get(0).getPath()).width;                  // set the image width and height
  h = loadImage(files.get(0).getPath()).height;
  if (PrintStats) {
    println("Width: " + w + " | Height: " + h + " | " + files.size() + " Files" + " |Image Step: " + ImageStep);
  }

  if (PrintOutputFile) {
    output.println("Width = " + w);
    output.println("Height = " + h);
    output.println(files.size() + " Files");
  }
  //println(files.get(0).getName());
  size(w, h);

  GetPixelsVertically();
 // GetPixelsHorizontally();
  // Glitch_01();
 // Diagonal_01();
}
//----------------------------------------------------------------------------



void draw() {
}


/// Compile timelapse image into vertical strips
void GetPixelsVertically() {

  PImage newImg = createImage(w, h, RGB);                        // create new image
  int step = w / (files.size() / ImageStep);                     // step size

  if (PrintStats) {
    println("Step: " + step);
  }

  for (int i = 0; i < files.size (); i = i+ImageStep)
  {
    PImage img = loadImage(files.get(i).getPath());              // load the image
    int start = i * step;                                        // set the start and stop values for pixesl to compile
    int stop = (i * step)+ step;

    if (PrintLine) {
      println("Loaded Image: " + files.get(i).getName() + " | Number of Pixels: " + img.pixels.length);
      println("Start: " + start + " | Stop: " + stop);
    }

    for (int j = start; j < stop; j++)                            // start copying vertical stripes
    {
      for (int k = 0; k < img.pixels.length; k=k+w)
      {
        if (PrintLine) {
          println("i: " + i + " | j: " + j + " | k: " + k);
        }
        newImg.pixels[k+j] = img.pixels[k+j];
      }    // close for K
    }      // close for J
  }        // close for I

  image(newImg, 0, 0);
  save("Vertical.jpg");
}
//----------------------------------------------------------------------------


/// Compile pixels horizontally
void GetPixelsHorizontally() {

  PImage newImg = createImage(w, h, RGB);
  int step = newImg.pixels.length/ (files.size() / ImageStep);

  if (PrintStats) {
    println("Step: " + step);
  }

  for (int i = 0; i < files.size (); i = i + ImageStep) {
    PImage img = loadImage(files.get(i).getPath());    // load the image
    int start = i * step;
    int stop = (i * step) + step;

    if (PrintLine) {    
      println("Loaded Image: " + files.get(i).getName());
      println("Start: " + start + " | Stop: " + stop);
    }

    for (int j = start; j < stop; j++) {
      if (PrintLine) {
        println("i: " + i + " | j: " + j);
      }

      newImg.pixels[j] = img.pixels[j];
    }
  }

  image(newImg, 0, 0);
  save("Horizontal.jpg");
}
//----------------------------------------------------------------------------



void Diagonal_01() {

  PImage newImg = createImage(w, h, RGB);                // create a new image
  float diagonalLength = CalcHypotenus(w, h);            // calculate hypotenuse
  float diagonalStep = diagonalLength / (files.size() / ImageStep);    // divide the diagonal length by the number of images

  float OppositeAngle = asin(h / diagonalLength);        // angle calculated in radians, acute angle
  float AdjacentAngle = acos(h / diagonalLength);        // larger angle

  float HStep = diagonalStep / cos(OppositeAngle);       // find horozontal step
  float VStep = diagonalStep / cos(AdjacentAngle);       // find vertical step

  float ShortDiagonal = 0; 
  float LongDiagonal = HStep / sin(OppositeAngle);       // this is the length of the first diagonal

  if (PrintStats) {
    println("Diagonal Length: " + diagonalLength + " | Diagonal Step: " + diagonalStep);
    println("OppositeAngle: " + OppositeAngle + " Radians | AdjacentAngle: " + AdjacentAngle + " Radians");
    println("OppositeAngle: " + degrees(OppositeAngle) + " Deg | AdjacentAngle: " + degrees(AdjacentAngle) + " Deg");
    println("HStep: " + HStep + " | VStep: " + VStep);
    println("ShortDiagonal: " + ShortDiagonal + " | LongDiagonal: " + LongDiagonal);
  }

  if (PrintOutputFile) {
    output.println("Diagonal Length: " + diagonalLength + " | Diagonal Step: " + diagonalStep);
    output.println("OppositeAngle: " + OppositeAngle + " Radians | AdjacentAngle: " + AdjacentAngle + " Radians");
    output.println("OppositeAngle: " + degrees(OppositeAngle) + " Deg | AdjacentAngle: " + degrees(AdjacentAngle) + " Deg");
    output.println("HStep: " + HStep + " | VStep: " + VStep);
    output.println("ShortDiagonal: " + ShortDiagonal + " | LongDiagonal: " + LongDiagonal);
  }

  int Hstart = 0; 
  int Hstop = (int)HStep;
  int Vstart = 0;
  int Vstop = (int)VStep;

  for (int i = 0; i < files.size (); i = i + ImageStep) {

    PImage img = loadImage(files.get(i).getPath());           // load an image

    if (PrintLine) {
      println("First Variable Set: Image #: " + i + " | Hstart: " + Hstart + " | Hstop: " + Hstop + " | Vstart: " + Vstart + " | Vstop: " + Vstop);
    }

    if (PrintOutputFile) {
      output.println("First Variable Set: Image #: " + i + " | Hstart: " + Hstart + " | Hstop: " + Hstop + " | Vstart: " + Vstart + " | Vstop: " + Vstop);
    }

    for (int j = Vstart; j < Vstop; j++) {
      for (int k = Hstart; k < Hstop; k++) {

        if ((k + (j * w)) < img.pixels.length) {
          newImg.pixels[k + (j * w)] = img.pixels[k + (j * w)];
        }
      }    // close k loop


      if (i == 0) {                                                              // the first image is a triangle
        Hstop = (int)(tan(OppositeAngle) * (VStep - (j+1)));                     // at every row calculate the Hstop
      } else if (i == files.size()-1) {
        // the last image is a triangle
      } else {                                                                   // all other images are stripes
        Hstart = (int) ( tan(OppositeAngle) * ( ( VStep * i ) - (j+1) ) );       // calculate the horizontal start
        if (Hstart > w) {
          Hstart = w;
        }

        Hstop = (int)(Hstart + HStep);                                          // calculate the horizontal stop

          if (PrintOutputFile) {
          output.println("Image: " + i + " | Hstart: " + Hstart + " | Hstop: " + Hstop);
        }

        if (Hstart < 0) {
          Hstart = 0;
        }
      }    // close if
    }      // close j loop

    if (PrintLine) {
      println("Second Variable Set: Image #: " + i + " | Hstart: " + Hstart + " | Hstop: " + Hstop + " | Vstart: " + Vstart + " | Vstop: " + Vstop);
    }

    if (PrintOutputFile) {
      output.println("Second Variable Set: Image #: " + i + " | Hstart: " + Hstart + " | Hstop: " + Hstop + " | Vstart: " + Vstart + " | Vstop: " + Vstop);
    }

    Vstart = 0;                           // calculate the vertical start and stop, assuming infinite space, not limited to the size of the image
    Vstop = (int)(VStep * (i + 2));
    Hstart = (int)(HStep * (i + 1));        // calculate the horizontal start and stop, assuming infinite space, not limited to the size of the image
    Hstop = (int)(HStep * (i + 2));

    if (Hstop >= w) {                      // if the Hstop is greater then the width
      Hstop = w;
    }

    if (Hstart >=w) {                      // if the Hstart is greater then the width
      Hstart = w;
    }

    if (Vstop >= h) {                      // if the Vstop is greater then the height
      Vstop = h;
    }
  }      // close I loop

  if (PrintOutputFile) {
    output.flush();
    output.close();
  }

  image(newImg, 0, 0);
  save("Diagonal_01.jpg");
}
//----------------------------------------------------------------------------




float CalcHypotenus(int Opposite, int Adjacent) {
  return sqrt(pow(Opposite, 2) + pow(Adjacent, 2));
}






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

