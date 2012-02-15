module ItemsHelper
  def field_options( code, field_value = nil )
    FieldValue.where( :meta_id => code ).order( :seq )
  end

end
