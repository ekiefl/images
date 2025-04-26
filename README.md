**Note** This repo is inspired by [this blog](https://www.lambdalatitudinarians.org/techblog/2022/10/21/optimizing-jekyll-images/). The following README is mostly a copy-paste from [this repo](https://github.com/nathan-contino/images).

# Images

This repository contains images and other blobs that I use on my website.

By storing this content here, instead of on my blog, my Jekyll site stays lean, mean, and quick to deploy.

# Instructions

Install required conversion tools:

```
brew install webp
brew install imagemagick # For conversion from HEIC
```

First, dump an album of images into a directory within `images/`.

Then resulting

```
./process_images.sh
```

It will make WEBP equivalents of all your images for 3 different qualities:

- **High** - images/
- **Medium** - reasonably-sized/
- **Low** - thumbnails/

After generating the WEBP images, feel free to delete the original images; the WEBPs should be close enough in quality, and a _lot_ smaller.

```
./delete_non_webp.sh
```

If you need PNG versions of your WebP images (for compatibility with applications that don't support WebP), you can convert them using:

```
./convert_to_png.sh
```

This will create PNG versions of all WebP images in the `pngs/` directory while maintaining the original folder structure.

Double check that the images look correct, haven't rotated, and have reasonable sizes (generally less than 1MB for "reasonable", and less than 250KB for thumbnails). If an image rotates, you can use the following `imagemagick` command to fix it:

```
magick convert <image>.webp -rotate 90 <image>.webp
```

You might have to run the command 2-3 times to get the image into the right orientation.
