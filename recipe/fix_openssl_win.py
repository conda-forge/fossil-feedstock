# Perform the renaming of these things
import sys

with open(sys.argv[1], 'rb') as fo:
    content = fo.read()
    content = content.replace(b'ssleay32', b'libssl')
    content = content.replace(b'libeay32', b'libcrypto')

with open(sys.argv[1], 'wb') as fo:
    fo.write(content)
