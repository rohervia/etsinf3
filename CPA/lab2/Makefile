e1:
	gcc -Wall -fopenmp -o encaja-e1{,.c}

e2:
	gcc -Wall -fopenmp -o encaja-e2-pJ{,.c}
	gcc -Wall -fopenmp -o encaja-e2-pX{,.c}

e3:
	gcc -Wall -fopenmp -o encaja-e3{,.c}

e4:
	gcc -Wall -fopenmp -o encaja-e4-pJ{,.c}
	gcc -Wall -fopenmp -o encaja-e4-pX{,.c}

tex:
	pdflatex -synctex=1 -interaction=nonstopmode report.tex > /dev/null

clean:
	rm -f encaja-e?{-p?}
	rm -f report.{aux,log,out,synctex.gz}
	rm -f Lenna.ppm
