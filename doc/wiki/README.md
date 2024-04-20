Welcome to the _gwara_ documentation home page!
===

Installation
---
```
gem install gwara
```

Basics
---

- element classes can be encoded as: `.class`
- element id can be encoded as: `#id`
- element attributes can be encoded as: `[name value]`
- element close tag can be encoded as: `<>`

Usage
---
### 1. Complete example
```RUBY
require 'gwara'

gwara = Gwara.new
gwara << <<-HJZ
<div .field>
  <label .label .is_bold> Label <>
  <input [type text] #txt [placeholder "Text placeholder"]>
<>
HJZ

puts gwara.to_s

# out:
#
# <div class="field">
#   <label class="label is_bold"> Label </label>
#   <input type="text" id="txt" placeholder="Text placeholder">
# </div>
```


Authors
---
- Łukasz Pomietło (oficjalnyadreslukasza@gmail.com)
