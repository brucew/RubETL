class InputToOutput < DataMapping
  data_map first_name: "{name.split.first}",
           last_name: "{name.split[1..-1].join(' ')}",
           address_1: "{address.lines.first.chomp}",
           address_2: ->(i){ i[:address].lines[1].chomp if i[:address].lines.size > 2},
           city: "{address.lines.last.split(',').first}",
           state: "{address.lines.last.split(',').last.split.first}",
           zip: "{address.lines.last.split(',').last.split.last}",
           email: :email,
           phone: :phone
end
