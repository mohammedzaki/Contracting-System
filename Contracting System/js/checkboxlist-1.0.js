
(function ($, undefined) {
    
    $.fn.checklistbox = function () {
        
        var select = $(this);
        var html = '<div id="' + $(select).attr('id') + '" style="border:2px; solid #ccc; width:300px; height: 100px; overflow-y: scroll;">';

        $(select).children().each(function () {
            html += '<input type="checkbox" value="' + $(this).val() + '" /> ' + $(this).html() + ' <br />';
        });
        
        html += '</div>';
        $(this).replaceWith(html);
    };
} (jQuery));

