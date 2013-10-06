(c-define-type rgb-color unsigned-int32)
(c-define-type Uint8 unsigned-int8)
(c-define-type Sint8 int8)
(c-define-type Uint16 unsigned-int16)
(c-define-type Sint16 int16)
(c-define-type Uint32 unsigned-int32)
(c-define-type SDLKey int)
(c-define-type SDLMod int)
(c-define-type SDL_VideoInfo* (pointer "SDL_VideoInfo"))
(c-define-type SDL_PixelFormat* (pointer "SDL_PixelFormat"))
(%define/extern-object "SDL_Rect" "release-rc")
(%define/extern-object "SDL_Event" "release-rc")

(%extern-object-releaser-set! "SDL_FreeSurface" "SDL_FreeSurface(p);\n")
(%define/extern-object "SDL_Surface" "SDL_FreeSurface")
