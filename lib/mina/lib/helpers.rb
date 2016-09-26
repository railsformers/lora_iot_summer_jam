module Mina
  module Helpers

    # Creates a file on the server with the given content
    #
    # put("This is my file", "/tmp/file")
    #
    def put(content, target_file)
      queue! <<-CMD
      OLDIFS=$IFS
      IFS='' read -r -d '' MINA_PUT <<"EOF"
#{content}
EOF
      echo "$MINA_PUT" > #{target_file}
      IFS=$OLDIFS
      CMD
    end

    # Renders a template and uploads it to the server.
    # Defaults to an ERB template.
    #
    # render("templates/my_template.erb", "/tmp/file")
    #
    def render(template_file, target_file, renderer=method(:erb))
      queue %[echo "Render '#{template_file.split('/').last}' and put them to '#{target_file}'"]
      put(renderer.call(template_file), target_file)
    end

  end
end
