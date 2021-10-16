# Empezando

Empezaremos con configuraciones basicas de vim, podemos ponerlas en un archivo por separado con la expresion .vim o vim dejarlo en el .vimrc

```vim
set number
set mouse=a
set numberwidth=1
syntax enable
set encoding=UTF-8
set sw=1
set relativenumber
set tabstop=2 
set shiftwidth=2 

set expandtab
```
Directamente a los mas importante, estas configuracion nos pondran por defecto el numero de linea en vim, el tamaño de los espacios tab y la activación del mouse dentro de vim.

Ahora vamos con lo interante como implementar plugins en nuestro vim, tenemos varios gestores de plugins pero yo por comodida utilizo vundle.

> Instalación de Vundle
```bash
  $ git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```
Luego de instalar vundle en nuestra maquina vamos a nuestro .vimrc o archivo plugins.vim y configuramos los siguiente

```vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

" ... Plugins a descargar

call vundle#end()
```

Todos nuestros plugins deben ir dentro 
```vim
call vundle#begin()
```
y la configuracion de los mismos plugins la podemos poner despues del 
```vim
call vundle#end()
```
