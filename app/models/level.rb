class Level < ActiveHash::Base
  self.data = [
    { id: 1, name: '--' },
    { id: 2, name: '初心者' },
    { id: 3, name: '初級者' },
    { id: 4, name: '市大会上位選手' },
    { id: 5, name: '県大会上位選手' },
    { id: 6, name: '全国大会出場者' },
    { id: 7, name: '全国大会上位選手' }
  ]
end
