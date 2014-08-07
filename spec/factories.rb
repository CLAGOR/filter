FactoryGirl.define do 
  factory :item do
    sequence(:name) { |n| "foo#{n}" }
  end  
  factory :item_lvl2, parent: :item do
    parent {create(:item)}
  end
  factory :item_lvl3, parent: :item_lvl2 do
    parent {create(:item_lvl2)}
  end 
end