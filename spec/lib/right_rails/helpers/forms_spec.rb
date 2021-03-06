require File.dirname(__FILE__) + "/../../../spec_helper.rb"

describe RightRails::Helpers::Forms do
  include ActionView::Helpers::TagHelper
  include ActionView::Helpers::FormTagHelper
  include ActionView::Helpers::JavaScriptHelper
  include RightRails::Helpers::Basic
  include RightRails::Helpers::Forms

  def url_for(options)   options end
  def escape_javascript(str) str end
  def rightjs_required_files
    RightRails::Helpers.required_js_files(self)
  end

  before :each do
    RightRails::Config.reset!
  end

  describe ".calendar_field" do
    it "should generate a basic calendar_field_tag" do
      calendar_field_tag('name', 'value').should ==
        %Q{<input data-calendar="{}" id="name" name="name" type="text" value="value" />}

      rightjs_required_files.should include('right/calendar')
    end

    it "should generate a calendar_field_tag with options" do
      calendar_field_tag('name', 'value', :format => '%Y/%m/%d').should ==
        %Q{<input data-calendar="{format:'%Y/%m/%d'}" id="name" }+
          %Q{name="name" type="text" value="value" />}
    end

    it "should generate a basic calendar_field" do
      calendar_field('model', 'method').should ==
        %Q{<input data-calendar="{}" id="model_method" name="model[method]" size="30" type="text" />}
    end

    it "should generate a calendar_field with options" do
      calendar_field('model', 'method', :hide_on_pick => true).should ==
        %Q{<input data-calendar="{hideOnPick:true}" id="model_method" }+
          %Q{name="model[method]" size="30" type="text" />}
    end

    describe "in RightJS 1 mode" do
      before :each do
        RightRails::Config.rightjs_version = 1
      end

      it "should generate a basic calendar_field_tag" do
        calendar_field_tag('name', 'value').should ==
          %Q{<input id="name" name="name" rel="calendar" type="text" value="value" />}

        rightjs_required_files.should include('right/calendar')
      end

      it "should generate a calendar_field_tag with options" do
        calendar_field_tag('name', 'value', :format => '%Y/%m/%d').should ==
          %Q{<input data-calendar-options="{format:'%Y/%m/%d'}" id="name" name="name" }+
            %Q{rel="calendar" type="text" value="value" />}
      end

      it "should generate a basic calendar_field" do
        calendar_field('model', 'method').should ==
          %Q{<input id="model_method" name="model[method]" rel="calendar" size="30" type="text" />}
      end

      it "should generate a calendar_field with options" do
        calendar_field('model', 'method', :hide_on_pick => true).should ==
          %Q{<input data-calendar-options="{hideOnPick:true}" id="model_method" }+
            %Q{name="model[method]" rel="calendar" size="30" type="text" />}
      end
    end
  end

  describe ".autocomplete_field" do
    it "should generate a basic autocomplete_field_tag" do
      autocomplete_field_tag('name', 'value', :url => '/foo').should ==
        %Q{<input autocomplete="off" data-autocompleter="{url:'/foo'}" id="name" name="name" type="text" value="value" />}

      rightjs_required_files.should include('right/autocompleter')
    end

    it "should generate an autocomplete_field_tag with options" do
      autocomplete_field_tag('name', 'value', :url => '/foo', :spinner => 'spinner', :min_length => 2).should ==
        %Q{<input autocomplete="off" data-autocompleter="{minLength:2,spinner:'spinner',url:'/foo'}" }+
          %Q{id="name" name="name" type="text" value="value" />}
    end

    it "should generate a basic autocomplete_field" do
      autocomplete_field('object', 'method', :url => '/foo').should ==
        %Q{<input autocomplete="off" data-autocompleter="{url:'/foo'}" id="object_method" name="object[method]" size="30" type="text" />}
    end

    it "should generate an autocomplete_field with options" do
      autocomplete_field('object', 'method', :url => '/foo', :fx_name => 'fade').should ==
        %Q{<input autocomplete="off" data-autocompleter="{fxName:'fade',url:'/foo'}" id="object_method" }+
          %Q{name="object[method]" size="30" type="text" />}
    end

    describe "in RightJS 1 mode" do
      before :each do
        RightRails::Config.rightjs_version = 1
      end

      it "should generate a basic autocomplete_field_tag" do
        autocomplete_field_tag('name', 'value', :url => '/foo').should ==
          %Q{<input autocomplete="off" id="name" name="name" rel="autocompleter[/foo]" type="text" value="value" />}

        rightjs_required_files.should include('right/autocompleter')
      end

      it "should generate an autocomplete_field_tag with options" do
        autocomplete_field_tag('name', 'value', :url => '/foo', :spinner => 'spinner', :min_length => 2).should ==
          %Q{<input autocomplete="off" data-autocompleter-options="{minLength:2,spinner:'spinner'}" }+
            %Q{id="name" name="name" rel="autocompleter[/foo]" type="text" value="value" />}
      end

      it "should generate a basic autocomplete_field" do
        autocomplete_field('object', 'method', :url => '/foo').should ==
          %Q{<input autocomplete="off" id="object_method" name="object[method]" rel="autocompleter[/foo]" size="30" type="text" />}
      end

      it "should generate an autocomplete_field with options" do
        autocomplete_field('object', 'method', :url => '/foo', :fx_name => 'fade').should ==
          %Q{<input autocomplete="off" data-autocompleter-options="{fxName:'fade'}" id="object_method" }+
            %Q{name="object[method]" rel="autocompleter[/foo]" size="30" type="text" />}
      end
    end
  end

  describe ".slider" do

    it "should generate a basic slider_tag" do
      slider_tag('some_field', 22).should ==
        %Q{<input id="some_field" name="some_field" type="hidden" value="22" />\n}+
          %Q{<script type="text/javascript">\n//<![CDATA[\n}+
            %Q{new Slider({value:22}).insertTo('some_field','after').assignTo('some_field');\n}+
          %Q{//]]>\n}+
        %Q{</script>}
    end

    it "should generate a slider_tag with options" do
      slider_tag('some_field', 22, :min => 10, :max => 40).should ==
        %Q{<input id="some_field" name="some_field" type="hidden" value="22" />\n}+
          %Q{<script type="text/javascript">\n//<![CDATA[\n}+
            %Q{new Slider({max:40,min:10,value:22}).insertTo('some_field','after').assignTo('some_field');\n}+
          %Q{//]]>\n}+
        %Q{</script>}
    end

    it "should generate a slider with options" do
      model = {}
      model.should_receive('method').twice.and_return(22)
      should_receive(:instance_variable_get).twice.with('@object').and_return(model)

      slider('object', 'method', :value => 22, :min => 20, :max => 80).should ==
        %Q{<input id="object_method" name="object[method]" type="hidden" value="22" />\n}+
          %Q{<script type="text/javascript">\n//<![CDATA[\n}+
            %Q{new Slider({max:80,min:20,value:22}).insertTo('object_method','after').assignTo('object_method');\n}+
          %Q{//]]>\n}+
        %Q{</script>}
    end
  end

  describe ".rater" do
    it "should generate a simple rater" do
      model = {}
      model.should_receive('method').twice.and_return(2)
      should_receive(:instance_variable_get).twice.with('@object').and_return(model)

      rater('object', 'method', :value => 2).should ==
        %Q{<input id="object_method" name="object[method]" type="hidden" value="2" />\n}+
        %Q{<script type="text/javascript">\n//<![CDATA[\n}+
          %Q{new Rater({value:2}).insertTo('object_method','after').assignTo('object_method');\n}+
        %Q{//]]>\n</script>}
    end

    it "should generate a #rater_tag" do
      rater_tag('some_field', 2).should ==
        %Q{<input id="some_field" name="some_field" type="hidden" value="2" />\n}+
        %Q{<script type="text/javascript">\n//<![CDATA[\n}+
          %Q{new Rater({value:2}).insertTo('some_field','after').assignTo('some_field');\n}+
        %Q{//]]>\n</script>}
    end

    it "should generate the #rater_display tag" do
      rater_display(4).should ==
        %Q{<div class="rui-rater rui-rater-disabled">}+
          %Q{<div class="active">&#9733;</div>}+
          %Q{<div class="active">&#9733;</div>}+
          %Q{<div class="active">&#9733;</div>}+
          %Q{<div class="active">&#9733;</div>}+
          %Q{<div>&#9733;</div>}+
        %Q{</div>}
    end

    describe "in RightJS 1 mode" do
      before :each do
        RightRails::Config.rightjs_version = 1
      end

      it "should generate the #rater_display tag" do
        rater_display(4).should ==
          %Q{<div class="right-rater right-rater-disabled">}+
            %Q{<div class="right-rater-glow">&#9733;</div>}+
            %Q{<div class="right-rater-glow">&#9733;</div>}+
            %Q{<div class="right-rater-glow">&#9733;</div>}+
            %Q{<div class="right-rater-glow">&#9733;</div>}+
            %Q{<div>&#9733;</div>}+
          %Q{</div>}
      end
    end
  end

  describe ".colorpicker" do
    it "should generate a simple colorpicker_field_tag" do
      colorpicker_field_tag('name', '#FF0').should ==
        %Q{<input data-colorpicker="{}" id="name" name="name" type="text" value="#FF0" />}
    end

    it "should generate a colorpicker_field_tag with options" do
      colorpicker_field_tag('name', '#FF0', :format => 'rgb').should ==
        %Q{<input data-colorpicker="{format:'rgb'}" }+
          %Q{id="name" name="name" type="text" value="#FF0" />}
    end

    it "should generate a colorpicker_field with options" do
      colorpicker_field('object', 'method', :fx_name => 'slide').should ==
        %Q{<input data-colorpicker="{fxName:'slide'}" id="object_method" }+
          %Q{name="object[method]" size="30" type="text" />}
    end

    describe "in RightJS 1 mode" do
      before :each do
        RightRails::Config.rightjs_version = 1
      end

      it "should generate a simple colorpicker_field_tag" do
        colorpicker_field_tag('name', '#FF0').should ==
          %Q{<input id="name" name="name" rel="colorpicker" type="text" value="#FF0" />}
      end

      it "should generate a colorpicker_field_tag with options" do
        colorpicker_field_tag('name', '#FF0', :format => 'rgb').should ==
          %Q{<input data-colorpicker-options="{format:'rgb'}" }+
            %Q{id="name" name="name" rel="colorpicker" type="text" value="#FF0" />}
      end

      it "should generate a colorpicker_field with options" do
        colorpicker_field('object', 'method', :fx_name => 'slide').should ==
          %Q{<input data-colorpicker-options="{fxName:'slide'}" id="object_method" }+
            %Q{name="object[method]" rel="colorpicker" size="30" type="text" />}
      end
    end
  end

  describe ".tags_field" do
    it "should automatically require the 'right/tags.js' file" do
      tags_field_tag('name', 'one,two,three')
      rightjs_required_files.should include('right/tags')
    end

    it "should generate a simple tags_field_tag" do
      tags_field_tag('name', 'one,two,three').should ==
        %Q{<input data-tags="{}" id="name" name="name" type="text" value="one,two,three" />}
    end

    it "should generate a tags_field_tag with options" do
      tags_field_tag('name', 'one,two,three', {
        :tags => ['one', 'two', 'three'],
        :allow_new => false
      }).should ==
        %Q{<input data-tags="{allowNew:false,tags:[&quot;one&quot;, &quot;two&quot;, &quot;three&quot;]}" }+
          %Q{id="name" name="name" type="text" value="one,two,three" />}
    end

    it "should generate a tags_field with options" do
      tags_field('object', 'method', {:tags => ['one', 'two', 'three']}).should ==
        %Q{<input data-tags="{tags:[&quot;one&quot;, &quot;two&quot;, &quot;three&quot;]}" } +
          %Q{id="object_method" name="object[method]" size="30" type="text" />}
    end
  end

  describe ".rte_field" do
    it "should automatically require the 'right/rte.js' file" do
      rte_field_tag('name', 'some text')
      rightjs_required_files.should include('right/rte')
    end

    it "should generate a simple rte_field_tag" do
      rte_field_tag('name', 'some text').should ==
        %Q{<textarea data-rte="{}" id="name" name="name">some text</textarea>}
    end

    it "should generate a rte_field_tag with options" do
      rte_field_tag('name', 'some text', {
        :toolbar => 'extra'
      }).should ==
        %Q{<textarea data-rte="{toolbar:'extra'}" id="name" name="name">some text</textarea>}
    end

    it "should generate a rte_field with options" do
      rte_field('object', 'method', {:toolbar => 'basic'}).should ==
        %Q{<textarea cols="40" data-rte="{toolbar:'basic'}" id="object_method" } +
          %{name="object[method]" rows="20"></textarea>}
    end
  end


end