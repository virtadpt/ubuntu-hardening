This is a set of configuration files for Ubuntu Server (versions 12.04 and
14.04, both LTS) that I deploy on new VMs in production to harden them.
Recursively copy all of the files in a particular release's directory into
/etc to install them.

The v12.04 files are fairly well tested.

Consider the v14.04 files experimental.  We've stopped deploying Trusty VMs in
the field because reasons.

The configuration changes are taken from the following ebooks and other Git
repositories:

* https://benchmarks.cisecurity.org/community/editors/groups/single/?group=debian
* https://benchmarks.cisecurity.org/downloads/show-single/?file=apache.310
* https://benchmarks.cisecurity.org/downloads/show-single/?file=apache24.100
* https://github.com/ioerror/duraconf/

As always, these files are a work in progress.

