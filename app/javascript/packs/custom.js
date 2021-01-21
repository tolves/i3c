$(document).ready(function () {
    // I dont understand why funtion showFrom isn't defined in js.
    // but window.showFrom worked, but it worked
    // window.showForm = function (id, width, title) {
    //     var el = $('#' + id).first();
    //     if (el.length === 0 || el.is(':visible')) {
    //         return;
    //     }
    //     if (!title) title = el.find('h3.title').text();
    //     // moves existing modals behind the transparent background
    //     $(".modal").css('zIndex', 99);
    //     el.dialog({
    //         width: width,
    //         modal: true,
    //         resizable: false,
    //         dialogClass: 'modal',
    //         title: title
    //     }).on('dialogclose', function () {
    //         $(".modal").css('zIndex', 101);
    //     });
    //     el.find("input[type=text], input[type=submit]").first().focus();
    // }
    // $('select#product_category_id').change(function () {
    //     $("#loading").show();
    //     // var data = {category_id: $(this).val()}
    //     // console.log(data)
    //
    //     $("#loading").hide();
    // });

    $('select#product_category_id').change(function () {
        meta_data($(this).val());
    })

    $('div#cpu').click(function () {
        products(this);
        console.log("ssd clicked");
    })

    $('div#ssd').click(function () {
        console.log("ssd clicked");
    })

    console.log("custom js file loaded");
});

function products(params) {
    console.log("cpu clicked");
    console.log(params);
    // var data = {id: 1}
    // console.log(data)
    Rails.ajax({
        type: "POST",
        url: '/admin/categories/5/ajax_products',
        // data: new URLSearchParams(data).toString(),
        dataType: 'json',
        accept: 'json',
        error: function (xhr, status, error) {
            console.error('AJAX Error: ' + status + error);
        },
        success: function (response) {
            console.log(response);
            $("#products").empty();
            for (var i in response) {
                $('#products').append("<div id='product' value=" + response[i]['id'] + ">" + response[i]['title'] + "</div>");
            }
            // $("#meta_data").empty();
            // for (var i in response) {
            //     $('#meta_data').append("<label For='product[meta_data][" + response[i] + "]'>" + response[i] + "</label>: <input tyee='text' name='product[meta_data][" + response[i] + "]' id='product[meta_data][" + response[i] + "]'></br>");
            // }
        }
    })
}

function meta_data(id) {
    // var data = {category_id: $(this).val()}
    Rails.ajax({
        type: "POST",
        url: '/admin/categories/' + id + '/meta_data',
        // data: new URLSearchParams(data).toString(),
        dataType: 'json',
        accept: 'json',
        error: function (xhr, status, error) {
            console.error('AJAX Error: ' + status + error);
        },
        success: function (response) {
            $("#meta_data").empty();
            for (var i in response) {
                $('#meta_data').append("<label For='product[meta_data][" + response[i] + "]'>" + response[i] + "</label>: <input tyee='text' name='product[meta_data][" + response[i] + "]' id='product[meta_data][" + response[i] + "]'></br>");
            }
        }
    })
}