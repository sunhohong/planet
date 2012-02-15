#ActiveRecord::Base.send :extend, Engine::CodeSupport::MetaCode

# This module is to support meta code relation. It's idea is basically from connecting values
# by meta code. For example, :transportation => { 'Bus' => 1 'Taxi' => 2 'Train' => 3 }
module Engine
  module CodeSupport
    module MetaCode
      # This method generates class variable which is used to save meta code
      # and three methods dynamically by using class_eval.
      # Those methods are using attribute name that comes with param of code_field method.
      # * :location -> location_meta_id, location_code_name, location_code_values
      #
      # == API
      #
      # Within model class,
      #
      #   code_field :location => 1, :transportation => 3
      #
      def code_field( params = {} )
        params.each_pair do |key, value|
          self.class_variable_set("@@meta_code_meta_id_#{key}".to_sym, value)

          class_eval <<-end_eval
            def #{key}_meta_id
              @@meta_code_meta_id_#{key}
              @@meta_code_meta_id_#{key}
            end
            def #{key}_code_name
              value = FieldValue.where("meta_id = ? AND value = ?", #{key}_meta_id, #{key}).first
              value.name unless value.nil?
            end
            def #{key}_code_values
              FieldValue.values_by_meta_id(#{key}_meta_id)
            end
          end_eval
        end
      end
    end
  end
end