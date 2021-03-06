class UpgrowScaffoldGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('templates', __dir__)

  # When a generator is invoked, each public method in the generator is executed sequentially in the order that it is defined.
  def create_record
    template('record.rb', "app/records/#{file_name}_record.rb")
  end

  def create_repository
    template('repository.rb', "app/repositories/#{file_name.pluralize}_repository.rb")
  end


  private

  def parent_class_name_for_records
    'ApplicationRecord'
  end

  def record_class_name
    "#{class_name}Record"
  end
end
