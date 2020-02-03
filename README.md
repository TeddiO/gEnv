# gEnv
A small GMod C++ module to enable reading / setting environment variables

## A few footnotes...

- Premake5 doesn't seem to play too nice with the latest xcode options, meaning...
    - For MacOS you need to ensure the flag for searching user paths is enabled otherwise XCode won't pick up your garrysmod headers.
    - You'll also likely need to turn off debug symbols manually for the release profile.