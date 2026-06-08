# Patches the Feeling Responsive theme's Foundation 5 grid component before
# Sass compilation. The theme's _grid.scss uses:
#   percentage(calc($colNumber / $totalColumns))
# which fails in all Sass versions because calc() returns a CSS string, not a
# number. We replace it with the correct:
#   percentage($colNumber / $totalColumns)
#
# Using a Generator (priority :highest) ensures this runs before Jekyll
# converts any Sass files.
module Jekyll
  class FixFoundationGrid < Generator
    safe true
    priority :highest

    def generate(site)
      theme = site.theme
      unless theme
        Jekyll.logger.warn "FixFoundationGrid:", "No theme found, skipping patch"
        return
      end

      grid_path = File.join(theme.sass_path, "foundation-components", "_grid.scss")
      unless File.exist?(grid_path)
        Jekyll.logger.warn "FixFoundationGrid:", "Grid file not found at #{grid_path}"
        return
      end

      content = File.read(grid_path)
      fixed = content.gsub(
        "percentage(calc($colNumber / $totalColumns))",
        "percentage($colNumber / $totalColumns)"
      )

      if fixed == content
        Jekyll.logger.info "FixFoundationGrid:", "No patch needed (already fixed or pattern not found)"
      else
        File.write(grid_path, fixed)
        Jekyll.logger.info "FixFoundationGrid:", "Patched Foundation grid calc() bug in #{grid_path}"
      end
    end
  end
end
