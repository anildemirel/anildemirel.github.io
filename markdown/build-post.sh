pandoc ./markdown/posts/$1.md -o ./$1.html -c ./assets/format.css --mathjax --standalone
