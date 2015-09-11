require 'ship'

describe Ship do

  it 'ship has health which is equal to its size' do
    expect(subject.size).to eq(subject.health)
  end

  it 'loses a life when it gets shot' do
    health = subject.health
    subject.hit
    expect(subject.health).to eq(health-1)
  end

  it 'tells us when it\'s dead' do
    expect{subject.hit}.to output("You sunk my battleship!\n").to_stdout
  end

end
