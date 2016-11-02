e1:
	gcc -Wall -fopenmp -o src/encaja-e1{,.c}

e2:
	gcc -Wall -fopenmp -o src/encaja-e2-pJ{,.c}
	gcc -Wall -fopenmp -o src/encaja-e2-pX{,.c}

e3:
	gcc -Wall -fopenmp -o src/encaja-e3{,.c}

e4:
	gcc -Wall -fopenmp -o src/encaja-e4-pJ{,.c}
	gcc -Wall -fopenmp -o src/encaja-e4-pX{,.c}

tex:
	pdflatex -synctex=1 -interaction=nonstopmode pdf/report.tex > /dev/null

clean:
	rm -f src/encaja-e?{,-p?}
	rm -f pdf/report.{aux,log,out,synctex.gz}
	rm -f img/Lenna.ppm
