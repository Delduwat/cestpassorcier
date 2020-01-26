load("../src/wiki.rb")


def test_get_definition
	reponse = get_definition("Maverick")
	return reponse ==="Maverick provient de Samuel Augustus Maverick (en) (1803–1870), un éleveur texan à l'esprit indépendant. Par extension, il désigne toute personne qui possède ce trait de caractère et ne se conforme donc pas aux codes conventionnels. Il a été repris dans plusieurs domaines, pour différents usages."
end


def main
	puts "Test test_get_definition, result is %s"%test_get_definition().to_s
end


main()
