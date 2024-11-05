https://nodejs.org/api/single-executable-applications.html
- https://nodejs.org/api/single-executable-applications.html#single-executable-applications

1. echo '{ "main": "sideqar.js", "output": "sea-prep.blob" }' > sea-config.json
1. node --experimental-sea-config sea-config.json
1. cp $(command -v node) sideqar
1. codesign --remove-signature sideqar
1. chmod 755 sideqar
1. npx postject sideqar NODE_SEA_BLOB sea-prep.blob --sentinel-fuse NODE_SEA_FUSE_fce680ab2cc467b6e072b8b5df1996b2 --macho-segment-name NODE_SEA
1. chmod 555 sideqar
1. codesign --sign - sideqar

-=-=-=-=-=-=-=-

shorthand:
```bash
echo '{ "main": "sideqar.js", "output": "sea-prep.blob" }' > sea-config.json \
&& node --experimental-sea-config sea-config.json \
&& cp $(command -v node) sideqar \
&& codesign --remove-signature sideqar \
&& chmod 755 sideqar;

 npx postject sideqar NODE_SEA_BLOB sea-prep.blob --sentinel-fuse NODE_SEA_FUSE_fce680ab2cc467b6e072b8b5df1996b2 --macho-segment-name NODE_SEA;

chmod 555 sideqar && codesign --sign - sideqar
```

-=-=-=-=-

run:
`./sideqar regex 'how now brown cow' '.ow' 'gi'`
