# vimnastics

Launch point: [kickstart](https://github.com/nvim-lua/kickstart.nvim)

---

backup
`mv ~/config/nvim ~/config/nvim.bak`
`mv ~/.local/share/nvim/ ~/.local/share/nvim.bak`

clean
`rm -rf ~/.config/nvim`
`rm ~/.local/share/nvim`

get
`cd ~/whatever/you/want`
`git clone https://github.com/sagmansercan/vimnastics.git`

link
Since ln -s requires full resolved path and doesn't work with tilde.
`ln -s /Users/username/whatever/you/want /Users/username/config/nvim`

or use eval, readlink etc. with paths with tilde for above command.
or directly clone repository into default nvim config dir and rename it.
