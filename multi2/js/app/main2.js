define(function (require) {
    var $ = require('jquery-3.0'),
        lib = require('./lib2'),
        controller = require('./controller/c2'),
        model = require('./model/m2');

    //A fabricated API to show interaction of
    //common and specific pieces.
    controller.setModel(model);
    jQuery(function () {
        controller.render(lib.getBody());
    });
});
