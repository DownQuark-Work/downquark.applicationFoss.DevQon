# Development Qonsole
> A dq build

## setup
### create new project: `% cargo tauri init`
- 👆 only 1x
### run dev server: `% cargo tauri dev`
- 👆 for development work

TODO: to close out the `basic-configuration` branch
- [x] typescript as opposed to javascript
- [x] scss
- [x] lit
- [x] add build step (parcel)
- [x] testing
  - [x] playwright?
- [x] implement the CLI??
- [ ] [directory structure](https://doc.rust-lang.org/book/ch07-02-defining-modules-to-control-scope-and-privacy.html)
  - [ ] ui
    - sector / zone / region / field
  - [ ] rust
    - executable (`lib`)
    - widget (`bin <module>`)
    - implementation (`bin <workspace>`)
      - see `./_notes/rust brush up/_docs/5.workspace`
  - [ ] hooks? (`lib`?)
    - should they be grouped by each level mentioned above?
- [ ] add splash page
- [ ] use the native system tray
- [ ] db connection

## features!
> https://tauri.app/v1/guides/features/
## api!
> https://tauri.app/v1/api/cli/
> https://tauri.app/v1/api/js/
### design patterns:
> https://rust-unofficial.github.io/patterns/patterns/index.html

## references:
[awesome tauri](https://github.com/tauri-apps/awesome-tauri)
[tauri-deno-starter](https://github.com/marc2332/tauri-deno-starter)

### keep alive
  - https://tauri.app/v1/guides/features/system-tray#preventing-the-app-from-closing

### invoke rust from the FE
  - https://tauri.app/v1/guides/features/command

### system tray
  - https://tauri.app/v1/guides/features/system-tray

### `pkg-config` issue and resolution
  - https://tauri.app/v1/guides/faq#build-conflict-with-homebrew-on-linux

### Creating additional HTML pages
  - https://tauri.app/v1/guides/features/multiwindow
> If you want to create additional pages beyond index.html, you will need to make sure they are present in the dist directory at build time. How you do this depends on your frontend setup.


The first implementation will be created simultaneously with the [Qanban Board](//github.com/DownQuark-Work/downquark.applicationFoss.QanbanBoard).

This will ensure that all customizable aspects required to make the Development Qonsole a success will be working correctly.

This may be helpful when it is time to implement the board:
- https://tauri.app/v1/guides/building/resources
And from this directory:
- `% cargo tree --manifest-path tauri/src-tauri/Cargo.toml`

<details><summary><u><i>rough</i></u>dashboard editor concept</summary>
<img width="1048" alt="Screenshot 2023-12-22 at 02 14 51" src="https://github.com/DownQuark-Work/downquark.applicationFoss.DevQon/assets/40064794/645c2d8e-2553-45bd-a7ac-30c7bb9e7fa8">
</details>

https://wireframe.cc/eEzsrw
