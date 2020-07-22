module FormHelper

  def panel(&block)
    capture_haml do
      haml_tag "div", class: "panel panel-default" do
        block.call
      end
    end
  end

  def heading(title = "", &block)
    capture_haml do
      haml_tag "div", class: "panel-heading" do
        if title.present?
          haml_tag "div", class: "pull-right" do
            block.call if block_given?
          end
          haml_tag "h2", title, class: "panel-title"
          haml_tag "div", "", class: "clearfix"
        else
          block.call if block_given?
        end
      end
    end
  end

  def body(&block)
    capture_haml do
      haml_tag "div", class: "panel-body" do
        block.call
      end
    end
  end

  def actions(&block)
    capture_haml do
      haml_tag "div", class: "panel-footer" do
        haml_tag "div", class: "col-sm-offset-3 pull-right" do
          block.call
        end
        haml_tag "div", class: "clearfix"
      end
    end
  end

  def footer(&block)
    capture_haml do
      haml_tag "div", class: "panel-footer" do
        block.call
      end
    end
  end

  def fieldset(legend, &block)
    capture_haml do
      haml_tag "fieldset" do
        haml_tag "legend", legend
        block.call
      end
    end
  end

end
