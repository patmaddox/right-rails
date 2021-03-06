#
# RightJS specific form features module
#
module RightRails::Helpers::Forms

  #
  # Generates the calendar field tag
  #
  # The options might contain the usual html options along with the RightJS Calendar options
  #
  def calendar_field_tag(name, value=nil, options={})
    text_field_tag name, value, Util.calendar_options(self, options)
  end

  #
  # The form_for level calendar field generator
  #
  def calendar_field(object_name, method, options={})
    options = Util.calendar_options(self, options)

    tag = ActionView::Helpers::InstanceTag.new(
      object_name, method, self, options.delete(:object))
    tag.to_calendar_field_tag(options)
  end

  #
  # Autocompletion field tag
  #
  # The options should contain an url or a list of local options
  #
  def autocomplete_field_tag(name, value, options)
    text_field_tag name, value, Util.autocompleter_options(self, options)
  end

  #
  # The form_for level autocomplete-field generator
  #
  def autocomplete_field(object_name, method, options)
    options = Util.autocompleter_options(self, options)

    tag = ActionView::Helpers::InstanceTag.new(
      object_name, method, self, options.delete(:object))
    tag.to_autocomplete_field_tag(options)
  end

  alias_method :autocompleter_field,     :autocomplete_field
  alias_method :autocompleter_field_tag, :autocomplete_field_tag

  #
  # The slider widget generator
  #
  def slider_tag(name, value, options={})
    hidden_field_tag(name, value, Util.slider_options(self, options)) +
      "\n" + Util.slider_generator(self, name, value, options)
  end

  #
  # The form_for level slider widget generator
  #
  def slider(object_name, method, options={})
    object = options.delete(:object)
    ActionView::Helpers::InstanceTag.new(object_name, method, self, object
      ).to_slider_tag(Util.slider_options(self, options)) + "\n" +
      Util.slider_generator(self, object_name, nil, options, method)
  end

  #
  # The rater widget basic generator
  #
  def rater_tag(name, value, options={})
    hidden_field_tag(name, value, Util.rater_options(self, options)) +
      "\n" + Util.rater_generator(self, name, value, options)
  end

  #
  # The form level rater generator
  #
  def rater(object_name, method, options={})
    object = options.delete(:object)
    ActionView::Helpers::InstanceTag.new(object_name, method, self, object
      ).to_rater_tag(Util.rater_options(self, options)) +
      "\n" + Util.rater_generator(self, object_name, nil, options, method)
  end

  #
  # Builds a dummy rater, just for displaying purposes
  #
  def rater_display(value, options={})
    rightjs_require_module 'rater'

    content_tag :div, RightRails::Helpers.html_safe((0...(options[:size] || 5)).to_a.collect{ |i|
      content_tag :div, RightRails::Helpers.html_safe('&#9733;'),
        :class => i < value ? RightRails::Config.rightjs_version < 2 ? "right-rater-glow" : "active" : nil
    }.join('')), :class => "#{RightRails::Helpers.css_prefix}-rater #{RightRails::Helpers.css_prefix}-rater-disabled"
  end

  #
  # a standalone colorpicker field tag
  #
  def colorpicker_field_tag(name, value, options={})
    text_field_tag name, value, Util.colorpicker_options(self, options)
  end

  #
  # A colorpicker field for a form
  #
  def colorpicker_field(object_name, method, options={})
    options = Util.colorpicker_options(self, options)

    ActionView::Helpers::InstanceTag.new(
      object_name, method, self, options.delete(:object)
    ).to_colorpicker_field_tag(options)
  end

  #
  # a standalone tags field tag
  #
  def tags_field_tag(name, value, options={})
    text_field_tag name, value, Util.tags_options(self, options)
  end

  #
  # a tags-field for a form
  #
  def tags_field(object_name, method, options={})
    options = Util.tags_options(self, options)

    ActionView::Helpers::InstanceTag.new(
      object_name, method, self, options.delete(:object)
    ).to_tags_field_tag(options)
  end

  #
  # a standalone RTE field tag
  #
  def rte_field_tag(name, value, options={})
    text_area_tag name, value, Util.rte_options(self, options)
  end

  #
  # a rte-field for a form
  #
  def rte_field(object_name, method, options={})
    options = Util.rte_options(self, options)

    ActionView::Helpers::InstanceTag.new(
      object_name, method, self, options.delete(:object)
    ).to_rte_field_tag(options)
  end

private

  #
  # Local utility methods, just hidding the things in here
  # so they didn't pollute the global scope
  #
  module Util

    class << self
      #
      # Requires RightJS modules in the given context
      #
      def require_modules(context, *list)
        RightRails::Helpers.require_js_module context, *list
      end

      #
      # Preprocesses the RightJS module options
      #
      def unit_options(options, unit)
        RightRails::Helpers.add_unit_options(options, unit)
      end

      #
      # Checks if we are in the RightJS 1 mode
      #
      def in_rightjs_1
        RightRails::Config.rightjs_version < 2
      end

      #
      # Prepares a list of options for the calendar widget
      #
      def calendar_options(context, options={})
        require_modules(context, 'calendar')
        unit_options(options, 'calendar').merge(in_rightjs_1 ? {:rel => 'calendar'} : {})
      end

      #
      # Prepares the autocompleter field options hash
      #
      def autocompleter_options(context, options={})
        require_modules(context, 'autocompleter')

        options[:url] = context.escape_javascript(context.url_for(options[:url]))

        url = options.delete(:url) if in_rightjs_1

        options = unit_options(options, 'autocompleter').merge({:autocomplete => 'off'})
        options.merge!({:rel => "autocompleter[#{url}]"})  if in_rightjs_1

        options
      end

      #
      # Prepares the list of slider options
      #
      def slider_options(context, options)
        require_modules context, 'dnd', 'slider'
        RightRails::Helpers.remove_unit_options(options, 'slider')
      end

      #
      # Generates the slider initialization script
      #
      def slider_generator(context, name, value, options, method=nil)
        value ||= ActionView::Helpers::InstanceTag.value_before_type_cast(
          context.instance_variable_get("@#{name}"), method.to_s ) if method
        name    = "#{name}[#{method}]" if method
        id      = options[:id] || context.send(:sanitize_to_id, name)
        options = RightRails::Helpers.unit_options(options.merge(:value => value), 'slider')
        context.javascript_tag "new Slider(#{options}).insertTo('#{id}','after').assignTo('#{id}');"
      end

      #
      # Prepares the rater widget options
      #
      def rater_options(context, options)
        require_modules context, 'rater'
        RightRails::Helpers.remove_unit_options(options, 'rater')
      end

      #
      # Generates the rater initialization script
      #
      def rater_generator(context, name, value, options, method=nil)
        value ||= ActionView::Helpers::InstanceTag.value_before_type_cast(
          context.instance_variable_get("@#{name}"), method.to_s) if method
        name    = "#{name}[#{method}]" if method
        id      = options[:id] || context.send(:sanitize_to_id, name)
        options = RightRails::Helpers.unit_options(options.merge(:value => value), 'rater')
        context.javascript_tag "new Rater(#{options}).insertTo('#{id}','after').assignTo('#{id}');"
      end

      #
      # Prepares the Colorpicker widget options
      #
      def colorpicker_options(context, options)
        require_modules context, 'colorpicker'
        unit_options(options, 'colorpicker').merge(in_rightjs_1 ? {:rel => 'colorpicker'} : {})
      end

      #
      # Prepares the Tags widget options
      #
      def tags_options(context, options)
        require_modules context, 'tags'
        unit_options(options, 'tags').merge(in_rightjs_1 ? {:rel => 'tags'} : {})
      end

      #
      # Prepares the RTE widget options
      #
      def rte_options(context, options)
        require_modules context, 'rte'
        unit_options(options, 'rte')
      end
    end
  end


###################################################################################
#
# The ActiveView native form-builder extensions
#
###################################################################################

  module FormBuilderMethods
    def calendar_field(name, options={})
      @template.calendar_field(@object_name, name, objectify_options(options))
    end

    def autocomplete_field(name, options={})
      @template.autocomplete_field(@object_name, name, objectify_options(options))
    end

    def slider(name, options={})
      @template.slider(@object_name, name, objectify_options(options))
    end

    def rater(name, options={})
      @template.rater(@object_name, name, objectify_options(options))
    end

    def colorpicker_field(name, options={})
      @template.colorpicker_field(@object_name, name, objectify_options(options))
    end

    def tags_field(name, options={})
      @template.tags_field(@object_name, name, objectify_options(options))
    end

    def rte_field(name, options={})
      @template.rte_field(@object_name, name, objectify_options(options))
    end
  end

  module InstanceTagMethods
    def to_calendar_field_tag(options)
      options = options.stringify_keys

      # formatting the date/time value if the format is specified
      calendar_options = (options["data-calendar-options"] || options["data-calendar"])
      if !options["value"] && calendar_options
        format = calendar_options.scan(/format:('|")(.+?)\1/)
        time = value_before_type_cast(object)
        if time && time.respond_to?(:to_time) && format.size == 1
          options["value"] = time.to_time.strftime(format[0][1])
        end
      end

      to_input_field_tag('text', options)
    end

    def to_autocomplete_field_tag(options)
      to_input_field_tag('text', options)
    end

    def to_slider_tag(options)
      to_input_field_tag('hidden', options)
    end

    def to_rater_tag(options)
      to_input_field_tag('hidden', options)
    end

    def to_colorpicker_field_tag(options)
      to_input_field_tag('text', options)
    end

    def to_tags_field_tag(options)
      to_input_field_tag('text', options)
    end

    def to_rte_field_tag(options)
      to_text_area_tag(options)
    end
  end

  def self.included(base)
    ActionView::Helpers::FormBuilder.instance_eval{ include FormBuilderMethods }
    ActionView::Helpers::InstanceTag.instance_eval{ include InstanceTagMethods }
  end

end