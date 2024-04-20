class Gwara
  class Parser

    VOID_ELEMENTS = Set[
      "area", "base", "br", "col", "embed", "hr", "img",
      "input", "link", "meta", "param", "source", "track", "wbr"
    ]

    model :lemat do
      @marker_head = ""
      @marker_attrs = {}
      @attr_head = ""
      @opened_tags = []
      @buffer = ""
    end

    def add_text text
      @buffer << text
    end

    def close_tag tag = ""
      @buffer << html_end(tag.strip == "" ? @opened_tags.pop : tag)
    end

    def tag tag
      @marker_head = tag
      @marker_attrs = {}
      @opened_tags << tag if !VOID_ELEMENTS.include?(tag)
    end

    def marker_end
      @buffer << html(@marker_head, @marker_attrs)
    end

    def add_class str
      @marker_attrs["class"] = "#{@marker_attrs["class"]} #{str}"
    end

    def add_id str
      @marker_attrs["id"] = str
    end

    def add_attr_head str
      @attr_head = str
    end

    def add_attr_value str
      if @attr_head == "class"
        add_class str
      else
        @marker_attrs[@attr_head] = str
      end
    end

    def add_token str
      @marker_head << " " << str
    end

    def html_end marker
      marker ? "</#{marker}>" : ""
    end

    def html tag, attrs
      attrs_string = attrs.map do |k, v| 
        if v.start_with? "'"
          v = "\"#{v}\"" if !v.end_with? "'"
        elsif v.start_with? '"'
          v = "'#{v}'" if !v.end_with? '"'
        else
          v = "\"#{v.strip}\""
        end
        " #{k}=#{v}"
      end.join
      "<#{tag}#{attrs_string}>"
    end

    def close
      if !@opened_tags.empty?
        puts "There are some opened markers - closing them"
        @opened_tags.size.times{ close_tag }
      end
      @buffer
    end
  end
end