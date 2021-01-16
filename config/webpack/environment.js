const {environment} = require('@rails/webpacker')

const webpack = require('webpack')

// Add an additional plugin of your choosing : ProvidePlugin
environment.plugins.prepend('Provide', new webpack.ProvidePlugin({
        $: 'jquery',
        JQuery: 'jquery',
        jquery: 'jquery',
        "window.jQuery": "jquery",
        Popper: ['popper.js', 'default'], // for Bootstrap 4
        Rails: ['@rails/ujs']
    })
)

const config = environment.toWebpackConfig()

config.resolve.alias = {
    'jquery': "jquery/src/jquery"
}

// export the updated config
module.exports = environment