module ApplicationHelper

  # Retourner un titre basé sur la page.
  def titre
    base_titre = "Simple App du Tutoriel Ruby on Rails"
    if @titre.nil?
      base_titre
    else
      "#{base_titre} | #{@titre}"
    end # end if else
  end # end def titre


  def logo
    image_tag("logo.png", :alt => "Application Exemple", :class => "round")
  end # end def logo

end # end module ApplicationHelper
