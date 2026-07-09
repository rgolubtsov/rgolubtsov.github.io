# Linearization of the resume in PDF

**PDF linearization** is a process of transformation of a PDF document to produce web optimized document. To linearize PDF variants of the resume, one may use the [QPDF](https://qpdf.sourceforge.io "QPDF: A Content-Preserving PDF Transformation System") utility:

```
$ qpdf --verbose --linearize --replace-input radislav-golubtsov-resume-en_US.pdf && \
  qpdf --verbose --linearize --replace-input radislav-golubtsov-resume-ru_RU.pdf
qpdf: wrote file radislav-golubtsov-resume-en_US.pdf.~qpdf-temp#
qpdf: wrote file radislav-golubtsov-resume-ru_RU.pdf.~qpdf-temp#
```

**Note:** PDF variants of the resume located here, are already linearized.

## Clear/set metadata of the resume in PDF

To read/clear/set metadata in a PDF document, one may use the [ExifTool](https://exiftool.org "ExifTool: A Perl library and a command-line utility for reading, writing and editing meta information") utility.

1. **Read** metadata:

```
$ exiftool -all:all *.pdf
======== radislav-golubtsov-resume-en_US.pdf
ExifTool Version Number         : 13.55
File Name                       : radislav-golubtsov-resume-en_US.pdf
...
MIME Type                       : application/pdf
PDF Version                     : 1.4
Linearized                      : No
Page Count                      : 4
Title                           : Radislav Golubtsov | Curriculum Vitae
Creator                         : Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/147.0.0.0 Safari/537.36
Producer                        : Skia/PDF m147
...
======== radislav-golubtsov-resume-ru_RU.pdf
ExifTool Version Number         : 13.55
File Name                       : radislav-golubtsov-resume-ru_RU.pdf
...
MIME Type                       : application/pdf
PDF Version                     : 1.4
Linearized                      : No
Page Count                      : 4
Title                           : Радислав Голубцов | Curriculum Vitae
Creator                         : Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/147.0.0.0 Safari/537.36
Producer                        : Skia/PDF m147
...
    2 image files read
```

2. **Clear** metadata:

```
$ exiftool -all:all= *.pdf
Warning: [minor] ExifTool PDF edits are reversible. Deleted tags may be recovered! - radislav-golubtsov-resume-en_US.pdf
Warning: [minor] ExifTool PDF edits are reversible. Deleted tags may be recovered! - radislav-golubtsov-resume-ru_RU.pdf
    2 image files updated
```

3. **Read** metadata again:

```
$ rm -f *.pdf_original && exiftool -all:all *.pdf
======== radislav-golubtsov-resume-en_US.pdf
ExifTool Version Number         : 13.55
File Name                       : radislav-golubtsov-resume-en_US.pdf
...
MIME Type                       : application/pdf
PDF Version                     : 1.4
Linearized                      : No
Page Count                      : 4
======== radislav-golubtsov-resume-ru_RU.pdf
ExifTool Version Number         : 13.55
File Name                       : radislav-golubtsov-resume-ru_RU.pdf
...
MIME Type                       : application/pdf
PDF Version                     : 1.4
Linearized                      : No
Page Count                      : 4
    2 image files read
```

4. **Set** titles for the docs:

```
$ exiftool -Title="Radislav Golubtsov | Curriculum Vitae" radislav-golubtsov-resume-en_US.pdf && \
  exiftool -Title="Радислав Голубцов | Curriculum Vitae"  radislav-golubtsov-resume-ru_RU.pdf
    1 image files updated
    1 image files updated
```

5. **Read** metadata again:

```
$ rm -f *.pdf_original && exiftool -all:all *.pdf
======== radislav-golubtsov-resume-en_US.pdf
ExifTool Version Number         : 13.55
File Name                       : radislav-golubtsov-resume-en_US.pdf
...
MIME Type                       : application/pdf
PDF Version                     : 1.4
Linearized                      : No
Page Count                      : 4
XMP Toolkit                     : Image::ExifTool 13.55
Title                           : Radislav Golubtsov | Curriculum Vitae
Title                           : Radislav Golubtsov | Curriculum Vitae
======== radislav-golubtsov-resume-ru_RU.pdf
ExifTool Version Number         : 13.55
File Name                       : radislav-golubtsov-resume-ru_RU.pdf
...
MIME Type                       : application/pdf
PDF Version                     : 1.4
Linearized                      : No
Page Count                      : 4
XMP Toolkit                     : Image::ExifTool 13.55
Title                           : Радислав Голубцов | Curriculum Vitae
Title                           : Радислав Голубцов | Curriculum Vitae
    2 image files read
```

6. **Linearize** the docs (*see dedicated section at the top of the page*) and **read** metadata again:

```
$ exiftool -all:all *.pdf
======== radislav-golubtsov-resume-en_US.pdf
ExifTool Version Number         : 13.55
File Name                       : radislav-golubtsov-resume-en_US.pdf
...
MIME Type                       : application/pdf
PDF Version                     : 1.4
Linearized                      : Yes                 <== That's one!
Title                           : Radislav Golubtsov | Curriculum Vitae
XMP Toolkit                     : Image::ExifTool 13.55
Title                           : Radislav Golubtsov | Curriculum Vitae
Page Count                      : 4
======== radislav-golubtsov-resume-ru_RU.pdf
ExifTool Version Number         : 13.55
File Name                       : radislav-golubtsov-resume-ru_RU.pdf
...
MIME Type                       : application/pdf
PDF Version                     : 1.4
Linearized                      : Yes                 <== That's two!
Title                           : Радислав Голубцов | Curriculum Vitae
XMP Toolkit                     : Image::ExifTool 13.55
Title                           : Радислав Голубцов | Curriculum Vitae
Page Count                      : 4
    2 image files read
```

Play with PDFs that way! &mdash; Have fun! :smiley:
