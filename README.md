# acoustigif

This is a Bash script for combining a `.gif` file with a `.mp3` file into an `.mp4` file.

## Motivation

I record DJ mixes and like to overlay some animation on top of the recordings. This is a simple task to accomplish and doesn't even need OpenShot or VLC. I like using the minimal amount of tools required for a task, so I wrote a script that's barely longer than this README document.

## Requirements

1. Bash shell
2. ffmpeg, as well as ffprobe which should come with the former

## Usage

Run `bash acoustigif.sh input.gif input.mp3` and the video will be saved as `output.mp4` in the current directory.
