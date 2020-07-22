def i_should_see(value)
  expect(page).to have_content value.to_s
end

def i_should_not_see(value)
  expect(page).to_not have_content value.to_s
end

def click_first_link(text)
  page.first('a', text: text).click
end

def click_on_first(text)
  click_first_link text
end
