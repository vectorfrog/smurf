// See the Tailwind configuration guide for advanced usage
// https://tailwindcss.com/docs/configuration

const plugin = require("tailwindcss/plugin")
const fs = require("fs")
const path = require("path")

module.exports = {
  content: [
    "./js/**/*.js",
    "../lib/smurf_web.ex",
    "../lib/smurf_web/**/*.*ex",
    "../lib/smurf_web/**/*.*sface"
  ],
  theme: {
    extend: {
      colors: {
        brand: "#FD4F00",
        primary: { DEFAULT: '#386E81', 50: '#D5E7ED', 100: '#C7DEE7', 200: '#ABCEDA', 300: '#8EBDCE', 400: '#72ADC2', 500: '#559CB5', 600: '#44869D', 700: '#386E81', 800: '#274D5A', 900: '#162B33', 950: '#0E1B1F' },
        secondary: { DEFAULT: '#6A8887', 50: '#FDFEFE', 100: '#F2F5F5', 200: '#DBE3E3', 300: '#C4D1D1', 400: '#ADBFBF', 500: '#96ADAD', 600: '#7F9B9B', 700: '#6A8887', 800: '#516868', 900: '#394948', 950: '#2D3939' },
        accent: { DEFAULT: '#1DC689', 50: '#EFFDF8', 100: '#DEFAF0', 200: '#BAF5E0', 300: '#97F0D0', 400: '#73EABF', 500: '#4FE5AF', 600: '#2CE09F', 700: '#1DC689', 800: '#169567', 900: '#0F6445', 950: '#0B4C34' },
        info: { DEFAULT: '#1B211B', 50: '#C6D1C6', 100: '#BBC7BB', 200: '#A5B5A5', 300: '#8EA38E', 400: '#789078', 500: '#647B64', 600: '#526452', 700: '#404E40', 800: '#2D372D', 900: '#1B211B', 950: '#0E120E' },
        success: { DEFAULT: '#469C5F', 50: '#F2F9F4', 100: '#E4F3E8', 200: '#C8E6D1', 300: '#ACDAB9', 400: '#8FCDA1', 500: '#73C08A', 600: '#57B472', 700: '#469C5F', 800: '#357547', 900: '#234F30', 950: '#1B3B24' },
        warning: { DEFAULT: '#C38B27', 50: '#FDFBF6', 100: '#FAF2E5', 200: '#F3E2C3', 300: '#ECD1A1', 400: '#E5C17F', 500: '#DFB05D', 600: '#D8A03B', 700: '#C38B27', 800: '#946A1E', 900: '#664814', 950: '#4E3810' },
        error: { DEFAULT: '#F44336', 50: '#FFFFFF', 100: '#FFFFFF', 200: '#FFF8F7', 300: '#FCD4D1', 400: '#FAB0AA', 500: '#F88B83', 600: '#F6675D', 700: '#F44336', 800: '#E51B0D', 900: '#B0150A', 950: '#961208' },
      }
    },
  },
  plugins: [
    require("@tailwindcss/forms"),
    // Allows prefixing tailwind classes with LiveView classes to add rules
    // only when LiveView classes are applied, for example:
    //
    //     <div class="phx-click-loading:animate-ping">
    //
    plugin(({ addVariant }) => addVariant("phx-no-feedback", [".phx-no-feedback&", ".phx-no-feedback &"])),
    plugin(({ addVariant }) => addVariant("phx-click-loading", [".phx-click-loading&", ".phx-click-loading &"])),
    plugin(({ addVariant }) => addVariant("phx-submit-loading", [".phx-submit-loading&", ".phx-submit-loading &"])),
    plugin(({ addVariant }) => addVariant("phx-change-loading", [".phx-change-loading&", ".phx-change-loading &"])),

    // Embeds Heroicons (https://heroicons.com) into your app.css bundle
    // See your `CoreComponents.icon/1` for more information.
    //
    plugin(function({ matchComponents, theme }) {
      let iconsDir = path.join(__dirname, "./vendor/heroicons/optimized")
      let values = {}
      let icons = [
        ["", "/24/outline"],
        ["-solid", "/24/solid"],
        ["-mini", "/20/solid"]
      ]
      icons.forEach(([suffix, dir]) => {
        fs.readdirSync(path.join(iconsDir, dir)).forEach(file => {
          let name = path.basename(file, ".svg") + suffix
          values[name] = { name, fullPath: path.join(iconsDir, dir, file) }
        })
      })
      matchComponents({
        "hero": ({ name, fullPath }) => {
          let content = fs.readFileSync(fullPath).toString().replace(/\r?\n|\r/g, "")
          return {
            [`--hero-${name}`]: `url('data:image/svg+xml;utf8,${content}')`,
            "-webkit-mask": `var(--hero-${name})`,
            "mask": `var(--hero-${name})`,
            "mask-repeat": "no-repeat",
            "background-color": "currentColor",
            "vertical-align": "middle",
            "display": "inline-block",
            "width": theme("spacing.5"),
            "height": theme("spacing.5")
          }
        }
      }, { values })
    })
  ]
}
