class Gwara
  class Lexer

    model :parser do
      @state = [:text]
      @buffer = ""
    end

    def <<(ch)
      case @state.last
      when :text
        case ch
        when "<"
          @parser.add_text @buffer
          @buffer = ""
          @state << :marker_begin
        else
          @buffer << ch
        end
      when :marker_begin
        case ch
        when ">"
          @parser.close_tag
          @state >> 1
        when "/"
          @state >> 1 << :close_tag
        when /\s/
        else
          @state >> 1 << :marker << :tag
          self << ch
        end
      when :close_tag
        case ch
        when ">"
          @parser.close_tag @buffer
          @buffer = ""
          @state >> 1
        else
          @buffer << ch
        end
      when :tag
        case ch
        when /[ .\[#>]/
          @parser.tag @buffer
          @state >> 1
          self << ch
        else
          @buffer << ch
        end
      when :marker
        case ch
        when "."
          @buffer = ""
          @state << :class
        when ">"
          @buffer = ""
          @parser.marker_end
          @state >> 1
        when "#"
          @buffer = ""
          @state << :id
        when "["
          @buffer = ""
          @state << :attr_before_head
        when /\s/
        else
          @buffer = ""
          @state << :token
          self << ch
        end
      when :class
        case ch
        when /[ .\[#>]/
          @parser.add_class @buffer
          @state >> 1
          self << ch
        else
          @buffer << ch
        end
      when :id
        case ch
        when /[ .\[#>]/
          @parser.add_id @buffer
          @state >> 1
          self << ch
        else
          @buffer << ch
        end
      when :attr_before_head
        case ch
        when /\s/
        when "]"
          @state >> 1
        else
          @state >> 1 << :attr_head
          self << ch
        end
      when :attr_head
        case ch
        when /[ =\]]/
          @parser.add_attr_head @buffer
          @state >> 1 << :attr_before_value
          self << ch
        else
          @buffer << ch
        end
      when :attr_before_value
        case ch
        when /[ =]/
        else
          @buffer = ""
          @state >> 1 << :attr_value
          self << ch
        end
      when :attr_value
        case ch
        when "]"
          @parser.add_attr_value @buffer
          @state >> 1
        else
          @buffer << ch
        end
      when :token
        case ch
        when /[ .\[#>]/
          @parser.add_token @buffer
          @state >> 1
          self << ch
        when '"'
          @buffer << ch
          @state << :double_quoted_token
        when "'"
          @buffer << ch
          @state << :single_quoted_token
        else
          @buffer << ch
        end
      when :double_quoted_token
        case ch
        when '"'
          @buffer << ch
          @state >> 1
        else
          @buffer << ch
        end
      when :single_quoted_token
        case ch
        when "'"
          @buffer << ch
          @state >> 1
        else
          @buffer << ch
        end
      end
      
    end

    def close
      case @state.last
      when :text
        @parser.add_text @buffer
      else
        raise "Unexpected close at #{@state.last} state"
      end
      @state = []
      @buffer = ""
    end
  end
end