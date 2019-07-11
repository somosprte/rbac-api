# frozen_string_literal: true

require 'active_model_serializers'
require 'gallery/engine'
require 'gallery/functions_activity'
require 'open-uri'
require 'paperclip'
require 'prawn'
require 'pundit'
require 'sanitize'

module Gallery
  # V1
  module V1
    def self.pdf_generate(activity)
      margin_bottom = 12
      options = { page_size: 'A4', margin: [96, 48, 48, 72] }
      primary_color = '00AB4E'
      styles = {
        title: { align: :center, size: 20, color: primary_color, style: :bold },
        subtitle: { size: 12, color: primary_color, style: :bold },
        img: { width: 320, position: :center },
        image: { width: 200, position: :center },
        p: { size: 12, align: :justify },
        caption: { size: 12 },
        ul: { size: 11 }
      }
      Prawn::Document.new(options) do |pdf|
        header_group = lambda { |str, style|
          pdf.text str || '', styles[style]
          pdf.move_down margin_bottom
        }
        date_group = lambda { |str, date, align|
          pdf.text "#{str} #{date.strftime('%d/%m/%y às %H:%M')}", size: 9, align: align
          align == :left ? pdf.move_up(margin_bottom) : pdf.move_down(margin_bottom)
        }
        text_html_group = lambda { |subtitle, item, type = ''|
          pdf.text subtitle, styles[:subtitle]
          item&.scan(/src[^ ]+/)&.each { |url|
            pdf.image open(url[5..url.size - 2]), styles[:img]
            pdf.move_down margin_bottom - 6
          } unless type != 'html'
          pdf.text Sanitize.fragment(item) || '', styles[:p]
          pdf.move_down margin_bottom
        }
        list_group = lambda { |subtitle, items|
          pdf.text subtitle, styles[:subtitle]
          items&.each { |i| pdf.indent(15) { pdf.text "• #{i.name rescue i.title}", styles[:ul] } }
          pdf.move_down margin_bottom
        }
        # Defining the font family for the full pdf
        pdf.font 'Helvetica'
        # Title section
        header_group.call activity.title, :title
        # Created_at section
        date_group.call 'Data de criação:', activity.created_at, :left
        # Updated_at section
        date_group.call 'Data de atualização:', activity.updated_at, :right
        # SubTitle section
        header_group.call activity.caption, :caption
        # Image section
        pdf.image open(activity.image.url), styles[:image]
        pdf.move_down margin_bottom
        # Authors section
        list_group.call 'Autor(es)', activity.people
        # Description section
        text_html_group.call 'Descrição', activity.description
        # Motivation section
        text_html_group.call 'Motivação', activity.motivation
        # Products section
        text_html_group.call 'Produtos esperados', activity.products
        # Scopes section
        list_group.call 'Escopos', activity.scopes
        # Audience section
        list_group.call 'Público alvo', activity.audiences
        # Requirements section
        text_html_group.call 'Pré-requisitos', activity.requirements
        # Version history section
        text_html_group.call 'Histórico', activity.version_history
        # Copyright section
        text_html_group.call 'Copyright', activity.copyright
        # License type section
        text_html_group.call 'Tipo de licença', activity.license_type
        # Space types section
        list_group.call 'Tipos de espaços', activity.space_types
        # Space organization section
        text_html_group.call 'Organização do espaço', activity.space_organization, 'html'
        # Implementation steps section
        text_html_group.call 'Passos para Implementação', activity.implementation_steps, 'html'
        # General materials table
        unless activity.general_materials.empty?
          pdf.text 'Materiais Gerais', styles[:subtitle]
          table_data = [
            [
              { content: 'Quantidade', font_style: :bold, text_color: primary_color },
              { content: 'Nome', font_style: :bold, text_color: primary_color, width: pdf.bounds.width - 80 }
            ]
          ]
          activity.general_materials&.each do |general_material|
            quantity = general_material.activity_general_materials[0]&.quantity || 1 
            table_data << [
              { content: quantity.to_s, align: :center },
              { content: general_material.name.to_s || '' }
            ]
          end
          pdf.table(table_data) {}
          pdf.move_down margin_bottom + 6
        end
        # Specific materials section
        text_html_group.call 'Materiais específicos', activity.specific_materials
        # Powerful-ideas section
        text_html_group.call 'Poderosas Ideias', activity.powerful_ideas
        #  Implementation tips section
        text_html_group.call 'Dicas sobre a implementação', activity.implementation_tips, 'html'
        # Reflection assessment  section
        text_html_group.call 'Reflexão e avaliação', activity.reflection_assessment, 'html'
        # Duration section
        text_html_group.call 'Duração', activity.duration
        # Inspirations section
        list_group.call 'Atividades inspiradoras', activity.inspirations unless activity.inspirations.empty?
        # References section
        text_html_group.call 'Referências externas', activity.references, 'html'

        # Creating Header and Footer
        pdf.page_count.times do |i|
          pdf.go_to_page i + 1
          pdf.bounding_box([pdf.bounds.left, pdf.bounds.top + 76], width: pdf.bounds.width) {
            pdf.image "#{Rails.root}/public/mit_logo_green.jpg", width: 450, position: :center
          }
          pdf.bounding_box([pdf.bounds.left - 72, pdf.bounds.bottom - 6], width: pdf.bounds.width + 120, height: 24) {
            pdf.rectangle [0, pdf.bounds.bottom + 24], pdf.bounds.width, 24
            pdf.fill_color(primary_color)
            pdf.fill
            pdf.text (i + 1).to_s, align: :center, valign: :center, size: 9, style: :bold, color: 'ffffff'
          }
        end

        # pdf.render_file("public/#{activity.updated_at.strftime('%Y%m%dT%H%M')}_#{activity.id}.pdf") 
        pdf.render_file("public/#{activity.id}.pdf")
      end
    end
  end
end
