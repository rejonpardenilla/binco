module Binco
  class BootstrapFormBuilder < ActionView::Helpers::FormBuilder
    alias_method :collection_select_original, :collection_select
    alias_method :select_original, :select
    alias_method :check_box_group, :form_check 

    def text_field(name, options = {})
      options = add_class_to_options('form-control', options)
      super name, options
    end

    def telephone_field(name, options = {})
      options = add_class_to_options('form-control', options)
      super name, options
    end

    def select(method, choices = nil, options = {}, html_options = {}, &block)
      html_options = add_class_to_options('custom-select', html_options)
      super method, choices, options, html_options, &block
    end

    def select2(method, choices = nil, options = {}, html_options = {}, &block)
      html_options = add_class_to_options('select2-rails', html_options)
      select_original method, choices, options, html_options, &block
    end

    def collection_check_boxes(method, collection, value_method, text_method, options = {}, html_options = {}, &block)
      if block_given?
        super(method, collection, value_method, text_method, options, html_options, &block)
      else
        super method, collection, value_method, text_method, options, html_options do |b|
          group_tag class: 'checkbox' do
            b.label do
              b.check_box + b.text
            end
          end
        end
      end
    end

    # Since select2 support multiple choices (checkboxes)
    def collection_check_boxes2(method, collection, value_method, text_method, options = {}, html_options = {})
      html_options ||= {}
      html_options[:multiple] = 'multiple'
      collection_select2 method, collection, value_method, text_method, options, html_options
    end

    def collection_select(method, collection, value_method, text_method, options = {}, html_options = {})
      html_options = add_class_to_options('custom-select', html_options)
      super method, collection, value_method, text_method, options, html_options
    end

    def collection_select2(method, collection, value_method, text_method, options = {}, html_options = {}, &block)
      html_options = add_class_to_options('select2-rails', html_options)
      collection_select_original(method, collection, value_method, text_method, options, html_options)
    end

    def email_field(name, options = {})
      options = add_class_to_options('form-control', options)
      super name, options
    end

    def number_field(name, options = {})
      options = add_class_to_options('form-control', options)
      super name, options
    end

    def password_field(name, options = {})
      options = add_class_to_options('form-control', options)
      super name, options
    end

    def datepicker(method, options = {})
      options = add_data_to_options({ provide: 'datepicker' }, options)
      text_field(method, options)
    end

    def text_area(method, options = {})
      options = add_class_to_options('form-control', options)
      super(method, options)
    end

    def radio_button(method, tag_value, options = {})
      super method, tag_value, options
    end

    def check_box(method, options = {}, checked_value = "1", unchecked_value = "0")
      options = add_class_to_options('form-check-input', options)
      super method, options, checked_value, unchecked_value
    end

    def file_field(method, options = {})
      options = add_class_to_options('form-control-file', options)
      super method, options
    end

    def submit(value = nil, options = {})
      options = add_class_to_options('btn btn-success', options)
      add_data_to_options({ disable_with: 'Enviando' }, options)
      super value, options
    end

    def form_group(options = {}, &block)
      options = add_class_to_options('form-group', options)
      group_tag options, &block
    end

    def radio_group(options = {}, &block)
      options = add_class_to_options('radio', options)
      group_tag options, &block
    end

    def form_check(options = {}, &block)
      options = add_class_to_options('form-check', options)
      group_tag options, &block
    end

    def check_label(options = {}, &block)
      options = add_class_to_options('form-check', options)
      @template.content_tag :label, options do
        yield
      end
    end

    def input_group(options = {}, &block)
      options = add_class_to_options('input-group', options)
      group_tag options, &block
    end

    def addon(icon, options = {})
      options = add_class_to_options('input-group-addon', options)
      @template.content_tag(:span, icon, options)
    end

    private

      # Add the specified class_name the the options hash
      def add_class_to_options(class_name, options = {})
        options[:class] ||= ''
        options[:class] << " #{class_name}"
        options
      end

      # Add the specified data-attributes the the options hash
      def add_data_to_options(data, options = {})
        options[:data] ||= {}
        options[:data].merge! data
        options
      end

      def group_tag(attributes = {}, &block)
        @template.content_tag :div, attributes do
          yield
        end
      end
  end
end
