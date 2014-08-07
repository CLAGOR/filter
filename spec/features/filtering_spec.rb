require 'rails_helper'

feature "filtering" do
  before(:all) do 
    FactoryGirl.reload 
  end
  before(:each) do
    create(:item_lvl3)
    create(:item)
  end  

  scenario "user submits form with a matching parameter" do
    visit "/"
    within("form") do
      fill_in 'filter_by', :with => "1" 
    end
    click_button 'hľadať'

    expect(page).to have_content(/(foo3)(foo2)(foo1)/)
    expect(page).to_not have_content 'foo4'
  end
  
  scenario "user submits form with a non-matching parameter" do
    visit "/"
    within("form") do
      fill_in 'filter_by', :with => "z" 
    end
    click_button 'hľadať'

    expect(page).to have_content 'Hľadaný reťazec sa nenašiel'
    expect(page).to_not have_content 'foo'
  end
end