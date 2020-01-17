const path = require('path')
const ExtractTextPlugin = require('extract-text-webpack-plugin')
const BUILD_JS_DIR = path.resolve(__dirname, 'web/js')
const DEV_DIR = path.resolve(__dirname, 'dev')
const WatchLiveReloadPlugin = require('webpack-livereload-plugin')

const extractLess = new ExtractTextPlugin({
  filename: '../css/[name].css',
  disable: process.env.NODE_ENV === 'development'
})

module.exports = {
  entry: {
    main: [`${DEV_DIR}/js/index.js`, `${DEV_DIR}/scss/styles.scss`]
  },
  output: {
    path: BUILD_JS_DIR,
    filename: '[name].min.js',
    publicPath: 'web/'
  },
  devtool: 'source-map',
  resolve: {
    modules: [path.resolve('./dev/js'), path.resolve('node_modules')]
  },
  module: {
    rules: [
      {
        test: /\.js?/,
        include: DEV_DIR + '/js/',

        use: {
          loader: 'babel-loader'
        }
      },
      {
        test: /\.scss$/,
        loader: extractLess.extract({
          fallback: 'style-loader',
          use: [
            {
              loader: 'css-loader',
              options: {
                sourceMap: true
              }
            },
            {
              loader: 'sass-loader',
              options: {
                sourceMap: true
              }
            }
          ]
        })
      },
      {
        test: /\.(woff(2)?|ttf|eot|gif|svg)(\?v=\d+\.\d+\.\d+)?$/,
        use: [
          {
            loader: 'file-loader',
            options: {
              name: '[name].[ext]',
              outputPath: '../fonts',
              publicPath: '/fonts'
            }
          }
        ]
      },
      {
        test: require.resolve('jquery'),
        loader: 'expose-loader?$!expose-loader?jQuery'
      },
      { test: require.resolve('./dev/js/_helpers'),
        loader: 'expose-loader?_helpers'
      }
    ]
  },
  plugins: [extractLess, new WatchLiveReloadPlugin()]
}
