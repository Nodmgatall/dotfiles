ln -s ~/dotfiles/.zshrc ../.zshrc
ln -s ~/dotfiles/.zgen ../.zgen
for file in .config/* ; do
	ln -s ~/dotfiles/${file} ../${file}
	echo ${file}
done
