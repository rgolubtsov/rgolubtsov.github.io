# Linearization of the resume in PDF

**PDF linearization** is a process of its transformation to produce web optimized document. To linearize PDF variants of the resume, one may use the [QPDF](http://qpdf.sourceforge.net "QPDF: A Content-Preserving PDF Transformation System") utility:

```
$ qpdf --verbose --linearize radislav-golubtsov-resume-en_US.pdf-orig       \
                             radislav-golubtsov-resume-en_US.pdf;echo $? && \
  qpdf --verbose --linearize radislav-golubtsov-resume-ru_RU.pdf-orig       \
                             radislav-golubtsov-resume-ru_RU.pdf;echo $?
qpdf: wrote file radislav-golubtsov-resume-en_US.pdf
0
qpdf: wrote file radislav-golubtsov-resume-ru_RU.pdf
0
```

**Note:** PDF variants of the resume located here, are already linearized.
