# Time Lapse

The Time Lapse repo is a personal project of mine that deals with time lapse photography and images. This repo was developed using Processing version 3.2.3, on Windows PC. Newer versions of Processing might need some minor modifications to the code.

## Compile\_Images\_01

### Intro:

The goal of this project is to develop a Processing app for compiling a series of sequential jpg&#39;s into a single image. The images can come from any source, I typically use a DSLR camera, but any image collection should work. It&#39;s best if the file names are sequential but if there are files missing from the sequence, the app should still work. The files are consumed in alphabetical / numerical order. The images should be of the same dimensions (width x height). The size of the images should not matter, nor should the quantity of images, but the larger the image sizes and the larger the collection the longer the app may take to process them. Check out [my website](https://www.charlesportelli.com/play-1/#/time-lapse/) to see the results from this app. For a list of all my projctes check out: [www.CharlesPortelli.com](https://www.charlesportelli.com)

### Requirements:

- Processing 3.2.3 or later
- Folder with sequential jpg&#39;s
- Image dimensions (width x height) should be the same for expected results.
- The image file extension is currently case sensitive. Use .jpg or .JPG for all images.

### Variables:

- String indicating folder location
- Step Number: number of images to skip (1 = use all files, 2 = use every other file, etc.)

### Results:

This app will create 4 different compiled images

- Vertical stitching ![Vertical Stitching](https://github.com/Crashnorun/Time_Lapse/blob/master/Compile_Images_01/Sample%20Images/01_Vertical_ImageStep_5.jpg)
- Horizontal stitching ![Horizontal Stitching](https://github.com/Crashnorun/Time_Lapse/blob/master/Compile_Images_01/Sample%20Images/02_Horizontal_ImageStep_5.jpg)
- Diagonal stitching ![Diagonal Stitching](https://github.com/Crashnorun/Time_Lapse/blob/master/Compile_Images_01/Sample%20Images/03_Diagonal_ImageStep_5.jpg)
- Square swatches ![Square Swatches](https://github.com/Crashnorun/Time_Lapse/blob/master/Compile_Images_01/Sample%20Images/04_Square_ImageStep_5.jpg)

## Time\_Lapse\_Library\_01

This app is a work in progress.

COMPILING IMAGES Features of this class will include:

- list the information of the web camera
- import images from a specific folder
- create a time lapse image with vertical stripes
- create a time lapse image with horizontal stripes
- create a time lapse image with diagonal stripes
- create a time lapse image with the same vertical strip from all images
- create a time lapse image with the same horizontal stripe from all images
- create a time lapse image with the same diagonal strip from all images

TAKING IMAGES The class will also be able to take a sequence of images. The user can set:

- the image sizes
- the time interval between images
- the start times
- the stop times
- the number of images between a start and stop time

COMPILING VIDEO This class will also be able to compile a series of images and create a time lapse gif or animation. The user can:

- select a sequence of images
- set the length of the video
- set the fps
- set the time interval between frames
