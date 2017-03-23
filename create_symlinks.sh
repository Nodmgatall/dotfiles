ln -s ~/dotfiles/.zshrc ../.zshrc
for file in .config/* ; do
	ln -s ~/dotfiles/${file} ../${file}
	echo ${file}
done
