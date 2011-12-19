# encoding: utf-8

class Korean
  # 받침에 따른 알맞은 조사를 구한다.
  PROPOSITIONS = {'이' => '가', '은' => '는', '을' => '를', '과' => '와'}

  def self.get_proposition word, proposition
    # 한국어만 처리한다.
    return '' if word.size == word.bytesize

    # 받침이 없을 때
    if word.mb_chars.last.decompose[2].nil?
      PROPOSITIONS[proposition] || proposition
    # 받침이 있을 때
    else
      PROPOSITIONS.invert[proposition] || proposition
    end
  end
end

module ActiveModel
  class Errors
    def korean_full_messages
      # 한국어 설정이 아니면 full_messages를 돌려준다.
      return full_messages unless I18n.locale == :ko

      full_messages.map do |message|
        # 오류 문구에서 ((조사)) 형태를 찾아 받침에 맞는 조사로 바꿔 준다.
        message.gsub(/(?<=(.{1}))\(\(([이가은는을를과와])\)\)/) do
          Korean.get_proposition $1, $2
        end
      end
    end
  end
end

# korean message helper mixin for simple-form gem
module SimpleForm
  module Components
    module Errors
      def error
        if has_errors? 
          error_text.gsub(/(?<=(.{1}))\(\(([이가은는을를과와])\)\)/) do
            Korean.get_proposition $1, $2
          end
        end
      end
    end
  end
end
