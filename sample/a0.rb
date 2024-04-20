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