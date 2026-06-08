# Patches the Feeling Responsive theme's Foundation 5 Sass files before
# compilation. The theme wraps pure-Sass arithmetic in CSS calc(), which
# causes Ruby Sass to treat the result as a string and fail when any
# subsequent arithmetic is attempted.
#
# Known broken patterns and their fixes:
#   percentage(calc($colNumber / $totalColumns))
#     -> percentage($colNumber / $totalColumns)
#
#   calc(strip-unit($value) / strip-unit($base-value) * 1rem)
#     -> strip-unit($value) / strip-unit($base-value) * 1rem
#
# Using a Generator (priority :highest) ensures this runs before Jekyll
# converts any Sass files.
module Jekyll
  class FixFoundationSass < Generator
    safe true
    priority :highest

    PATCHES = [
      # Foundation grid: percentage(calc(...)) -> percentage(...)
      [
        "percentage(calc($colNumber / $totalColumns))",
        "percentage($colNumber / $totalColumns)"
      ],
      # rem-calc / similar: calc(strip-unit arithmetic) used as a number
      [
        "calc(strip-unit($value) / strip-unit($base-value) * 1rem)",
        "strip-unit($value) / strip-unit($base-value) * 1rem"
      ],
      # strip-unit via px division wrapped in calc(), used as a divisor
      [
        "calc($value / 1px)",
        "$value / 1px"
      ],
      # block-grid percentage: calc((100/$even) / 100) passed to percentage()
      [
        "calc((100/$even) / 100)",
        "(100/$even) / 100"
      ],
    ].freeze

    def generate(site)
      theme = site.theme
      unless theme
        Jekyll.logger.warn "FixFoundationSass:", "No theme found, skipping patches"
        return
      end

      sass_dir = theme.sass_path
      unless Dir.exist?(sass_dir)
        Jekyll.logger.warn "FixFoundationSass:", "Theme sass_path not found: #{sass_dir}"
        return
      end

      Dir.glob(File.join(sass_dir, "**", "*.scss")).each do |path|
        content = File.read(path)
        patched = content.dup

        PATCHES.each do |broken, fixed|
          patched.gsub!(broken, fixed)
        end

        next if patched == content

        File.write(path, patched)
        Jekyll.logger.info "FixFoundationSass:", "Patched #{File.basename(path)}"
      end
    end
  end
end
