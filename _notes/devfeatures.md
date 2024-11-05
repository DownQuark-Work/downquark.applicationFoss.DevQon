# Build Items
> note: these are all ephereal and conceptual for the time being.
> > they will be changed at any time without notice

## Creator Screen

### TOML Compiler
Unlike swagger's petshop yml DevQon will autosave multiple toml files.

Each project will have its own named directory allowing the user to select the project name and load all config files within it.
The naming convention will be semi-semantic to allow users to easily make edits as a one-off if desired:
- `<field|region|sector|zone>[CASCADING]<USER_DEFINED_NAME>.toml`

There will also be a file that maps the order they should be compiled in.
Something like below:
```
# ~/.downquark/devqon/project1
_map.toml
field
zone.first-zone.toml
zone.first-zone.sector.one-sector.toml
zone.first-zone.sector.one-sector.region.a.toml
zone.first-zone.sector.one-sector.region.a.field.clicky.toml
zone.first-zone.sector.one-sector.region.a.field.input.toml
zone.first-zone.sector.one-sector.region.a.field.text.toml
zone.first-zone.sector.one-sector.region.b.toml
zone.first-zone.sector.one-sector.region.b.field.something.toml
zone.first-zone.sector.one-sector.region.c.toml
zone.first-zone.sector.one-sector.region.c.field.something-else.toml
zone.first-zone.sector.two-sector.toml
zone.first-zone.sector.two-sector.region.a.toml
zone.first-zone.sector.two-sector.region.a.field.something.toml
zone.first-zone.sector.two-sector.region.aa.toml
zone.first-zone.sector.two-sector.region.aa.field.something-else.toml
zone.first-zone.sector.three-sector.toml
zone.first-zone.sector.three-sector.region.something-unexpected.toml
zone.first-zone.sector.three-sector.region.something-unexpected.field.something.toml
zone.first-zone.sector.three-sector.region.something-unexpected.field.something-new.toml
zone.not-first-zone.toml
zone.not-first-zone.sector.anotherone-sector.toml
zone.not-first-zone.sector.two-sector.toml # this convention allows for the same names in sepatate areas
...

###

# ~/.downquark/devqon/project2
_map.toml
... same naming conventions as above ...
```

_OR_ better yet, follow the rust directory structure.
- each toml has an associated dir so it would make something like the following:
```
~/.dq/development-qonsole
├── first-project
│   ├── _map.toml
│   └── _zone
│       ├── first-zone
│       │   └── _sector
│       │       ├── sector-one
│       │       │   └── _region
│       │       │       ├── a
│       │       │       │   ├── _field
│       │       │       │   ├── clicky.toml
│       │       │       │   ├── input.toml
│       │       │       │   └── text.toml
│       │       │       ├── a.toml
│       │       │       ├── b
│       │       │       │   ├── _field
│       │       │       │   └── clicky.toml
│       │       │       ├── b.toml
│       │       │       ├── c
│       │       │       │   ├── _field
│       │       │       │   ├── clicky.toml
│       │       │       │   └── input.toml
│       │       │       └── c.toml
│       │       ├── sector-one.toml
│       │       ├── two
│       │       │   └── _region
│       │       │       ├── a
│       │       │       │   ├── _field
│       │       │       │   └── input.toml
│       │       │       ├── a.toml
│       │       │       ├── aa
│       │       │       │   ├── _field
│       │       │       │   ├── clicky.toml
│       │       │       │   └── input.toml
│       │       │       └── aa.toml
│       │       └── two.toml
│       ├── first-zone.toml
│       ├── not-first-zone
│       │   └── _sector
│       │       ├── another
│       │       │   └── _region
│       │       │       ├── something-new
│       │       │       │   ├── _field
│       │       │       │   └── camera.toml
│       │       │       └── something-new.toml
│       │       └── another.toml
│       └── not-first-zone.toml
└── second-project
    ├── _map.toml
    ├── _zone
    └── ... same naming conventions as above ...
```
