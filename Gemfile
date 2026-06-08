source "https://rubygems.org"

# Use the same gem bundle as GitHub Pages for local parity.
# Run:     bundle install
# Preview: bundle exec jekyll serve  (requires SSL — see _config_local.yml)
gem "github-pages", group: :jekyll_plugins

# Required by Feeling Responsive via remote_theme
gem "jekyll-remote-theme"
gem "jekyll-include-cache"

# ----------------------------------------------------------------
# Ruby version note:
#   GitHub Pages runs Ruby 3.x. If you're on Ruby 2.6 locally and
#   see ffi version errors, either:
#     (a) Upgrade Ruby — recommended (use rbenv or rvm):
#           rbenv install 3.3.0 && rbenv local 3.3.0
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



