# Linearization of the resume in PDF

**PDF linearization** is a process of transformation of a PDF document to produce web optimized document. To linearize PDF variants of the resume, one may use the [QPDF](https://qpdf.sourceforge.io "QPDF: A Content-Preserving PDF Transformation System") utility:

```
$ qpdf --verbose --linearize --replace-input radislav-golubtsov-resume-en_US.pdf && \
  qpdf --verbose --linearize --replace-input radislav-golubtsov-resume-ru_RU.pdf
qpdf: wrote file radislav-golubtsov-resume-en_US.pdf.~qpdf-temp#
qpdf: wrote file radislav-golubtsov-resume-ru_RU.pdf.~qpdf-temp#
```

**Note:** PDF variants of the resume located here, are already linearized.
