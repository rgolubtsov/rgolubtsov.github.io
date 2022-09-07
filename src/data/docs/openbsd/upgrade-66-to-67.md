# OpenBSD 6.6 to 6.7 Upgrade Gotchas

### OpenBSD/amd64 6.6 to 6.7 upgrade gotchas regarding mismatching Perl binaries and libraries

*27th of May, 2020*

Once having the OpenBSD/amd64 6.7 release installed and running (after upgrading from the 6.6 release), base system, there is a need to upgrade packages: `$ sudo pkg_add -uv`. But first let's trying checking the package database:

```
$ pkg_info
Fcntl.c: loadable library and perl binaries are mismatched (got handshake key 0xb700000, needed 0xb600000)
```

The command above doesn't work, and as it is clearly seeing in the output, something gets wrong with Perl binaries and libraries. &ndash; Obviously, the version of installed Perl binaries doesn't match the version of its loadable library.

This can be repaired by replacing the whole Perl base module set with that one freshly downloaded from the OpenBSD CDN. It is contained in the `base67.tgz` tarball. The following compound one-liner command will replace the old Perl base module set with the new one, with minimal effort from the user side:

```
$ mkdir        xyz                                                                                  && \
  cd           xyz/                                                                                 && \
  curl    -sO  https://cdn.openbsd.org/pub/OpenBSD/6.7/amd64/base67.tgz                             && \
  tar     -xzf base67.tgz                                                                           && \
  sudo rm -Rf  /usr/local/libdata/perl5/site_perl/amd64-openbsd/*                                   && \
  sudo cp -Rf ./usr/libdata/perl5/amd64-openbsd/* /usr/local/libdata/perl5/site_perl/amd64-openbsd/ && \
  cd -                                                                                              && \
  sudo rm -Rf  xyz/
```

Now package manipulation commands (`pkg_info`, `pkg_add`, `pkg_delete`, etc.) should be working fine:

* Check the package database:

```
$ pkg_info
adwaita-icon-theme-3.32.0 base icon theme for GNOME
aom-1.0.0.20190901  Alliance for Open Media AV1 video codec
at-spi2-atk-2.32.0  atk-bridge for at-spi2
...
xz-5.2.4            LZMA compression and decompression tools
zip-3.0p1           create/update ZIP files compatible with PKZip(tm)
zstd-1.4.3          zstandard fast real-time compression algorithm
```

* Upgrade packages:

```
$ sudo pkg_add -uv
Update candidates: quirks-3.182 -> quirks-3.325
quirks-3.325 signed on 2020-05-23T20:09:30Z
quirks-3.182->3.325: ok
Update candidates: adwaita-icon-theme-3.32.0 -> adwaita-icon-theme-3.34.3
Update candidates: librsvg-2.46.0 -> librsvg-2.48.4
Update candidates: pango-1.42.4p3 -> pango-1.44.7p0
...
Running tags: ok
Read shared items: ok
...
Couldn't find updates for rebar19-2.6.2p0
Extracted 2729914590 from 2729997463
```

Making **OpenBSD** work right for you ! &ndash; In any circumstances ! :+1:
