(include "header.scm")

(c-declare #<<eof
#include <pango/pango.h>
#include <SDL_Pango.h>
eof
)

(include "ffi.scm")
(c-define-type SDL_Surface* (pointer "SDL_Surface"))
(c-define-type PangoLayout* (pointer "PangoLayout"))
(%extern-object-releaser-set! "SDLPango_FreeContext"
                              "SDLPango_FreeContext(p);\n")
(%define/extern-object "SDLPango_Context" "SDLPango_FreeContext")
(%define/extern-object "SDLPango_Matrix" "release-rc")

(define pango-init
  (c-lambda () bool "SDLPango_Init"))

(define pango-was-init?
  (c-lambda () bool "___result = (SDLPango_WasInit() == 0);"))

(define pango-create-context
  (c-lambda ()
            SDLPango_Context*/SDLPango_FreeContext
            "SDLPango_CreateContext"))

(define pango-layout
  (c-lambda (SDLPango_Context*)
            PangoLayout*
            "SDLPango_GetPangoLayout"))

(define pango-layout-width
  (c-lambda (SDLPango_Context*)
            int
            "SDLPango_GetLayoutWidth"))

(define pango-layout-height
  (c-lambda (SDLPango_Context*)
            int
            "SDLPango_GetLayoutHeight"))

(define pango-set-minimum-size!
  (c-lambda (SDLPango_Context* int int)
            void
            "SDLPango_SetMinimumSize"))

(define pango-set-markup!
  (c-lambda (SDLPango_Context* char-string)
            void
            "SDLPango_SetMarkup(___arg1, ___arg2, -1);"))

(define pango-set-text!
  (c-lambda (SDLPango_Context* char-string)
            void
            "SDLPango_SetText(___arg1, ___arg2, -1);"))

(define pango-set-language!
  (c-lambda (SDLPango_Context* char-string)
            void
            "SDLPango_SetLanguage"))

(define pango-set-dpi!
  (c-lambda (SDLPango_Context* double double)
            void
            "SDLPango_SetDpi"))

(define pango-draw
  (c-lambda (SDLPango_Context* SDL_Surface* int int)
            void
            "SDLPango_Draw"))

(define +pango-black-back+
  ((c-lambda () SDLPango_Matrix* "___result_voidstar = MATRIX_BLACK_BACK;")))

(define +pango-white-back+
  ((c-lambda () SDLPango_Matrix* "___result_voidstar = MATRIX_WHITE_BACK;")))

(define +pango-transparent-back-black-letter+
  ((c-lambda () 
             SDLPango_Matrix* 
             "___result_voidstar = MATRIX_TRANSPARENT_BACK_BLACK_LETTER;")))

(define +pango-transparent-back-white-letter+
  ((c-lambda () 
             SDLPango_Matrix* 
             "___result_voidstar = MATRIX_TRANSPARENT_BACK_WHITE_LETTER;")))

(define +pango-transparent-back-transparent-letter+
  ((c-lambda
    ()
    SDLPango_Matrix*
    "___result_voidstar = MATRIX_TRANSPARENT_BACK_TRANSPARENT_LETTER;")))

(define pango-set-default-color!
  (c-lambda (SDLPango_Context* SDLPango_Matrix*)
            void
            "SDLPango_SetDefaultColor"))

(define pango-matrix<-rgb
  (let ((color (lambda (c)
                 (cond ((and (exact? c) (integer? c)) c)
                       (else (round (* 255 (inexact->exact c))))))))
    (lambda (r g b)
      ((c-lambda (unsigned-int8 unsigned-int8 unsigned-int8)
                 SDLPango_Matrix*/release-rc
                 "
                  SDLPango_Matrix colormat, *pcolormat;
                  int i, j;

                  memset(colormat.m, 0, sizeof(colormat.m));

                  colormat.m[0][0] = colormat.m[0][1] = ___arg1;
                  colormat.m[1][0] = colormat.m[1][1] = ___arg2;
                  colormat.m[2][0] = colormat.m[2][1] = ___arg3;
                  colormat.m[3][0] = 0;
                  colormat.m[3][1] = 255;

                  pcolormat = ___CAST(SDLPango_Matrix*,
                                      ___EXT(___alloc_rc)(sizeof(colormat)));
                  if (pcolormat)
                    *pcolormat = colormat;
                  ___result_voidstar = pcolormat;
                 "
                 )
       (color r)
       (color g)
       (color b)))))

