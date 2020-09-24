class Hardness < ActiveHash::Base
  self.data = [
    { id: 1, name: '--' },
    { id: 2, name: '軟らかい（ソフト）' },
    { id: 3, name: 'やや軟らかい（セミソフト）' },
    { id: 4, name: '平均的な硬さ（ミドル）' },
    { id: 5, name: 'やや硬い（セミハード）' },
    { id: 6, name: '硬い（ハード）' }
  ]
end
