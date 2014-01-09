task :etl => :environment do
  Output.delete_all
  start_time = Time.now
  chunk_size = 1000
  chunk_count, remainder = Input.count.divmod(chunk_size)
  chunk_count += 1 if remainder > 0
  chunks = (1..chunk_count).to_a

  Parallel.each(chunks, in_processes: 10) do |chunk|
    p chunk
    inputs = Input.page(chunk).per(chunk_size)
    outputs = inputs.map { |input| InputToOutput.transform(input) }
    #Output.transaction do
    #outputs.each do |output|
    #outputs = outputs.select { |output| Output.new(output).valid? }
    Output.create_many(outputs)
    #end
    #end
  end

  p Time.now - start_time
end

task :create_input => :environment do
  Input.delete_all
  100000.times do
    name = Faker::Name.name
    address = "#{Faker::Address.street_address}\n#{[Faker::Address.secondary_address+"\n", nil].sample}#{Faker::Address.city}, #{Faker::Address.state} #{Faker::Address.zip}"
    email = Faker::Internet.email
    phone = Faker::PhoneNumber.phone_number
    is_admin = ['Y', 'N'].sample
    is_user = ['Y', 'N'].sample
    is_client = ['Y', 'N'].sample
    active = ['Y', 'N'].sample
    Input.create(name: name, address: address, email: email, phone: phone, is_admin: is_admin, is_user: is_user, is_client: is_client, active: active)
  end
end