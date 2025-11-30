# ms-rb

[![Gem Version](https://badge.fury.io/rb/ms-rb.svg)](https://badge.fury.io/rb/ms-rb)
![Build Status](https://github.com/armiiller/ms-rb/actions/workflows/ci.yml/badge.svg)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

A Ruby port of the popular [`ms`](https://github.com/vercel/ms) library from Vercel.

Convert human-friendly time strings like `"1h"`, `"2 days"`, `"3w"`, `"1.5mo"` into milliseconds — and convert milliseconds back into strings.

This gem aims to match the behavior of Vercel/ms, including:

- `ms("1h") -> 3600000`
- `ms(3600000) -> "1h"`
- Strict and non-strict parsing
- Long and short formatting
- Floating-point and negative values
- Full unit support (ms, s, m, h, d, w, mo, y)

---

## Installation

Add to your Gemfile:

```ruby
gem "ms-rb"
```

Or install directly:

```bash
gem install ms-rb
```

Then require it:

```ruby
require "ms"
```

---

## Usage

The main entrypoint is:

```ruby
Ms.ms(value, long: false)
```

### Parse a duration string → milliseconds

```ruby
Ms.ms("2h")          # => 7200000
Ms.ms("1.5d")        # => 129600000
Ms.ms("3 weeks")     # => 1814400000
Ms.ms("-10ms")       # => -10
Ms.ms("1   s")       # => 1000
```

### Format milliseconds → duration string

Short form:

```ruby
Ms.ms(3600000)                 # => "1h"
Ms.ms(5400000)                 # => "2h"
```

Long form:

```ruby
Ms.ms(3600000, long: true)     # => "1 hour"
Ms.ms(5400000, long: true)     # => "2 hours"
```

### Strict parsing

```ruby
Ms.parse_strict("1h")   # => 3600000
Ms.parse_strict("foo")  # => NaN
```

---

## Supported Units

| Unit(s)                                | Meaning      |
|----------------------------------------|--------------|
| `ms`, `msec`, `millisecond`, `milliseconds` | Milliseconds |
| `s`, `sec`, `second`, `seconds`             | Seconds      |
| `m`, `min`, `minute`, `minutes`             | Minutes      |
| `h`, `hr`, `hour`, `hours`                  | Hours        |
| `d`, `day`, `days`                          | Days         |
| `w`, `week`, `weeks`                        | Weeks        |
| `mo`, `month`, `months`                     | Months       |
| `y`, `yr`, `year`, `years`                  | Years        |

Supports floats, negative values, and mixed case:

```ruby
Ms.ms("1.5H")      # => 5400000
Ms.ms("-.5h")      # => -1800000
Ms.ms("53 YeArS")  # => 1672552800000
```

---

## API

### `Ms.ms(value, long: false)`

Main entrypoint. Accepts:

- `String` → returns milliseconds (`Integer` or `Float`)
- `Numeric` → returns formatted string (`"1h"` or `"1 hour"`)

Example:

```ruby
Ms.ms("2h")                 # => 7200000
Ms.ms(7200000)              # => "2h"
Ms.ms(7200000, long: true)  # => "2 hours"
```

### `Ms.parse(string)`

Non-strict parser.  
Returns `NaN` for invalid input.

### `Ms.parse_strict(string)`

Strict parser.  
Raises on invalid input types, returns `NaN` for malformed strings.

### `Ms.format(ms, long: false)`

Formats milliseconds directly.

---

## Testing

```bash
bundle install
bundle exec rake test
```

---

## License

MIT © Austin Miller
