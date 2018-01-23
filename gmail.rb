require 'gmail'
require 'pry'
require 'dotenv'

Dotenv.load

#ENV['nomdelavariable']
username = ENV['username']
password = ENV['password']

#binding.pry

gmail = Gmail.connect!(username, password)

#puts gmail.inbox.count
gmail.deliver do
  to "email_martinique"
  subject "Apprendre ensemble: The Hacking Projetc !"
  text_part do
      body "Text of plaintext message."
  end
  html_part do
    content_type 'text/html; charset=UTF-8'
    body "<p> Bonjour,
</br> Je m'appelle Béa, je suis élève à une formation de code gratuite, ouverte à tous, sans restriction géographique, ni restriction de niveau.
</br> La formation s'appelle <strong> The Hacking Project </strong> (http://thehackingproject.org/).
</br> Nous apprenons l'informatique via la méthode du <em> peer-learning </em> : nous faisons des projets concrets qui nous sont assignés tous les jours, sur lesquel nous planchons en petites équipes autonomes.
</br> Le projet du jour est d'envoyer des emails à nos élus locaux pour qu'ils nous aident à faire de The Hacking Project un nouveau format d'éducation gratuite.

Nous vous contactons pour vous parler du projet, et vous dire que vous pouvez ouvrir une cellule à {townhall_name}, où vous pouvez former gratuitement 6 personnes (ou plus), qu'elles soient débutantes, ou confirmées.
</br> Le modèle d'éducation de The Hacking Project n'a pas de limite en terme de nombre de moussaillons (c'est comme cela que l'on appelle les élèves), donc nous serions ravis de travailler avec {townhall_name} !

Charles, co-fondateur de The Hacking Project pourra répondre à toutes vos questions : 06.95.46.60.80.
Sinon vous pouvez également répondre à mon mail et je m'occuperai de vous mettre en contact.
</br> Le développement informatique a beaucoup d'avenir !
</br> Grâce à The Hacking Project, permettez à vos cioyens de se découvrir une passion pour le code :)

</br> Je vous souhaite une excellente après-midi !

</br> Bien cordialement,

</br> Béa

    </p>"
  end
end




def send_email_to_line()

  # get les emails qui sont dans ma colonne B
  # get les noms des villes qui sont dans ma colonne A


ws [1, 2] = email_martinique
ws [1, 1] = townhall_name

end

def go_through_all_the_lines()

  (1..ws.num_rows).each do |row|   # pour chaque ligne débutant de 1 à ...
    (1..ws.num_cols).each do |col|   # pour chaque col débutant de 1 à ...
      return ws[row, col]   # afficher
    end
  end
end


def get_the_email_html()

end
