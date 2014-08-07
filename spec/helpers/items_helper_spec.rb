require 'rails_helper'

describe ItemsHelper do  
  before(:all) do 
    FactoryGirl.reload 
  end
  describe "nested_items" do
    it "returns something" do
      expect(helper.nested_items(Item.scoped)).to eql "Hľadaný reťazec sa nenašiel"
    end

    context "has items" do
      before(:each) do 
        create(:item_lvl3)
        create(:item)
        @items = Item.scoped.arrange
      end  
      it "returns a list of items" do
        items_list = helper.nested_items(@items)
        expect(items_list).to match list_item(0, "foo3")
        expect(items_list).to match list_item(1, "foo2")
        expect(items_list).to match list_item(2, "foo1")
        expect(items_list).to match list_item(0, "foo4")
      end
      context "returns a list of filtered items" do
        it "with descendants" do
          assign(:filter_by, "5")
          items_list = helper.nested_items(@items)
          expect(items_list).to match list_item(0, "foo7")
          expect(items_list).to match list_item(1, "foo6")
          expect(items_list).to match list_item(2, "foo<strong>5</strong>")
          expect(items_list).to_not match list_item(0, "foo8")
        end
        it "without descendants" do
          assign(:filter_by, "12")
          items_list = helper.nested_items(@items)
          expect(items_list).to_not match list_item(0, "foo11")
          expect(items_list).to_not match list_item(1, "foo10")
          expect(items_list).to_not match list_item(2, "foo9")
          expect(items_list).to match list_item(0, "foo<strong>12</strong>")
        end
      end  
    end  
  end
  describe "highlight" do
    it "returns highlighted results" do
      assign(:filter_by, "5")
      expect(helper.highlight("foo5")).to eql "foo<strong>5</strong>"
    end
  end  
end

def list_item(depth, name)
  /(.*?<ul>){#{depth}}<li>#{name}/
end
