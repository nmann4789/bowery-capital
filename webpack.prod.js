const path = require('path')
const BUILD_DIR = path.resolve(__dirname, 'web/build')
const DEV_DIR = path.resolve(__dirname, 'dev')
const MiniCssExtractPlugin = require('mini-css-extract-plugin')
const WebpackAssetsManifest = require('webpack-assets-manifest')
const { CleanWebpackPlugin } = require('clean-webpack-plugin')

// production webpack

module.exports = {
  entry: {
    main: [`${DEV_DIR}/js/index.js`, `${DEV_DIR}/scss/styles.scss`]
  },
  output: {
    path: BUILD_DIR,
    filename: 'js/[name].min.[contenthash].js',
    publicPath: 'web/'
  },
  devtool: 'none',
  resolve: {
    modules: [path.resolve('./dev/js'), path.resolve('node_modules')]
  },
  module: {
    rules: [{
      test: /\.js?/,
      include: DEV_DIR + '/js/',

      use: {
        loader: 'babel-loader'
      }
    },
    {
      test: /\.(sa|sc|c)ss$/,
      use: [
        MiniCssExtractPlugin.loader,
        'css-loader',
        'sass-loader'
      ]
    },
    {
      test: /\.(woff(2)?|ttf|eot|gif|svg)(\?v=\d+\.\d+\.\d+)?$/,
      use: [{
        loader: 'file-loader',
        options: {
          name: '[name].[ext]',
          outputPath: '../fonts',
          publicPath: '/fonts'
        }
      }]
    },
    {
      test: require.resolve('jquery'),
      loader: 'expose-loader?$!expose-loader?jQuery'
    },
    {
      test: require.resolve('./dev/js/_helpers'),
      loader: 'expose-loader?_helpers'
    }
    ]
  },
  plugins: [new MiniCssExtractPlugin({
    filename: `css/[name].[contenthash].css`
  }),
  new WebpackAssetsManifest({
    entrypointsKey: true,
    publicPath (filename, manifest) {
      if (filename.includes('css/')) {
        return filename.replace('css/', '')
      }
      if (filename.includes('js/')) {
        return filename.replace('js/', '')
      }
      return filename
    }
  }),
  new CleanWebpackPlugin()
  ]
}
