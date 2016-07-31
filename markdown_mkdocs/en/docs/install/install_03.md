# Extracting the Archive File

The archive file has been archiving with the tar command and compressing
with gzip. It can be extracted using the following command. (“\$” at the
beginning of the command string represents a prompt.)

\$ tar xzf FrontISTR\_V42.tar.gz

If the tar command in the environment where this software is to be
installed does not support the z option, the archive file can be
extracted using the following command:

\$ gzip –dc FrontISTR-V42.tar.gz | tar xf –

If the archive file is extracted, a directory named “FrontISTR” will be
created in the directory where the archive file has been extracted.
(This directory is hereafter referred to as “\${FSTRBUILDDIR}”.)
