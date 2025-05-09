const defaultTheme = require('tailwindcss/defaultTheme');

module.exports = {
  content: [
    "./app/**/*.html.erb",
    "./app/**/*.html",
    "./app/helpers/**/*.rb",
    "./app/javascript/**/*.js",
    "./app/views/**/*.{erb,haml,html,slim}",
    "./app/assets/stylesheets/**/*.css",
    "./app/components/**/*.{erb,rb}",  // Ensure ViewComponents are scanned
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ['Inter var', ...defaultTheme.fontFamily.sans],
      },
      colors: {
        'text-tertiary': '#FAC1D9',
        'bg-tertiary': '#FAC1D9',
        'bg-secondary': '#292C2D',
        'bg-primary': '#3D4142',  // Fixed missing '#'
        'bg-ternary': '#5E5E5E',
        'text-secondary': '#333333',
        'text-primary': '#ffffff',
        'border-tertiary': '#FAC1D9',
      }
    },
  },
  plugins: [
    // Uncomment if you are using these plugins
    // require('@tailwindcss/forms'),
    // require('@tailwindcss/typography'),
    // require('@tailwindcss/container-queries'),
  ],
};
