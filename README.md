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
Name | type | default | description
---:| --- | ---| ---
opacity | Number | 0.5 | opacity of the overlay
not-dismissable | Boolean | false | can it get closed by click on overlay or ESC?
ignore-parent | Boolean | false | will not set-up click listener on parent
is-opened | Boolean | false | (two-way) set to open / close
transition | String | "modal" | name of a vue transition. [Detailed description](#transition)
parent | Element | parentElement | where to listen for open click
z-index | Number | 1500 | minimum zIndex of the overlay, cannot be lower than 1000 (see [vue-overlay](https://github.com/vue-comps/vue-overlay) for specifics)


#### Events
Name |  description
---:| ---
before-enter | will be called before open animation
after-enter |  will be called when opened
before-leave |  will be called before close animation
after-leave |  will be called when closed
toggled(isOpened:Boolean) | emitted when gets opened or closed. Alternative to use two-way `is-opened` prop

#### Transition

You can provide a vue transition like this:
```js
Vue.transition("fade",{
  // your transition
})
// or in the instance:
transitions: {
  fade: {
    // your transition
  }
}
// usage:
template: "<modal transition='fade'></modal>"
```

The background is managed by `vue-overlay`.
See [here](https://github.com/vue-comps/vue-overlay#overlayfadeelopacitycb) for an example on how to change its fading function.

## Changelog
- 1.2.0  
added toggled event  
set default transition  

- 1.1.1  
removed usage of `$appendTo`  

- 1.1.0  
now using vue transitions  
events are renamed after vue transitions  

- 1.0.0  
added `z-index` prop  
remove `close` event listening  

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
