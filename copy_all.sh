cp ~/dotfiles/.zshrc ../.zshrc
cp ~/dotfiles/.zgen ../.zgen
for file in .config/* ; do
	cp ~/dotfiles/${file} ../${file}
done
