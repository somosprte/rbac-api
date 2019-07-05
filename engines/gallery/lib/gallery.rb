require "gallery/engine"
require 'prawn'
require 'open-uri'
require "active_model_serializers"
require "paperclip"
require "pundit"
require 'gallery/functions_activity'
require 'sanitize'

module Gallery

  module V1
    def self.pdf_generate(activity)
      primary_color = '00AB4E'
      margin_bottom = 12
      styles = {
        title: { align: :center, size: 20, color: primary_color, style: :bold },
        subtitle: { size: 12, color: primary_color, style: :bold },
        image: { width: 200, position: :center },
        p: { size: 12, align: :justify },
        caption: { size: 12 },
        ul: { size: 11 }
      }
      Prawn::Document.new(page_size: 'A4', margin: [96, 48, 48, 72]) do |pdf|
        # Defining the font family for the full pdf
        pdf.font 'Helvetica'
        # Title section
        pdf.text activity.title || '', styles[:title]
        pdf.move_down margin_bottom
        # SubTitle section
        pdf.text activity.caption || '', styles[:caption]
        pdf.move_down margin_bottom
        # Image section
        pdf.image open(activity.image.url), styles[:image]
        pdf.move_down margin_bottom
        # Authors section
        pdf.text 'Autor(es)', styles[:subtitle]
        activity.people&.each { |author| pdf.indent (15) {
          pdf.text "• #{author.name}", styles[:ul] }
        }
        pdf.move_down margin_bottom
        # Description section
        pdf.text 'Descrição', styles[:subtitle]
        pdf.text activity.description || '', styles[:p]
        pdf.move_down margin_bottom
        # Motivation section
        pdf.text 'Motivação', styles[:subtitle]
        pdf.text activity.motivation || '', styles[:p]
        pdf.move_down margin_bottom
        # Products section
        pdf.text 'Produtos esperados', styles[:subtitle]
        pdf.text activity.products || '', styles[:p]
        pdf.move_down margin_bottom
        # Scopes section
        pdf.text 'Escopos', styles[:subtitle]
        activity.scopes&.each { |scope| pdf.indent (15) {
          pdf.text "• #{scope.title}", styles[:ul] }
        }
        pdf.move_down margin_bottom
        # Audience section
        pdf.text 'Público alvo', styles[:subtitle]
        activity.audiences&.each { |audience| pdf.indent (15) {
          pdf.text "• #{audience.name}", styles[:ul] }
        }
        pdf.move_down margin_bottom
        # Requirements section
        pdf.text 'Pré-requisitos', styles[:subtitle]
        pdf.text activity.requirements || '', styles[:p]
        pdf.move_down margin_bottom
        # Version history section
        pdf.text 'Histórico', styles[:subtitle]
        pdf.text activity.version_history || '', styles[:p]
        pdf.move_down margin_bottom
        # Copyright section
        pdf.text 'Copyright', styles[:subtitle]
        pdf.text activity.copyright || '', styles[:p]
        pdf.move_down margin_bottom
        # License type section
        pdf.text 'Tipo de licença', styles[:subtitle]
        pdf.text activity.license_type || '', styles[:p]
        pdf.move_down margin_bottom
        # Space types section
        pdf.text 'Tipos de espaços', styles[:subtitle]
        activity.space_types&.each { |space_type| pdf.indent (15) {
          pdf.text "• #{space_type.title}", styles[:ul] }
        }
        pdf.move_down margin_bottom
        # Space organization section
        pdf.text 'Organização do espaço', styles[:subtitle]
        pdf.text Sanitize.fragment(activity.space_organization) || '', styles[:p]
        pdf.move_down margin_bottom
        # Implementation steps section
        pdf.text 'Passos para Implementação', styles[:subtitle]
        pdf.text Sanitize.fragment(activity.implementation_steps) || '', styles[:p]
        pdf.move_down margin_bottom        
        # General materials table
        pdf.text 'Materiais Gerais', styles[:subtitle]
        table_data = [
          [
            { content: 'Quantidade', font_style: :bold, text_color: primary_color },
            { content: 'Nome', font_style: :bold, text_color: primary_color, width: pdf.bounds.width - 80 }
          ]
        ]
        activity.general_materials&.each do |general_material| 
          table_data << [
            { content: general_material.activity_general_materials[0]&.quantity.to_s || 1 },
            { content: general_material.name.to_s || '' }
          ]
        end
        pdf.table(table_data) {  }
        pdf.move_down margin_bottom + 6
        # Specific materials section
        pdf.text 'Materiais específicos', styles[:subtitle]
        pdf.text activity.specific_materials || '', styles[:p]
        pdf.move_down margin_bottom
        # Powerful-ideas section
        pdf.text 'Poderosas Ideias', styles[:subtitle]
        pdf.text activity.powerful_ideas || '', styles[:p]
        pdf.move_down margin_bottom
        #  Implementation tips section
        pdf.text 'Dicas sobre a implementação', styles[:subtitle]
        pdf.text Sanitize.fragment(activity.implementation_tips) || '', styles[:p]
        pdf.move_down margin_bottom
        # Reflection assessment  section
        pdf.text 'Reflexão e avaliação', styles[:subtitle]
        pdf.text Sanitize.fragment(activity.reflection_assessment) || '', styles[:p]
        pdf.move_down margin_bottom
        # Duration section
        pdf.text 'Duração', styles[:subtitle]
        pdf.text activity.duration || '', styles[:p]
        pdf.move_down margin_bottom
        # Inspirations section
        pdf.text 'Atividades inspiradoras', styles[:subtitle]
        activity.inspirations&.each { |inspirations| pdf.indent (15) {
          pdf.text "• #{inspirations.title}", styles[:ul] }
        }
        pdf.move_down margin_bottom
        # References section
        pdf.text 'Referências externas', styles[:subtitle]
        pdf.text Sanitize.fragment(activity.references) || '', styles[:p]
        pdf.move_down margin_bottom
        
        # Creating Header and Footer
        pdf.page_count.times do |i|
          pdf.go_to_page i+1
          pdf.bounding_box([pdf.bounds.left, pdf.bounds.top + 76], width: pdf.bounds.width) {
            pdf.image "#{Rails.root}/public/mit_logo_green.jpg", width: 450, position: :center
          }
          pdf.bounding_box([pdf.bounds.left - 72, pdf.bounds.bottom - 6], width: pdf.bounds.width + 120, height: 24) {
            pdf.rectangle [0,pdf.bounds.bottom + 24], pdf.bounds.width, 24
            pdf.fill_color(primary_color)
            pdf.fill
            pdf.text "#{i+1}", align: :center, valign: :center, size: 9, style: :bold, color: 'ffffff'
          }
        end

        # pdf.render_file("public/#{activity.updated_at.strftime('%Y%m%dT%H%M')}_#{activity.id}.pdf") 
        pdf.render_file("public/#{activity.id}.pdf") 
      end
    end
  end

end
