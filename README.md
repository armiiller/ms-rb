# ms-rb

Ruby port of the popular [JavaScript library **ms** (by Vercel)](https://github.com/vercel/ms).  
Convert human-readable durations like `"2h"`, `"1.5d"`, `"3w"`, `"500ms"`  
**into milliseconds and back.**

## Installation

```bash
gem install ms-rb
```
Or add this line to your application's Gemfile:

```ruby
gem 'ms-rb'
```

## Usage

```ruby
require "ms/rb"

Ms::Rb.ms("2h")            # => 7200000
Ms::Rb.parse("3d")         # => 259200000
Ms::Rb.format(1500)        # => "2s"
Ms::Rb.format(1500, long: true)
```

Supports:
- years (y)
- months (mo)
- weeks (w)
- days (d)
- hours (h)
- minutes (m)
- seconds (s)
- milliseconds (ms)

Follows the same parsing and formatting rules as the JavaScript library.
