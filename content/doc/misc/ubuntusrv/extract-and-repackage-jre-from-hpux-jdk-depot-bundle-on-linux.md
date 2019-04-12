# Instructions to extract and repackage JRE, stored in an HP-UX JDK `.depot` bundle (on Linux)

## (1) Download the HP-UX 11i Java Development Kit (JDK) `.depot` bundle (package)

It is freely downloadable from the Software Depot homepage of the Hewlett Packard Enterprise (HPE) website. Actually the bundle can be downloaded from the HP-UX 11i Java Technology Software section of that homepage. They are provided each for various Java versions. Pick it up let's for 8.0.x &ndash; from the JDK/JRE 8.0.x Downloads and Documentation page. (**Note:** It needs to have an HPE Passport (account): sign in or sign up for a new one.) The link is named as "**Version 8.0.14 &ndash; June 2018 (includes Oracle update 8u172)**".

Transfer this bundle to a Linux box:

```
$ scp -C Itanium_JDK_8.0.14_June_2018_Z7550-63485_java8_18014_ia.depot <username>@<hostname>:/home/<username>
Itanium_JDK_8.0.14_June_2018_Z7550-63485_java8_18014_ia.depot                   100%  141MB  11.2MB/s   00:12
```

## (2) Unpack the `.depot` bundle

Since in fact it is just an ordinary tar archive, it can be unpacked using the `tar` archiver:

```
$ tar -xvf Itanium_JDK_8.0.14_June_2018_Z7550-63485_java8_18014_ia.depot
Jdk80/
Jdk80/JDK80-COM/
Jdk80/JDK80-COM/opt/
Jdk80/JDK80-COM/opt/java8/
Jdk80/JDK80-COM/opt/java8/COPYRIGHT
Jdk80/JDK80-COM/opt/java8/LICENSE
Jdk80/JDK80-COM/opt/java8/README.html
Jdk80/JDK80-COM/opt/java8/THIRDPARTYLICENSEREADME.txt
Jdk80/JDK80-COM/opt/java8/bin/
Jdk80/JDK80-COM/opt/java8/bin/HPUXChildWrapper
Jdk80/JDK80-COM/opt/java8/bin/appletviewer
Jdk80/JDK80-COM/opt/java8/bin/extcheck
Jdk80/JDK80-COM/opt/java8/bin/idlj
Jdk80/JDK80-COM/opt/java8/bin/jar
Jdk80/JDK80-COM/opt/java8/bin/jarsigner
Jdk80/JDK80-COM/opt/java8/bin/java
Jdk80/JDK80-COM/opt/java8/bin/javac
...
```

## (3) Adjust file permissions on unpacked data

After unpacking almost all files and directories will have the writable permission bit switched off for owner, group, and other users. It should be restored at least for owner to avoid problems during files' manipulations (see the next section). The following one-liner Bash script will do restore the permissions. The first script is for directories, the second one is for files:

```
$ for d in `find . -type d`; do sudo chmod -v u+w ${d}; done
mode of '.' retained as 0755 (rwxr-xr-x)
mode of './Jre80' retained as 0755 (rwxr-xr-x)
mode of './Jre80/JRE80' retained as 0755 (rwxr-xr-x)
mode of './Jre80/JRE80-IPF32-HS' retained as 0755 (rwxr-xr-x)
mode of './Jre80/JRE80-IPF32-HS/opt' retained as 0755 (rwxr-xr-x)
mode of './Jre80/JRE80-IPF32-HS/opt/java8' retained as 0755 (rwxr-xr-x)
mode of './Jre80/JRE80-IPF32-HS/opt/java8/jre' changed from 0555 (r-xr-xr-x) to 0755 (rwxr-xr-x)
mode of './Jre80/JRE80-IPF32-HS/opt/java8/jre/lib' changed from 0555 (r-xr-xr-x) to 0755 (rwxr-xr-x)
mode of './Jre80/JRE80-IPF32-HS/opt/java8/jre/lib/IA64N' changed from 0555 (r-xr-xr-x) to 0755 (rwxr-xr-x)
mode of './Jre80/JRE80-IPF32-HS/opt/java8/jre/lib/IA64N/server' changed from 0555 (r-xr-xr-x) to 0755 (rwxr-xr-x)
mode of './Jre80/JRE80-IPF32' retained as 0755 (rwxr-xr-x)
mode of './Jre80/JRE80-IPF32/opt' retained as 0755 (rwxr-xr-x)
mode of './Jre80/JRE80-IPF32/opt/java8' retained as 0755 (rwxr-xr-x)
mode of './Jre80/JRE80-IPF32/opt/java8/jre' changed from 0555 (r-xr-xr-x) to 0755 (rwxr-xr-x)
mode of './Jre80/JRE80-IPF32/opt/java8/jre/bin' changed from 0555 (r-xr-xr-x) to 0755 (rwxr-xr-x)
mode of './Jre80/JRE80-IPF32/opt/java8/jre/bin/IA64N' changed from 0555 (r-xr-xr-x) to 0755 (rwxr-xr-x)
mode of './Jre80/JRE80-IPF32/opt/java8/jre/lib' changed from 0555 (r-xr-xr-x) to 0755 (rwxr-xr-x)
...
```

```
$ for f in `find . -type f`; do sudo chmod -v u+w ${f}; done
mode of './Itanium_JDK_8.0.14_June_2018_Z7550-63485_java8_18014_ia.depot' retained as 0644 (rw-r--r--)
mode of './swagent.log' retained as 0644 (rw-r--r--)
mode of './Jre80/JRE80-IPF32-HS/opt/java8/jre/lib/IA64N/libjsig.so' changed from 0555 (r-xr-xr-x) to 0755 (rwxr-xr-x)
mode of './Jre80/JRE80-IPF32-HS/opt/java8/jre/lib/IA64N/server/Xusage.txt' changed from 0444 (r--r--r--) to 0644 (rw-r--r--)
mode of './Jre80/JRE80-IPF32-HS/opt/java8/jre/lib/IA64N/server/libjunwind64.so' changed from 0555 (r-xr-xr-x) to 0755 (rwxr-xr-x)
mode of './Jre80/JRE80-IPF32-HS/opt/java8/jre/lib/IA64N/server/libjvm.so' changed from 0555 (r-xr-xr-x) to 0755 (rwxr-xr-x)
mode of './Jre80/JRE80-IPF32/opt/java8/jre/bin/IA64N/keytool' changed from 0555 (r-xr-xr-x) to 0755 (rwxr-xr-x)
mode of './Jre80/JRE80-IPF32/opt/java8/jre/bin/IA64N/rmiregistry' changed from 0555 (r-xr-xr-x) to 0755 (rwxr-xr-x)
mode of './Jre80/JRE80-IPF32/opt/java8/jre/bin/IA64N/jjs' changed from 0555 (r-xr-xr-x) to 0755 (rwxr-xr-x)
mode of './Jre80/JRE80-IPF32/opt/java8/jre/bin/IA64N/tnameserv' changed from 0555 (r-xr-xr-x) to 0755 (rwxr-xr-x)
mode of './Jre80/JRE80-IPF32/opt/java8/jre/bin/IA64N/orbd' changed from 0555 (r-xr-xr-x) to 0755 (rwxr-xr-x)
mode of './Jre80/JRE80-IPF32/opt/java8/jre/bin/IA64N/servertool' changed from 0555 (r-xr-xr-x) to 0755 (rwxr-xr-x)
mode of './Jre80/JRE80-IPF32/opt/java8/jre/bin/IA64N/policytool' changed from 0555 (r-xr-xr-x) to 0755 (rwxr-xr-x)
mode of './Jre80/JRE80-IPF32/opt/java8/jre/bin/IA64N/unpack200' changed from 0555 (r-xr-xr-x) to 0755 (rwxr-xr-x)
mode of './Jre80/JRE80-IPF32/opt/java8/jre/bin/IA64N/rmid' changed from 0555 (r-xr-xr-x) to 0755 (rwxr-xr-x)
mode of './Jre80/JRE80-IPF32/opt/java8/jre/bin/IA64N/java_q4p' changed from 0555 (r-xr-xr-x) to 0755 (rwxr-xr-x)
mode of './Jre80/JRE80-IPF32/opt/java8/jre/bin/IA64N/java' changed from 0555 (r-xr-xr-x) to 0755 (rwxr-xr-x)
...
```

Now it is safe to remove unneeded directories and files (JDK, post-installation scripts, etc.). It needs to keep the `Jre80/` directory only:

```
$ rm -vRf catalog/ Jdk80/ swagent.log
removed 'catalog/Jre80/JRE80/INFO'
removed 'catalog/Jre80/JRE80/SIGNATURE'
removed 'catalog/Jre80/JRE80/INDEX'
removed directory 'catalog/Jre80/JRE80'
removed 'catalog/Jre80/JRE80-IPF32-HS/INFO'
removed 'catalog/Jre80/JRE80-IPF32-HS/SIGNATURE'
removed 'catalog/Jre80/JRE80-IPF32-HS/postinstall'
removed 'catalog/Jre80/JRE80-IPF32-HS/INDEX'
removed directory 'catalog/Jre80/JRE80-IPF32-HS'
removed 'catalog/Jre80/JRE80-IPF32/INFO'
removed 'catalog/Jre80/JRE80-IPF32/SIGNATURE'
removed 'catalog/Jre80/JRE80-IPF32/postinstall'
removed 'catalog/Jre80/JRE80-IPF32/INDEX'
removed 'catalog/Jre80/JRE80-IPF32/preinstall'
removed directory 'catalog/Jre80/JRE80-IPF32'
removed 'catalog/Jre80/JRE80-IPF64/INFO'
removed 'catalog/Jre80/JRE80-IPF64/SIGNATURE'
...
```

## (4) Copy all separately located JRE directory branches into a consolidated one

These directory structures will be expanded and underlying files will not be overwritten. So it is safe to do the following manipulations:

```
$ cp -vRf Jre80/JRE80-COM/opt/java8/jre/*      Jre80/JRE80/ && \
  cp -vRf Jre80/JRE80-COM-DOC/opt/java8/jre/*  Jre80/JRE80/ && \
  cp -vRf Jre80/JRE80-IPF32/opt/java8/jre/*    Jre80/JRE80/ && \
  cp -vRf Jre80/JRE80-IPF32-HS/opt/java8/jre/* Jre80/JRE80/ && \
  cp -vRf Jre80/JRE80-IPF64/opt/java8/jre/*    Jre80/JRE80/ && \
  cp -vRf Jre80/JRE80-IPF64-HS/opt/java8/jre/* Jre80/JRE80/
```

Move the consolidated resulting JRE directory structure to the current directory and remove already unneeded stuff:

```
$ mv -v   Jre80/JRE80/* . && \
  rm -vRf Jre80/ *.depot
```

## (5) Invoke the `gunzip` magic against all the JRE files

In fact all the resulting JRE files are stored compressed as `gzip`ped:

```
$ file * bin/java
bin:                         directory
COPYRIGHT:                   gzip compressed data, from Unix
lib:                         directory
LICENSE:                     gzip compressed data, from Unix
man:                         directory
README:                      gzip compressed data, from Unix
THIRDPARTYLICENSEREADME.txt: gzip compressed data, from Unix
bin/java:                    gzip compressed data, from Unix
```

It needs to `gunzip` each of them, but first give each file the `.gz` extension. The following one-liner Bash script does exactly this *magic* thing:

```
$ for f in `find . -type f`; do mv -v ${f} ${f}.gz; gunzip ${f}.gz; done
```

Check them out again and ensure the JRE files are now ready for including them to form out a new package (archive):

```
$ file * bin/java
bin:                         directory
COPYRIGHT:                   ISO-8859 text, with very long lines
lib:                         directory
LICENSE:                     Non-ISO extended-ASCII text, with very long lines
man:                         directory
README:                      ASCII text
THIRDPARTYLICENSEREADME.txt: UTF-8 Unicode text
bin/java:                    ELF 32-bit MSB executable, IA-64, version 1, dynamically linked, interpreter /usr/lib/hpux32/uld.so:/usr/lib/hpux32/dld.so, not stripped
```

## (6) Create a new package (zip-archive) containing Java Runtime Environment for HP-UX ready to run standalone

```
$ zip -r9 ../hpux_ia.zip *
  adding: bin/ (stored 0%)
  adding: bin/keytool (deflated 65%)
  adding: bin/rmiregistry (deflated 65%)
  adding: bin/jjs (deflated 65%)
  adding: bin/IA64W/ (stored 0%)
  adding: bin/IA64W/keytool (deflated 95%)
  adding: bin/IA64W/rmiregistry (deflated 95%)
  adding: bin/IA64W/jjs (deflated 95%)
  adding: bin/IA64W/tnameserv (deflated 95%)
  adding: bin/IA64W/orbd (deflated 95%)
  adding: bin/IA64W/servertool (deflated 95%)
  adding: bin/IA64W/policytool (deflated 95%)
  adding: bin/IA64W/unpack200 (deflated 61%)
  adding: bin/IA64W/rmid (deflated 95%)
  adding: bin/IA64W/java_q4p (deflated 95%)
  adding: bin/IA64W/java (deflated 95%)
  adding: bin/IA64W/pack200 (deflated 95%)
...
```

```
$ file ../hpux_ia.zip
../hpux_ia.zip: Zip archive data, at least v1.0 to extract
```

---

Happy Javing in HP-UX ! :+1:
