source "https://rubygems.org"

# Minimal Mistakes theme gem — used for local preview.
# GitHub Pages deployment uses remote_theme instead (see _config.yml).
# Run:     bundle install
# Preview: bundle exec jekyll serve --config _config.yml,_config_local.yml
gem "minimal-mistakes-jekyll"

# github-pages gem provides Jekyll + compatible plugins for local parity.
gem "github-pages", group: :jekyll_plugins

# ----------------------------------------------------------------
# Ruby version note:
#   GitHub Pages runs Ruby 3.x. If you're on Ruby 2.6 locally and
#   see ffi version errors, either:
#     (a) Upgrade Ruby — recommended: rbenv install 3.3.0 && rbenv local 3.3.0
#     (b) Or keep the pin below as a short-term workaround:
# ----------------------------------------------------------------
gem "ffi", "< 1.17"

# Windows and JRuby timezone support
platforms :mingw, :x64_mingw, :mswin, :jruby do
  gem "tzinfo", ">= 1", "< 3"
  gem "tzinfo-data"
end

# Performance boost for file watchers on Windows
gem "wdm", "~> 0.1.1", platforms: [:mingw, :x64_mingw, :mswin]

# Lock http_parser.rb to a version that works on all platforms
gem "http_parser.rb", "~> 0.6.0", platforms: [:jruby]



