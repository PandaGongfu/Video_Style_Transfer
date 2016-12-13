# Paint_Your_Video_in_Style
Artistic style transfer for videos.  

## Goal  
This goal of this project is to use deep learning to perform style transfer on videos.  

## Intro  
Style transfer on static images has been widely researched. However, studies on video style transfer are fairly new. In this project, I applied the method from [this paper](https://arxiv.org/pdf/1604.08610v2.pdf). Their implementation was in lua with torch as the backend. I modified the Keras neural transfer example to incorporate the image warping and temporal constraints. Please refer to [my blog](https://pandagongfu.github.io/) for details. And I'd like to thank [Manuel Ruder](https://github.com/manuelruder/artistic-videos) and [Somshubra Majumdar](https://github.com/titu1994/Neural-Style-Transfer) for their wonderful github repos. 

## Stylized Videos  
Please enjoy the following two videos that I created for this project:  
[Flying bat in starry night style](https://www.youtube.com/watch?v=5QdC1OQ0xe4)   
[Game of Throne style transitions between muse and scream](https://www.youtube.com/watch?v=y0ddOVEHUO4)  

## Approach  
The workflow is as follows:  
1. Scraped 20k images of paintings and pictures from Flickr to finetune the last convolutional layer of VGG16 so that it is able to distinguish paintings from pictures at 88%.   
2. Generate optical flow and weights for temporal constraints using [deep matching](http://lear.inrialpes.fr/src/deepmatching/).   
3. Perform style transfer on frames with initialization and temporal loss.  

In this repo, jupyter notebooks for step 1 and 3 are included. Also included are the shell script and files that are used in step 2 (you will need additional files from [Manuel Ruder's github](https://github.com/manuelruder/artistic-videos) to obtain optical flows).  
