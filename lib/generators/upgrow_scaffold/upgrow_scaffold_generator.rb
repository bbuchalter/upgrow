class UpgrowScaffoldGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('templates', __dir__)

  # When a generator is invoked, each public method in the generator is executed sequentially in the order that it is defined.
  def create_record
    template('record.rb', "app/records/#{file_name}_record.rb")
  end

  private

  def parent_class_name_for_records
    'ApplicationRecord'
  end
end
