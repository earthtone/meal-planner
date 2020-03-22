const tailwind = require('tailwindcss')
const postcssTailwindElm = require('postcss-elm-tailwind')
const purgecss = require('@fullhuman/postcss-purgecss')

const plugins = [
  tailwind(),
  postcssTailwindElm()
]

if (process.env.NODE_ENV === 'production') {
  plugins.push(purgecss({
    content: ['index.html', './**/*.elm']
  }))
}

module.exports = { plugins }
