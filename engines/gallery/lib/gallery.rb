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
        list_group.call 'Autor(es)', activity.people unless activity.people.blank?
        # External authors section
        external_authors = activity.external_authors&.to_s.gsub(/\[|\]|\"/,'').gsub(/\,(?=[^\,]*$)/,' e')
        text_html_group.call 'Autores externos', external_authors unless activity.external_authors.blank?
        # Inserted by section
        name = User::Person.find_by_id(activity.inserted_by)&.name
        text_html_group.call 'Inserida por', name
        # Description section
        text_html_group.call 'Descrição', activity.description unless activity.description.blank?
        # Motivation section
        text_html_group.call 'Motivação', activity.motivation unless activity.motivation.blank?
        # Powerful-ideas section
        text_html_group.call 'Poderosas Ideias', activity.powerful_ideas unless activity.powerful_ideas.blank?
        # Products section
        text_html_group.call 'Produtos esperados', activity.products unless activity.products.blank?
        # Scopes section
        list_group.call 'Escopos', activity.scopes unless activity.scopes.blank?
        # Audience section
        list_group.call 'Público alvo', activity.audiences unless activity.audiences.blank?
        # Requirements section
        text_html_group.call 'Pré-requisitos', activity.requirements unless activity.requirements.blank?
        # Version history section
        text_html_group.call 'Histórico', activity.version_history unless activity.version_history.blank?
        # Copyright section
        text_html_group.call 'Copyright', activity.copyright unless activity.copyright.blank?
        # License section
        license = Gallery::License.find_by_id(activity.license_id)
        text_html_group.call 'Licença', license.title&.to_s, 'html' unless activity.license_id.blank?
        # Space types section
        list_group.call 'Tipos de espaços', activity.space_types unless activity.space_types.blank?
        # Space organization section
        text_html_group.call 'Organização do espaço', activity.space_organization, 'html' unless activity.space_organization.blank?
        # Implementation steps section
        text_html_group.call 'Passos para Implementação', activity.implementation_steps, 'html' unless activity.implementation_steps.blank?
        # General materials table
        unless activity.general_materials.blank?
          pdf.text 'Materiais Gerais', styles[:subtitle]
          table_data = [
            [
              { content: 'Quantidade', font_style: :bold, text_color: primary_color },
              { content: 'Nome', font_style: :bold, text_color: primary_color, width: pdf.bounds.width - 80 }
            ]
          ]
          activity.general_materials&.each do |general_material|
            quantity = Gallery::ActivityGeneralMaterial.find_by(
              activity_id: activity.id, general_material_id: general_material.id
            )&.quantity || 0
            table_data << [
              { content: quantity.to_s, align: :center },
              { content: general_material.name.to_s || '' }
            ]
          end
          pdf.table(table_data) {}
          pdf.move_down margin_bottom + 6
        end
        # Specific materials section
        text_html_group.call 'Materiais específicos', activity.specific_materials unless activity.specific_materials.blank?
        #  Implementation tips section
        text_html_group.call 'Dicas sobre a implementação', activity.implementation_tips, 'html' unless activity.implementation_tips.blank?
        # Reflection assessment  section
        text_html_group.call 'Reflexão e avaliação', activity.reflection_assessment, 'html' unless activity.reflection_assessment.blank?
        # Duration section
        text_html_group.call 'Duração', activity.duration unless activity.duration.blank?
        # Inspirations section
        list_group.call 'Atividades inspiradoras', activity.inspirations unless activity.inspirations.blank?
        # References section
        text_html_group.call 'Referências externas', activity.references, 'html' unless activity.references.blank?
        # # Activity type section
        # text_html_group.call 'Tipo de atividade', activity.activity_type[0..-2].capitalize unless activity.activity_type.blank?
        # External link section
        text_html_group.call 'Link externo', activity.external_link unless activity.external_link.blank?
        
        # Creating Header and Footer
        pdf.page_count.times do |i|
          pdf.go_to_page i + 1
          pdf.bounding_box([pdf.bounds.left, pdf.bounds.top + 76], width: pdf.bounds.width) do
            pdf.image "#{Rails.root}/public/mit_logo_green.jpg", width: 450, position: :center
          end
          pdf.bounding_box([pdf.bounds.left - 72, pdf.bounds.bottom - 6], width: pdf.bounds.width + 120, height: 24) do
            pdf.rectangle [0, pdf.bounds.bottom + 24], pdf.bounds.width, 24
            pdf.fill_color(primary_color)
            pdf.fill
            pdf.text (i + 1).to_s, align: :center, valign: :center, size: 9, style: :bold, color: 'ffffff'
          end
        end

        # pdf.render_file("public/#{activity.updated_at.strftime('%Y%m%dT%H%M')}_#{activity.id}.pdf")
        pdf.render_file("public/#{activity.id}.pdf")
      end
    end
  end
end
