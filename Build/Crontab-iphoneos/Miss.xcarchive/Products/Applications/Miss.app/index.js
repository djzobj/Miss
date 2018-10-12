// { "framework": "Vue" }
/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};

/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {

/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId])
/******/ 			return installedModules[moduleId].exports;

/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			exports: {},
/******/ 			id: moduleId,
/******/ 			loaded: false
/******/ 		};

/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);

/******/ 		// Flag the module as loaded
/******/ 		module.loaded = true;

/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}


/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;

/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;

/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "";

/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(0);
/******/ })
/************************************************************************/
/******/ ([
/* 0 */
/***/ (function(module, exports, __webpack_require__) {

	var __vue_exports__, __vue_options__
	var __vue_styles__ = []

	/* styles */
	__vue_styles__.push(__webpack_require__(1)
	)

	/* script */
	__vue_exports__ = __webpack_require__(2)

	/* template */
	var __vue_template__ = __webpack_require__(3)
	__vue_options__ = __vue_exports__ = __vue_exports__ || {}
	if (
	  typeof __vue_exports__.default === "object" ||
	  typeof __vue_exports__.default === "function"
	) {
	if (Object.keys(__vue_exports__).some(function (key) { return key !== "default" && key !== "__esModule" })) {console.error("named exports are not supported in *.vue files.")}
	__vue_options__ = __vue_exports__ = __vue_exports__.default
	}
	if (typeof __vue_options__ === "function") {
	  __vue_options__ = __vue_options__.options
	}
	__vue_options__.__file = "/Users/jianbing/Desktop/awesome-project/src/index.vue"
	__vue_options__.render = __vue_template__.render
	__vue_options__.staticRenderFns = __vue_template__.staticRenderFns
	__vue_options__._scopeId = "data-v-8e7c8b2e"
	__vue_options__.style = __vue_options__.style || {}
	__vue_styles__.forEach(function (module) {
	  for (var name in module) {
	    __vue_options__.style[name] = module[name]
	  }
	})
	if (typeof __register_static_styles__ === "function") {
	  __register_static_styles__(__vue_options__._scopeId, __vue_styles__)
	}

	module.exports = __vue_exports__
	module.exports.el = 'true'
	new Vue(module.exports)


/***/ }),
/* 1 */
/***/ (function(module, exports) {

	module.exports = {
	  "broadcast-arrow": {
	    "marginRight": 15
	  },
	  "broadcast-list-box": {
	    "backgroundColor": "#FF0000",
	    "height": 30
	  },
	  "broadcast-icon": {
	    "height": 20,
	    "width": 20
	  },
	  "broadcast": {
	    "height": 30,
	    "flexDirection": "row",
	    "alignItems": "center",
	    "marginLeft": 15,
	    "marginRight": 15,
	    "backgroundColor": "#f8f8f8",
	    "borderRadius": 15
	  },
	  "navigationBar": {
	    "height": 44,
	    "flexDirection": "row",
	    "alignItems": "center",
	    "marginLeft": 15
	  },
	  "navigationBar-title": {
	    "fontSize": 24,
	    "backgroundColor": "#FFFFFF"
	  },
	  "navigationBar-icon": {
	    "width": 32,
	    "height": 32
	  },
	  "tool-box": {
	    "flexDirection": "row"
	  },
	  "tool": {
	    "flexDirection": "column",
	    "alignItems": "center",
	    "marginTop": 20,
	    "marginBottom": 20,
	    "flex": 1
	  },
	  "tool-icon": {
	    "width": 63,
	    "height": 63
	  },
	  "tool-title": {
	    "fontSize": 12,
	    "color": "#333333",
	    "textAlign": "center"
	  }
	}

/***/ }),
/* 2 */
/***/ (function(module, exports) {

	"use strict";

	//
	//
	//
	//
	//
	//
	//
	//
	//
	//
	//
	//
	//
	//
	//
	//
	//
	//
	//
	//
	//
	//
	//
	//
	//
	//
	//
	//
	//
	//
	//
	//
	//
	//
	//
	//
	//
	//
	//
	//
	//
	//
	//
	//
	//
	//
	//
	//
	//
	//
	//
	//
	//
	//
	//
	//
	//
	//
	//
	//
	//
	//
	//
	//
	//
	//
	//
	//
	//
	//
	//
	//
	//
	//
	//
	//
	//
	//
	//
	//
	//
	//
	//
	//
	//
	//
	//
	//
	//
	//
	//
	//
	//
	//
	//


	module.exports = {
	  data: {
	    tools: [{ "title": "充值", "icon": "./images/icon_cz.png" }, { "title": "邀请", "icon": "./images/icon_invite.png" }, { "title": "礼劵", "icon": "./images/icon_lijuan.png" }],
	    broadcastLists: ["习大大要来视察。。。", "习大大要来视察。。。", "习大大要来视察。。。", "习大大要来视察。。。"]
	  },
	  created: function created() {
	    var url = SEARCH_URL + '&page=' + this.page;

	    this.renderData(url);

	    this.page++;
	  },
	  methods: {}
	};

/***/ }),
/* 3 */
/***/ (function(module, exports) {

	module.exports={render:function (){var _vm=this;var _h=_vm.$createElement;var _c=_vm._self._c||_h;
	  return _c('div', {}, [_vm._m(0), _c('div', {
	    staticClass: ["tool-box"]
	  }, _vm._l((_vm.tools), function(item) {
	    return _c('div', {
	      staticClass: ["tool"]
	    }, [_c('div', [_c('image', {
	      staticClass: ["tool-icon"],
	      attrs: {
	        "src": item.icon
	      }
	    }), _c('div', {
	      staticStyle: {
	        marginTop: "20px"
	      }
	    }, [_c('text', {
	      staticClass: ["tool-title"]
	    }, [_vm._v(_vm._s(item.title))])])]), _vm._v(">\n   ")])
	  })), _c('div', {
	    staticClass: ["broadcast"]
	  }, [_vm._m(1), _c('div', {
	    staticClass: ["broadcast-list-box"]
	  }, [_c('slider', {
	    staticClass: ["slider"],
	    attrs: {
	      "interval": "3000",
	      "autoPlay": "true"
	    }
	  }, _vm._l((_vm.broadcastLists), function(text) {
	    return _c('div', {
	      staticClass: ["frame"]
	    }, [_vm._v("\n          text>" + _vm._s(text))])
	  }))]), _vm._m(2)])])
	},staticRenderFns: [function (){var _vm=this;var _h=_vm.$createElement;var _c=_vm._self._c||_h;
	  return _c('div', {
	    staticClass: ["navigationBar"]
	  }, [_c('div', {
	    staticStyle: {
	      flex: "1"
	    }
	  }, [_c('text', {
	    staticClass: ["navigationBar-title"]
	  }, [_vm._v("51用钱")])]), _c('div', {
	    staticStyle: {
	      flex: "1",
	      flexDirection: "row",
	      justifyContent: "flex-end"
	    }
	  }, [_c('div', {
	    staticStyle: {
	      marginRight: "15px"
	    }
	  }, [_c('image', {
	    staticClass: ["navigationBar-icon"],
	    attrs: {
	      "src": "./images/msg_icon.png"
	    }
	  })]), _c('div', {
	    staticStyle: {
	      marginRight: "22px"
	    }
	  }, [_c('image', {
	    staticClass: ["navigationBar-icon"],
	    attrs: {
	      "src": "./images/icon_user.png"
	    }
	  })])])])
	},function (){var _vm=this;var _h=_vm.$createElement;var _c=_vm._self._c||_h;
	  return _c('div', {
	    staticStyle: {
	      marginLeft: "10px"
	    }
	  }, [_c('image', {
	    staticClass: ["broadcast-icon"],
	    attrs: {
	      "src": "./images/icon_broadcast.png"
	    }
	  })])
	},function (){var _vm=this;var _h=_vm.$createElement;var _c=_vm._self._c||_h;
	  return _c('div', {
	    staticClass: ["broadcast-arrow"]
	  }, [_c('text', [_vm._v(">>")])])
	}]}
	module.exports.render._withStripped = true

/***/ })
/******/ ]);