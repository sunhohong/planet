class MetaRadioButtonsInput < SimpleForm::Inputs::CollectionRadioButtonsInput
  def input
    # 이 라인이 좀 복잡하게 되어 버렸는데, 원래 설계는 ActiveRecord 객체에 module을 믹스인 해서
    # 메타 데이터 (meta_id)를 세팅한 다음 지정된 필드에 이 컬렉션을 가져오는 로직을 믹스인 하는 것이었음.
    # 다만, 클래스 메서드와 인스턴스 메서드를 동시에 믹스인 하려면 설정이 복잡해져서 포기하고 helper에
    # 로직을 넣는 구조로 바꿨다.
    # 메서드에 옵션으로 :meta가 들어오면 그 값을 세팅하고, 아니면 object에서 선언된 값을 넣는다.
    if input_options[:meta].blank?
      @collection = @builder.object.send("#{attribute_name}_code_values")
    else
      @collection = FieldValue.where( :meta_id => input_options[:meta] ).order( :seq )
    end

    attr = @builder.find_attribute( attribute_name )
    if attr.nil?
      default = @collection.find { |item| !item.default.nil? && item.default }
      input_options[:checked] = default.value.to_i unless default.nil?
    end

    # following lines are copy of CollectionRadioInput.input
    label_method, value_method = detect_collection_methods

    @builder.send("collection_radio",
      attribute_name, collection, value_method, label_method,
      input_options, input_html_options, &collection_block_for_nested_boolean_style
    )
  end
end

module SimpleForm
  # SimpleForm::FormBuilder.@object is private. So we needed to make method to get attribute's value.
  class FormBuilder
    def find_attribute(attribute_name)
      @object.send(attribute_name)
    end

    def object
      @object
    end
  end
end

