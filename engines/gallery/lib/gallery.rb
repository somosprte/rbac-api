require "gallery/engine"
require 'prawn'
require 'open-uri'

module Gallery
  # Your code goes here...
  module V1
    def self.pdf_generate(activity)
      primary_color = '226611'
      styles = {
        title: { align: :center, size: 24, color: primary_color, style: :bold },
        subtitle: { size: 14, color: primary_color, style: :bold },
        image: { width: 200, position: :center },
        caption: { size: 12 },
        p: { align: :justify },
        ul: { size: 10 }
      }
      Prawn::Document.new(page_size: 'A4', margin: [60, 45, 45, 60]) do |pdf|
        pdf.font 'Helvetica'
        # Title section
        pdf.text activity.title || '', styles[:title]
        pdf.move_down 12
        # SubTitle section
        pdf.text activity.caption || '', styles[:caption]
        pdf.move_down 12
        # Image section
        example_url = "https://s3-sa-east-1.amazonaws.com/api-rbac/gallery/activities/images/15798eb7-34d8-45c7-b489-deacb8f71a10/original/data?1562174792"
        pdf.image open(example_url), styles[:image]
        # pdf.image open(activity.image.url), styles[:image]
        pdf.move_down 12
        # Authors section
        pdf.text 'Autor(es)', styles[:subtitle]
        activity.people&.each { |author| pdf.text author.name, styles[:p] }
        pdf.move_down 12
        # Description section
        pdf.text 'Descrição', styles[:subtitle]
        pdf.text activity.description || '', styles[:p]
        pdf.move_down 12
        # Motivation section
        pdf.text 'Motivação', styles[:subtitle]
        pdf.text activity.motivation || '', styles[:p]
        pdf.move_down 12
        # Powerful-ideas section
        pdf.text 'Poderosas Ideias', styles[:subtitle]
        pdf.text activity.powerful_ideas || '', styles[:p]
        pdf.move_down 12
        # Products section
        pdf.text 'Produtos esperados', styles[:subtitle]
        pdf.text activity.products || '', styles[:p]
        pdf.move_down 12
        # Scopes section
        pdf.text 'Escopos', styles[:subtitle]
        activity.scopes&.each { |scope| pdf.text "\t• #{scope.title}", styles[:ul] }
        pdf.move_down 12
        # Audience section
        pdf.text 'Público alvo', styles[:subtitle]
        activity.audiences&.each { |audience| pdf.text "\t• #{audience.name}", styles[:ul] }
        pdf.move_down 12
        # Requirements section
        pdf.text 'Pré-requisitos', styles[:subtitle]
        pdf.text activity.requirements || '', styles[:p]
        pdf.move_down 12




        # Gera o PDF e coloca na pasta public com o nome {object.id}.pdf
        pdf.render_file("public/#{activity.id}.pdf") 
      end
    end
  end

  require "active_model_serializers"
  require "paperclip"
  require "pundit"
  require 'gallery/functions_activity'
end
