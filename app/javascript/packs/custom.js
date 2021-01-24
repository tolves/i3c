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

function change_qty(qty, method) {
    var data = {product_id: qty.attr('value'), method: method}
    Rails.ajax({
        type: "POST",
        url: '/welcome/qty_change',
        data: new URLSearchParams(data).toString(),
        dataType: 'json',
        accept: 'json',
        error: function (xhr, status, error) {
            console.error('AJAX Error: ' + status + error);
        },
        success: function (response) {
            console.log(response);
            qty.html(response[0]);
            $('span#total').html(response[1])
        }
    })
}

function list_qty(qty, method) {
    var data = {product_id: qty.attr('value'), method: method}
    Rails.ajax({
        type: "POST",
        url: '/cart/qty_change',
        data: new URLSearchParams(data).toString(),
        dataType: 'json',
        accept: 'json',
        error: function (xhr, status, error) {
            console.error('AJAX Error: ' + status + error);
        },
        success: function (response) {
            console.log(response);
            qty.html(response[0]);
            qty.parent().parent().next().html(response[1]);
            $('span#total').html(response[2]);
        }
    })
}


$(document).ready(function () {

    $('div#minus').click(function () {
        var qty = $(this).next().children();
        if (qty.text() > 1) {
            change_qty(qty, 'minus')
        }
    });

    $('div#plus').click(function () {
        var qty = $(this).prev().children();
        change_qty(qty, 'plus');
    });

    $('div#list_minus').click(function () {
        var qty = $(this).next().children();
        if (qty.text() > 1) {
            list_qty(qty, 'minus')
        }
    })

    $('div#list_plus').click(function () {
        var qty = $(this).prev().children();
        list_qty(qty, 'plus');
    });


    $('select#product_category_id').change(function () {
        meta_data($(this).val());
    });
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
