require "gallery/engine"
require 'prawn'
module Gallery
  # Your code goes here...
  module V1
    def self.pdf_generate(activity)
      Prawn::Document.new(page_size: 'A4', margin: [90, 60, 60, 90]) do |pdf|
        pdf.font 'Helvetica'
        pdf.text '==========================================='*2
        # pdf.text activity.
        pdf.text '==========================================='
        p '==========================================='
        pdf.render_file('public/activity.pdf') # Gera o PDF e coloca na pasta public com o nome order.pdf
      end
    end
  end

  require "active_model_serializers"
  require "paperclip"
  require "pundit"
  require 'gallery/functions_activity'
end
