# encoding: utf-8

def check_page(url, title = nil)
  visit url
  page.status_code.should be 200
  if title.present?
    i_should_see title
  end
end
