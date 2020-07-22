# encoding: utf-8

def write_a_comment
  i_should_see "Kommentare"

  within first(".new_comment") do
    # page.execute_script("$('#comment_body').html('Ey caramba')")
    fill_in "#comment_body", with: "Ey caramba"
    click_on "Kommentar speichern"
  end
  within find(:css, ".comments") do
    i_should_see "Ey caramba"
  end
end
