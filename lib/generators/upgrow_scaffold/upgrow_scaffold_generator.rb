class UpgrowScaffoldGenerator < Rails::Generators::NamedBase
  include Rails::Generators::ResourceHelpers

  source_root File.expand_path('templates', __dir__)
  argument :attributes, type: :array, default: [], banner: "field[:type][:index] field[:type][:index]"

  # When a generator is invoked, each public method in the generator is executed sequentially in the order that it is defined.
  def create_record
    template('record.rb', "app/records/#{file_name}_record.rb")
  end

  def create_repository
    template('repository.rb', "app/repositories/#{file_name}_repository.rb")
  end

  def create_input
    template('input.rb', "app/inputs/#{file_name}_input.rb")
  end

  def create_model
    template('model.rb', "app/models/#{file_name}.rb")
  end

  def create_show_action
    template('show_action.rb', "app/actions/show_#{singular_name}_action.rb")
  end

  def create_create_action
    template('create_action.rb', "app/actions/create_#{singular_name}_action.rb")
  end

  def create_delete_action
    template('delete_action.rb', "app/actions/delete_#{singular_name}_action.rb")
  end

  def create_edit_action
    template('edit_action.rb', "app/actions/edit_#{singular_name}_action.rb")
  end

  def create_list_action
    template('list_action.rb', "app/actions/list_#{singular_name}_action.rb")
  end

  def create_update_action
    template('update_action.rb', "app/actions/update_#{singular_name}_action.rb")
  end

  def create_controller
    template('controller.rb', "app/controllers/#{controller_name}_controller.rb")
  end

  private

  def parent_class_name_for_records
    'ApplicationRecord'
  end

  def record_class_name
    "#{class_name}Record"
  end

  def repository_class_name
    "#{class_name}Repository"
  end

  def input_class_name
    "#{class_name}Input"
  end

  def attributes_as_keyword_args_for_method_signature
    attributes_names.map do |attribute|
      "#{attribute}:"
    end.join(', ')
  end

  def attributes_as_input_args_for_method_params
    attributes_names.map do |attribute|
      "#{attribute}: input.#{attribute}"
    end.join(', ')
  end

  def attributes_as_model_args_for_method_params
    attributes_names.map do |attribute|
      "#{attribute}: #{singular_name}.#{attribute}"
    end.join(', ')
  end

  def attributes_as_symbols_for_method_params
    attributes_names.map do |attribute|
      ":#{attribute}"
    end.join(', ')
  end
end
