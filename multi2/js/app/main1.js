define(function (require) {
    var $ = require('jquery-1.7'),
        lib = require('./lib1'),
        controller = require('./controller/c1'),
        model = require('./model/m1'),
        backbone = require('backbone'),
        underscore = require('underscore');

    //A fabricated API to show interaction of
    //common and specific pieces.
    controller.setModel(model);
    jQuery(function () {
        controller.render(lib.getBody());

        //Display backbone and underscore versions
        jQuery('body')
            .append('<div>backbone version: ' + backbone.VERSION + '</div>')
            .append('<div>underscore version: ' + underscore.VERSION + '</div>');
    });
});
