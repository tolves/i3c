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

function show_products(id) {
    console.log("category clicked");
    // console.log(data)
    Rails.ajax({
        type: "POST",
        url: "/admin/categories/" + id + "/ajax_products",
        // data: new URLSearchParams(data).toString(),
        dataType: 'json',
        accept: 'json',
        error: function (xhr, status, error) {
            console.error('AJAX Error: ' + status + error);
        },
        success: function (response) {
            console.log(response);
            $('div#products_' + id).empty();
            for (var i in response) {
                $('div#products_' + id).append("<div id='product' value=" + response[i]['id'] + ">" + response[i]['title'] + "</div>");
            }
            $('div#product').click(function () {
                select_product($(this).attr("value"));
            })
        }
    })
}

function select_product(product_id) {
    console.log(product_id);
    data = {id: product_id};
    Rails.ajax({
        type: "POST",
        url: '/welcome/ajax_session',
        data: new URLSearchParams(data).toString(),
        dataType: 'json',
        accept: 'json',
        error: function (xhr, status, error) {
            console.error('AJAX Error: ' + status + error);
        },
        success: function (response) {
            console.log(response);
            $('div#selected_' + response['category_id']).html(response['title']);
            $('div#quantity_' + response['category_id']).html(response['quantity']);
            $('div#products_' + response['category_id']).empty();
            show_total();
        }
    })
}

function show_total() {
    Rails.ajax({
        type: "POST",
        url: '/welcome/ajax_total',
        dataType: 'json',
        accept: 'json',
        error: function (xhr, status, error) {
            console.error('AJAX Error: ' + status + error);
        },
        success: function (response) {
            $('span#total').html(response);
        }
    })
}

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
    //     meta_data($(this).val());
    // });
    //
    // $('div.selected_product').click(function () {
    //     show_products($(this).attr("value"));
    // });

    // paypal.Buttons().render('#paypal-button-container');

    // paypal.Buttons({
    //     createOrder: function(data, actions) {
    //         // This function sets up the details of the transaction, including the amount and line item details.
    //         return actions.order.create({
    //             purchase_units: [{
    //                 amount: {
    //                     value: '0.01'
    //                 }
    //             }]
    //         });
    //     },
    //     onApprove: function(data, actions) {
    //         // This function captures the funds from the transaction.
    //         return actions.order.capture().then(function(details) {
    //             // This function shows a transaction success message to your buyer.
    //             alert('Transaction completed by ' + details.payer.name.given_name);
    //         });
    //     }
    // }).render('#paypal-button-container');
    //This function displays Smart Payment Buttons on your web page.

    console.log("custom js file loaded");
});
