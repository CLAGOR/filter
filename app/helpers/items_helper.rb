module ItemsHelper
  def nested_items(items)
    ret = ""
    items.map do |item, sub_items|
      if @filter_by.present?
        if (item.name.include? @filter_by) || (item.descendants.any? { |d| d.name.include? @filter_by })
          ret += "<li>#{highlight(item.name)}"
          ret += "<ul>#{nested_items(sub_items)}</ul>" if item.descendants.any? { |d| d.name.include? @filter_by }
          ret += "</li>"
        end
      else
        ret += "<li>#{item.name}"
        ret += "<ul>#{nested_items(sub_items)}</ul>" if item.descendants.present?
        ret += "</li>"
      end
    end if items
    ret.present? ? ret.html_safe : "Hľadaný reťazec sa nenašiel"
  end

  def highlight(item_name)
    item_name.include?(@filter_by) ? (item_name.sub! "#{@filter_by}", "<strong>#{@filter_by}</strong>") : item_name
  end
end
