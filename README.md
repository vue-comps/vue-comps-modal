# vue-comps-modal

the best modal you can get.

### [Demo](https://vue-comps.github.io/vue-comps-modal)

# Install

```sh
npm install --save-dev vue-comps-modal
```
or include `build/bundle.js`.

## Usage
```coffee
# in your component
components:
  "modal": require("vue-comps-modal")
# or, when using bundle.js
components:
  "modal": window.vueComps.modal
```
```html
<button> Open Modal
  <modal>
    Content
  </modal>
</button>
```

For examples see [`dev/`](https://github.com/vue-comps/vue-comps-modal/tree/master/dev).

Note, that the modal will be appended to `document.body` on first opening.

#### Props
| Name | type | default | description |
| ---:| --- | ---| --- |
| opacity | Number | 0.5 | opacity of the overlay |
| not-dissmissible | Boolean | false | can it get closed by click on overlay or ESC? |
| ignore-parent | Boolean | false | will not set-up click listener on parent |
| is-opened | Boolean | false | (two-way) set to open / close |
| transition-in | function | no animation | set animation with opacity = 1. Argument: {el,cb} |
| transition-out | function | no animation | set animation with opacity = 0. Argument: {el,cb} |
| parent | element | parentElement | where to listen for open click |
| class | String | modal | class of the `div`|


#### Events
| Name |  description |
| ---:| --- |
| close |  when received, will close |
| before-open | will be called before open animation |
| opened |  will be called when opened |
| before-close |  will be called before close animation |
| closed |  will be called when closed |


# Development
Clone repository.
```sh
npm install
npm run dev
```
Browse to `http://localhost:8080/`.

## License
Copyright (c) 2016 Paul Pflugradt
Licensed under the MIT license.
