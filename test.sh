#!/usr/bin/env bash

docker build -f test/Dockerfile -t fugitive_cgit .

docker run --rm -v `pwd`:/test/fugitive-cgit.vim -w '/test' fugitive_cgit vim -Es -Nu vimrc -c 'Vader! fugitive-cgit.vim/test/*' > /dev/null
docker run --rm -v `pwd`:/test/fugitive-cgit.vim -w '/test' fugitive_cgit nvim -Es -Nu vimrc -c 'Vader! fugitive-cgit.vim/test/*' > /dev/null
