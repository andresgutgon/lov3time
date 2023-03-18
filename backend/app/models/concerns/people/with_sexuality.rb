# frozen_string_literal: true

module People
  module WithSexuality
    extend ActiveSupport::Concern

    SEXUALITY = %w[
      prefer_not_to_say
      straight
      gay
      lesbian
      bisexual
      allosexual
      androsexual
      asexual
      autosexual
      bicurious
      demisexual
      fluid
      graysexual
      polysexual
      pansexual
      queer
      questioning
      skoliosexual
      not_listed
    ].freeze

    included do
      assignable_values_for(
        :sexuality,
        allow_blank: true
      ) do
        SEXUALITY
      end
    end
  end
end
