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

**Read** metadata:

```
$ exiftool -all:all *.pdf
======== radislav-golubtsov-resume-en_US.pdf
ExifTool Version Number         : 11.88
File Name                       : radislav-golubtsov-resume-en_US.pdf
...
MIME Type                       : application/pdf
PDF Version                     : 1.6
Linearized                      : No
Page Count                      : 20
Language                        : en-US
Creator                         : Writer
Producer                        : LibreOffice 7.3
======== radislav-golubtsov-resume-ru_RU.pdf
ExifTool Version Number         : 11.88
File Name                       : radislav-golubtsov-resume-ru_RU.pdf
...
MIME Type                       : application/pdf
PDF Version                     : 1.6
Linearized                      : No
Page Count                      : 22
Language                        : en-US
Creator                         : Writer
Producer                        : LibreOffice 7.3
    2 image files read
```

**Clear** metadata:

```
$ exiftool -all:all= *.pdf
Warning: [minor] ExifTool PDF edits are reversible. Deleted tags may be recovered! - radislav-golubtsov-resume-en_US.pdf
Warning: [minor] ExifTool PDF edits are reversible. Deleted tags may be recovered! - radislav-golubtsov-resume-ru_RU.pdf
    2 image files updated
```

**Read** metadata again:

```
$ rm -f *.pdf_original && exiftool -all:all *.pdf
======== radislav-golubtsov-resume-en_US.pdf
ExifTool Version Number         : 11.88
File Name                       : radislav-golubtsov-resume-en_US.pdf
...
MIME Type                       : application/pdf
PDF Version                     : 1.6
Linearized                      : No
Page Count                      : 20
Language                        : en-US
======== radislav-golubtsov-resume-ru_RU.pdf
ExifTool Version Number         : 11.88
File Name                       : radislav-golubtsov-resume-ru_RU.pdf
...
MIME Type                       : application/pdf
PDF Version                     : 1.6
Linearized                      : No
Page Count                      : 22
Language                        : en-US
    2 image files read
```

**Set** titles for the docs:

```
$ exiftool -Title="Radislav Golubtsov Resume | en_US" radislav-golubtsov-resume-en_US.pdf && \
  exiftool -Title="Radislav Golubtsov Resume | ru_RU" radislav-golubtsov-resume-ru_RU.pdf
    1 image files updated
    1 image files updated
```

**Read** metadata again:

```
$ rm -f *.pdf_original && exiftool -all:all *.pdf
======== radislav-golubtsov-resume-en_US.pdf
ExifTool Version Number         : 11.88
File Name                       : radislav-golubtsov-resume-en_US.pdf
...
MIME Type                       : application/pdf
PDF Version                     : 1.6
Linearized                      : No
Page Count                      : 20
Language                        : en-US
XMP Toolkit                     : Image::ExifTool 11.88
Title                           : Radislav Golubtsov Resume | en_US
======== radislav-golubtsov-resume-ru_RU.pdf
ExifTool Version Number         : 11.88
File Name                       : radislav-golubtsov-resume-ru_RU.pdf
...
MIME Type                       : application/pdf
PDF Version                     : 1.6
Linearized                      : No
Page Count                      : 22
Language                        : en-US
XMP Toolkit                     : Image::ExifTool 11.88
Title                           : Radislav Golubtsov Resume | ru_RU
    2 image files read
```

**Linearize** the docs (see dedicated section above) and **read** metadata again:

```
$ exiftool -all:all *.pdf
======== radislav-golubtsov-resume-en_US.pdf
ExifTool Version Number         : 11.88
File Name                       : radislav-golubtsov-resume-en_US.pdf
...
MIME Type                       : application/pdf
PDF Version                     : 1.6
Linearized                      : Yes                 <== That's one!
Language                        : en-US
XMP Toolkit                     : Image::ExifTool 11.88
Title                           : Radislav Golubtsov Resume | en_US
Page Count                      : 20
======== radislav-golubtsov-resume-ru_RU.pdf
ExifTool Version Number         : 11.88
File Name                       : radislav-golubtsov-resume-ru_RU.pdf
...
MIME Type                       : application/pdf
PDF Version                     : 1.6
Linearized                      : Yes                 <== That's two!
Language                        : en-US
XMP Toolkit                     : Image::ExifTool 11.88
Title                           : Radislav Golubtsov Resume | ru_RU
Page Count                      : 22
    2 image files read
```

That's all... &mdash; Have fun!
