class DataMapping
  def self.data_map(map={})
    define_singleton_method(:data_map) { map }
  end

  def self.transform(input, data_map=nil)
    input = input.attributes.symbolize_keys
    output = {}
    data_map ||= self.data_map || []
    data_map.each do |attr, mapping|
      case mapping.class.to_s
        when 'Symbol'
          output[attr] = input[mapping]
        when 'String'
          output[attr] = interpolate(mapping, input)
        when 'Array'
          child_mapping_class = WebviewResources::Current.module.const_get(attr.to_s.classify + 'Mapping')
          child_raw_data = input[mapping[0]]
          child_defaults = map_attributes(mapping[1], input)
          output[attr] = child_mapping_class.process_in_data(child_raw_data, child_defaults)
        when 'Proc'
          output[attr] = mapping.call(input)
        else
          output[attr] = mapping
      end
    end
    output
  end

  def self.interpolate(pattern, raw_data)
    string = pattern.gsub(/\{(\w*)([^\}]*)\}/) { |match| '#{raw_data[:' + $1 + ']' + $2 + '}' }
    string = '"' + string + '"'
    eval(string)
  end

end