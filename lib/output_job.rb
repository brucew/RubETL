class OutputJob
  include SuckerPunch::Job

  def perform(outputs)
    #ActiveRecord::Base.connection_pool.with_connection do
      Output.transaction do
        outputs.each do |output|
          Output.create(output)
        end
      end
    #end
  end

end