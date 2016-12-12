set -e
# Get a carriage return into `cr`
cr=`echo $'\n.'`
cr=${cr%.}

# Parse arguments
filename=$(basename "$1")
extension="${filename##*.}"
filename="${filename%.*}"
filename=${filename//[%]/x}

# Create output folder
mkdir -p $filename

echo ""
read -p "Which backend do you want to use? \
For Nvidia GPU, use cudnn if available, otherwise nn. \
For non-Nvidia GPU, use clnn. Note: You have to have the given backend installed in order to use it. [nn] $cr > " backend
backend=${backend:-nn}

if [ "$backend" == "cudnn" ]; then
  echo ""
  read -p "This algorithm needs a lot of memory. \
  For a resolution of 450x350 you'll need roughly 2GB VRAM. \
  VRAM usage increases linear with resolution. \
  Please enter a resolution at which the video should be processed, \
  in the format w:h, or leave blank to use the original resolution $cr > " resolution
elif [ "$backend" = "nn" ] || [ "$backend" = "clnn" ]; then
  echo ""
  read -p "This algorithm needs a lot of memory. \
  For a resolution of 450x350 you'll need roughly 4GB VRAM. \
  VRAM usage increases linear with resolution. \
  Maximum recommended resolution with a Titan X 12GB: 960:540. \
  Please enter a resolution at which the video should be processed, \
  in the format w:h, or leave blank to use the original resolution $cr > " resolution
else
  echo "Unknown backend."
  exit 1
fi

echo ""
read -p "Enter the zero-indexed ID of the GPU to use, or -1 for CPU mode (very slow!).\
 [0] $cr > " gpu
gpu=${gpu:-0}

echo ""
echo "Computing optical flow. This may take a while..."
bash makeOptFlow.sh ./${filename}/frame_%04d.ppm ./${filename}/flow_$resolution
