au BufNewFile,BufRead *.vue setf vue
autocmd BufNewFile,BufRead *.d setf d
autocmd BufNewFile,BufRead *.lst set filetype=dcov
autocmd BufNewFile,BufRead *.sdl set filetype=dsdl
au! BufRead,BufNewFile *.cl set filetype=opencl
" Language: OpenGL Shading Language
" Maintainer: Sergey Tikhomirov <sergey@tikhomirov.io>

autocmd! BufNewFile,BufRead *.glsl,*.geom,*.vert,*.frag,*.gsh,*.vsh,*.fsh,*.vs,*.fs,*.gs,*.tcs,*.tes,*.tesc,*.tese,*.comp set filetype=glsl

" vim:set sts=2 sw=2 :
